#ifndef STATIC_AVL_H
#define STATIC_AVL_H

#include "avl.h"
#include "static_alloc.h"

namespace util
{
	template <typename Key, typename T, size_t cnt>
	struct static_avl_t {
		using node_alloc_t = static_alloc_t<sizeof(avl_node_t<Key, T>), cnt>;
		using data_alloc_t = static_alloc_t<sizeof(avl_data_t<Key, T>), cnt>;
		using tree_t = avl_tree_t<Key, T, node_alloc_t, data_alloc_t>;

		node_alloc_t node_alloc;
		data_alloc_t data_alloc;
		tree_t tree;

		static_avl_t() : tree(node_alloc, data_alloc) {}

		void insert(const Key &key, const T &data) {
			tree.insert(key, data);
		}

		void remove(const Key &key) {
			tree.remove(key);
		}

		bool has (const Key &key) {
			return tree.find(key);
		}

		T &get (const Key &key) {
			return tree.find(key)->data();
		}

		T &get_min_val () {
			return tree.get_min(tree.get_root())->data();
		}

		T &get_max_val () {
			return tree.get_max(tree.get_root())->data();
		}

		Key &get_min_key () {
			return tree.get_min(tree.get_root())->key();
		}

		Key &get_max_key () {
			return tree.get_max(tree.get_root())->key();
		}

		bool empty() {
			return tree.size() == 0;
		}

		size_t size() {
			return tree.size();
		}
	};
}

#endif