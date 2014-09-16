//
//  SinglyLinkedList.h
//  TreeStructures
//
//  Created by Jeremy Conkin on 9/14/14.
//  Copyright (c) 2014 Jeremy Conkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Node;

/**
 *  Singly linked lists have a start node as an entry point. The start node may
 *  have at most one child. Each child node may have at most one parent and at
 *  most one child. The resulting data structure looks like this:
 *  A->B->C->D
 */
@interface SinglyLinkedList : NSObject

/**
 *  Determine how many nodes are in this list
 *
 *  @return The length of the list. Can be 0.
 */
- (NSUInteger)lengthOfList;

/** Add a value to the end of the linked list */
- (void)appendObject:(id)value;

/**
 *  Get the value at the given index in the list
 *
 *  @param index  The value's position in the list
 *
 *  @return The value at the given index. May be nil.
 */
- (id)objectAtIndex:(NSUInteger)index;

/**
 *  Remove the value at the given index. If the index is less than the length of
 *  this list, the length of the list will reduce by one
 *
 *  @param index  The value's position in the list
 */
- (void)removeObjectAtIndex:(NSUInteger)index;

/**
 *  Add a value into the given position in the list. If the index is greater
 *  than the size of the list, append the value to the end.
 *
 *  @param object  The value to add to this list
 *  @param index   The value's position in the list
 */
- (void)insertObject:(id)object
            atIndex:(NSUInteger)index;

@end
