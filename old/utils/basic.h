#ifndef BASIC_H
#define BASIC_H

template <typename Type>
void swap (Type& a, Type& b) {
	Type c;
	
	c = a;		
	a = b; 
	b = c;
}

#endif