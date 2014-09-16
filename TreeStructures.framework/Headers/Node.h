//
//  Node.h
//  TreeStructures
//
//  Created by Jeremy Conkin on 9/6/14.
//  Copyright (c) 2014 Jeremy Conkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Edge;

/**
 *  A node may represent a position in space or a value in a tree. It is
 *  connected to other nodes via edges
 */
@interface Node : NSObject

/**
 *  All edges serving as exits from this node
 *
 *  @return Edges leaving this node
 */
- (NSSet *)outgoingEdges;

/**
 *  NSNumber, location, etc. Whatever concrete value this node represents.
 *
 *  @return This node's value
 */
- (id)object;

/**
 *  Create a node with an initial value
 *
 *  @param object  Value to assign to this node
 *
 *  @return An instance of this class
 */
- (instancetype)initWithObject:(id)object;

/**
 *  See if another node's value is greater than this node's value
 *
 *  @param otherNode  Node being compared to this node
 *
 *  @return ascending, descending, or same
 */
- (NSComparisonResult)compare:(Node *)otherNode;

/**
 *  Add an edge to the set of edges exiting this node
 *
 *  @param outgoingEdge  The edge to add
 */
- (void)addOutgoingEdge:(Edge *)outgoingEdge;

/**
 *  Remove an edge to the set of edges exiting this node
 *
 *  @param edgeToRemove  The edge to remove from the outgoing set
 */
- (void)removeOutgoingEdge:(Edge *)edgeToRemove;

/**
 *  Remove any edge that has this node as its start node or is bidirectional
 */
- (void)removeAllOutgoingEdges;

@end
