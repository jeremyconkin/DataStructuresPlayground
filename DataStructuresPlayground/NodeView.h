//
//  NodeView.h
//  DataStructuresPlayground
//
//  Created by Jeremy Conkin on 9/15/14.
//  Copyright (c) 2014 Jeremy Conkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TreeStructures/TreeStructures.h>

/**
 *  This view serves as a visual representation of the node data structure
 */
@interface NodeView : UIView

/** Label that prints out the node's value description */
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

/** Node that defines the value for this visualization */
@property (strong, nonatomic) Node *valueNode;

/** Color for the circle in this view */
@property (assign, nonatomic) CGColorRef fillColor;

/**
 *  Get the node that defines the value for this visualization
 *
 *  @return The value node
 */
- (Node *)valueNode;

/**
 *  Determine which node view has a greater value
 *
 *  @param otherNode  The node compared to this node
 *
 *  @return Comparison result
 */
- (NSComparisonResult)compare:(NodeView *)otherNode;

@end
