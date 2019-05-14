#ifndef AVL_H
#define AVL_H

#include "static_alloc.h"

namespace util
{
	template <size_t elem_size>
	struct default_alloc {
		void *alloc() {
			return new uint8[elem_size];
		}
		void free(void *ptr) {
			delete [] (uint8 *)ptr;
		}
	};

	template <typename Key, typename Type>
	struct avl_data_t {
		Key key;
		Type data;

		avl_data_t (const Key &key, const Type &data)
				: key(key), data(data) {}

	};

	template <typename Key, typename Type>
	struct avl_node_t {
		avl_data_t<Key, Type> *data_ptr;
		avl_node_t<Key, Type> *left = NULL;
		avl_node_t<Key, Type> *right = NULL;
		bool must_free_data = true;
		int height = 0;
		
		Key &key() {
			return data_ptr->key;
		}

		Type &data() {
			return data_ptr->data;
		}

		bool is_left (avl_node_t<Key, Type> *node) {
			if (!node)
				return false;
			return node->left == this;
		}

		bool is_right (avl_node_t<Key, Type> *node) {
			if (!node)
				return false;
			return node->right == this;
		}

		void compute_height() {
			int left_h = left ? left->height : 0;
			int right_h = right ? right->height : 0;

			height = std::max(left_h, right_h) + 1;
		}

		int get_bal() {
			int left_h = left ? left->height : 0;
			int right_h = right ? right->height : 0;

			return left_h - right_h;
		}
	};

	template <typename Key, typename Type,
			typename NodeAlloc = default_alloc<sizeof(avl_node_t<Key, Type>)>,
			typename DataAlloc = default_alloc<sizeof(avl_data_t<Key, Type>)>>
	struct avl_tree_t {
		using node_t = avl_node_t<Key, Type>;
		using data_t = avl_data_t<Key, Type>;
		using node_alloc_t = NodeAlloc;
		using data_alloc_t = DataAlloc;

		NodeAlloc &node_alloc;
		DataAlloc &data_alloc;
		node_t *root = NULL;
		int count = 0;

		avl_tree_t (NodeAlloc &node_alloc, DataAlloc &data_alloc)
				: node_alloc(node_alloc), data_alloc(data_alloc)
		{}

		int insert (const Key &key, const Type &data) {
			node_t *to_insert = alloc(key, data);
			if (!to_insert)
				return -1;

			root = rec_insert(root, to_insert, key);
			return 0;
		}

		void remove (const Key &key) {
			root = rec_remove(root, key);
		}

		node_t *find (const Key &key) {
			return rec_find(root, key);
		}

		node_t *get_root() {
			return root;
		}

		node_t *get_min (node_t *node) {
			node_t *curr = node;
			while (curr && curr->left)
				curr = curr->left;
			return curr;
		}

		node_t *get_max (node_t *node) {
			node_t *curr = node;
			while (curr && curr->right)
				curr = curr->right;
			return curr;
		}

		int size() {
			return count;
		}

		void dbg_print() {
			rec_dbg_print(root);
		}

private:
		node_t *rec_insert (node_t *node, node_t *to_insert, const Key& key) {
			if (!node) {
				return to_insert;
			}

			if (key < node->key())
				node->left = rec_insert(node->left, to_insert, key);
			else if (key > node->key())
				node->right = rec_insert(node->right, to_insert, key);
			else {
				node->data() = to_insert->data();
				free_node(to_insert);
			}

			node->compute_height();
			node = balance_insert(node, key);
			return node;
		}

		node_t *rec_remove (node_t *node, const Key &key) {
			if (!node)
				return NULL;
			if (key < node->key())
				node->left = rec_remove(node->left, key);
			else if (key > node->key())
				node->right = rec_remove(node->right, key);
			else {
				if (!node->left && !node->right) {
					free_node(node);
					node = NULL;
				}
				else if (!node->left || !node->right) {
					node_t *tmp = node->left ? node->left : node->right;
					free_node(node);
					node = tmp;
				}
				else {
					node_t *tmp = get_min(node->right);
					data_alloc.free(node->data_ptr);
					count--;
					node->data_ptr = tmp->data_ptr;
					tmp->must_free_data = false;
					node->right = rec_remove(node->right, tmp->key());
				}
			}

			if (!node)
				return NULL;
			
			node->compute_height();
			node = balance_remove(node);
			return node;
		}

		node_t *rec_find (node_t *node, const Key &key) {
			if (!node)
				return NULL;
			if (key == node->key())
				return node;
			else if (key < node->key())
				return rec_find(node->left, key);
			else
				return rec_find(node->right, key);
		}

		node_t *alloc (const Key &key, const Type &data) {
			node_t *node;

			node = (node_t *)node_alloc.alloc();
			new (node) node_t();
			node->data_ptr = (data_t *)data_alloc.alloc();
			count++;
			new (node->data_ptr) data_t(key, data);

			return node;
		}

		void free_node (node_t *node) {
			if (!node)
				return ;
			if (node->data_ptr && node->must_free_data) {
				node->data_ptr->~data_t();
				data_alloc.free(node->data_ptr);
				count--;
			}
			node->~node_t();
			node_alloc.free(node);
		}

		node_t *right_rotate (node_t *node) {
			node_t *left = node->left;

			node->left = left->right;
			left->right = node;

			node->compute_height();
			left->compute_height();

			return left;
		}

		node_t *left_rotate (node_t *node) {
			node_t *right = node->right;

			node->right = right->left;
			right->left = node;

			node->compute_height();
			right->compute_height();

			return right;
		}

		void rec_dbg_print (node_t *node, int level = 0) {
			if (node) {
				rec_dbg_print(node->left, level + 1);

				for (int i = 0; i < level; ++i) {
					kprintf(":--");
				}
				kprintf("%s\n", node->key().c_str());

				rec_dbg_print(node->right, level + 1);
			}
			else {
				for (int i = 0; i < level; ++i) {
					kprintf(":--");
				}
				kprintf("|\n");
			}
		}

		int get_bal (node_t *node) {
			return node ? node->get_bal() : 0;
		}

		node_t *balance_remove (node_t *node) {
			int bal = node->get_bal();

			if (bal > 1 && get_bal(node->left) >= 0) {
				return right_rotate(node);
			}

			if (bal > 1 && get_bal(node->left) < 0) {
				node->left = left_rotate(node->left);
				return right_rotate(node);
			}

			if (bal < -1 && get_bal(node->right) <= 0) {
				return left_rotate(node);
			}

			if (bal < -1 && get_bal(node->right) > 0) {
				node->right = right_rotate(node->right);
				return left_rotate(node);
			}
			return node;
		}

		node_t *balance_insert (node_t *node, const Key& key) {
			int bal = node->get_bal();

			if (bal > 1 && node->left && key < node->left->key()) {
				return right_rotate(node);
			}

			if (bal < -1 && key > node->right->key())
				return left_rotate(node);

			if (bal > 1 && key > node->left->key()) {
				node->left = left_rotate(node->left);
				return right_rotate(node);
			}

			if (bal < -1 && key < node->right->key()) {
				node->right = right_rotate(node->right);
				return left_rotate(node);
			}

			return node;
		}
	};
}

#endif
