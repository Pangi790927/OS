#ifndef ITERATOR_H
#define ITERATOR_H

/*
	Those types here are used only to enforce some types of iterator traits.
	Meaning that you get one of the examples bellow, depending of what kind
	of iterator you want, copy paste it where you need it and fill in the code.
	These abstract virtual functions are here to be sure you actually implement
	all the functions needed.
*/

/*
	for ranges you could use:
		iterator begin();
		iterator end();
		size_t size();
		typename iterator::Object& operator [] (int index);
		const typename iterator::Object& operator [] (int index) const;
*/

template <typename IteratorType, typename ObjectType>
struct Iterator {
	using IterT = IteratorType;
	using ObjT = ObjectType;

	virtual			IterT&	operator ++ ()			= 0;	// ++it
//	virtual	const	IterT&	operator ++ () const	= 0;	// ++it
	virtual			IterT	operator ++ (int)		= 0;	// it++
	virtual			ObjT&	operator *  ()			= 0;
	virtual const	ObjT&	operator *  () const	= 0;
	virtual			ObjT*	operator -> ()			= 0;
	virtual	const	ObjT*	operator -> () const	= 0;

	virtual					operator bool() const	= 0;

	virtual			bool	operator == (const IterT&) const	= 0;
	virtual			bool	operator != (const IterT&) const	= 0;
};

template <typename IteratorType, typename ObjectType>
struct BidirIt : Iterator<IteratorType, ObjectType> {
	using IterT = IteratorType;
	using ObjT = ObjectType;

	virtual			IterT&	operator -- ()			= 0;	// --it
//	virtual	const	IterT&	operator -- () const	= 0;	// --it
	virtual			IterT	operator -- (int)		= 0;	// it--
};

template <typename IteratorType, typename ObjectType>
struct RandAccessIt : BidirIt<IteratorType, ObjectType> {
	using IterT = IteratorType;
	using ObjT = ObjectType;

	virtual			IterT& 	operator += (const int& n) = 0;
	virtual			IterT& 	operator -= (const int& n) = 0;
	virtual			IterT  	operator +  (const int& n) const = 0;
	virtual			IterT  	operator -  (const int& n) const = 0;

	virtual			size_t	operator - (const IterT&) const = 0;

	virtual			ObjT&	operator [] (int)		= 0;
	virtual const	ObjT&	operator [] (int) const	= 0;

	virtual			bool	operator <  (const IterT&) const	= 0;
	virtual			bool	operator <= (const IterT&) const	= 0;
	virtual			bool	operator >  (const IterT&) const	= 0;
	virtual			bool	operator >= (const IterT&) const	= 0;
};


/*
	Copy and paste iterators:

struct iterator : public Iterator<iterator, int> {
	// general aliases
	using Object = int;
	using IteratorType = iterator;
	using IteartorBase = Iterator<IteratorType, Object>;

	// Iterator 
	virtual IteratorType& operator ++ () {}
	virtual IteratorType operator ++ (int) {}
//	virtual const IteratorType&	operator ++ () const {}
	
	virtual Object& operator * () {}
	virtual Object* operator -> () {}
	virtual const Object& operator * () const {}
	virtual const Object* operator -> () const {}

	virtual operator bool() const {};

	virtual bool operator == (const IteratorType&) const {};
	virtual bool operator != (const IteratorType&) const {};
};

struct bidir_it : public BidirIt<bidir_it, int> {
	// general aliases 
	using Object = int;
	using IteratorType = bidir_it;

	// Iterator 
	virtual IteratorType& operator ++ () {}
	virtual IteratorType operator ++ (int) {}
//	virtual const IteratorType&	operator ++ () const {}
	
	virtual Object& operator * () {}
	virtual Object* operator -> () {}
	virtual const Object& operator * () const {}
	virtual const Object* operator -> () const {}

	virtual operator bool() const {};

	virtual bool operator == (const IteratorType&) const {};
	virtual bool operator != (const IteratorType&) const {};

	// bidirectional 
	virtual IterT& operator -- () {}
	virtual IterT operator -- (int)	{}
//	virtual const IterT& operator -- () const {}
};

struct rand_access_it : public RandAccessIt<rand_access_it, int> {
	// general aliases 
	using Object = int;
	using IteratorType = rand_access_it;
	using IteartorBase = Iterator<IteratorType, Object>;

	// Iterator 
	virtual IteratorType& operator ++ () {}
	virtual IteratorType operator ++ (int) {}
//	virtual const IteratorType&	operator ++ () const {}
	
	virtual Object& operator * () {}
	virtual Object* operator -> () {}
	virtual const Object& operator * () const {}
	virtual const Object* operator -> () const {}

	virtual operator bool() const {};

	virtual bool operator == (const IteratorType&) const {};
	virtual bool operator != (const IteratorType&) const {};

	// bidirectional 
	virtual IteratorType& operator -- () {}
	virtual IteratorType operator -- (int) {}
//	virtual const IteratorType& operator -- () const {}

	// random access 
	virtual IteratorType& operator += (const int& n) {}
	virtual IteratorType& operator -= (const int& n) {}
	virtual IteratorType operator + (const int& n) const {}
	virtual IteratorType operator - (const int& n) const {}

	virtual size_t operator - (const IteratorType&) const {};

	virtual Object& operator [] (int) {}
	virtual const Object&	operator [] (int) const {}

	virtual bool operator < (const IteratorType&) const	{}
	virtual bool operator <= (const IteratorType&) const {}
	virtual bool operator > (const IteratorType&) const	{}
	virtual bool operator >= (const IteratorType&) const {}
};

*/

#endif