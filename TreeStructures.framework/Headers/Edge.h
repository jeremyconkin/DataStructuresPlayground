//
//  Edge.h
//  TreeStructures
//
//  Created by Jeremy Conkin on 9/6/14.
//  Copyright (c) 2014 Jeremy Conkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Node;

#ifdef DEBUG
static NSUInteger edgeInstanceCount = 0;
#endif //DEBUG

/**
 *  Edges connect two nodes. Edges have a cost (aka weight) for traversal. They
 *  may be one directional or bidirectional.
 */
@interface Edge : NSObject

/**
 *  Connect two nodes with an edge
 *
 *  @param startNode      Node at the tail of this edge
 *  @param endNode        Node at the tip of this edge
 *  @param cost           Toll an algorithm pays for edge traversal
 *  @param bidirectional  YES when two way traversal is allowed
 *
 *  @return An instance of this class
 */
+ (void)connectNode:(Node *)startNode
             toNode:(Node *)endNode
           withCost:(NSUInteger)cost
  withBidirectional:(BOOL)biDirectional;

/**
 *  Create an edge
 *
 *  @param startNode      Node at the tail of this edge
 *  @param endNode        Node at the tip of this edge
 *  @param cost           Toll an algorithm pays for edge traversal
 *  @param bidirectional  YES when two way traversal is allowed
 *
 *  @return An instance of this class
 */
- (instancetype)initWithStartNode:(Node *)startNode
                      withEndNode:(Node *)endNode
                         withCost:(NSUInteger)cost
                withBidirectional:(BOOL)biDirectional;

/**
 *  Get the node at the start (tail) of this edge
 *
 *  @return The starting node
 */
- (Node *)startNode;

/**
 *  Get the node at the end (tip) of this edge
 *
 *  @return The ending node
 */
- (Node *)endNode;

/**
 *  How much an algorithm pays to traverse this edge. Cost may represent time,
 *  effort, etc. depending on what the parent data structure represents
 *
 *  @return The traversal cost
 */
- (NSUInteger)cost;

/**
 *  Does the child know of its parent? If NO, start and end nodes are no
 *  different. If YES, both ends of this edge function as a tip and a tail.
 *
 *  @return YES if this edge allows two-way traverl
 */
- (BOOL)bidirectional;

@end
