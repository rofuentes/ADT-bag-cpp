/** @file ArrayBag.h */
#ifndef ARRAY_BAG_
#define ARRAY_BAG_

#include "BagInterface.h"

template<class ItemType>
class ArrayBag : public BagInterface<ItemType>
{
  private:
    static const int DEFAULT_CAPACITY = 6;
    ItemType items[DEFAULT_CAPACITY];
    int itemCount;
    int maxItems;
  
  public:
    ArrayBag();
};

#include "ArrayBag.cpp"
#endif