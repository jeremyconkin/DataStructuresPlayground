//
//  NodeWithParent.h
//  TreeStructures
//
//  Created by Jeremy Conkin on 9/14/14.
//  Copyright (c) 2014 Jeremy Conkin. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  Functions as a node with one possible parent but many possible children
 */
@interface AncestorNode : NSObject

/** The value this container holds */
@property (strong, nonatomic) id nodeValue;

/**
 *  Get the node from which this node descends
 *
 *  @return This node's ancestor
 */
- (AncestorNode *)parentNode;

/**
 *  Create and return a set of the first generation children nodes
 *
 *  @return The set of child ancestors
 */
- (NSOrderedSet *)childrenNodes;

/**
 *  Create a child with its parent set
 *
 *  @param parentNode  This child's first generation ancestor
 *
 *  @return An instance of this class
 */
- (instancetype)initWithParent:(AncestorNode *)parentNode;

/**
 *  Give this node some offspring
 *
 *  @return The node this node brings into the world
 */
- (AncestorNode *)addChild;

/**
 *  Remove one of this node's children
 *
 *  @param childNode  The node this node brings into the world
 */
- (void)removeChild:(AncestorNode *)childNode;

@end
