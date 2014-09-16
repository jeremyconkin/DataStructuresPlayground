//
//  ViewController.m
//  DataStructuresPlayground
//
//  Created by Jeremy Conkin on 9/15/14.
//  Copyright (c) 2014 Jeremy Conkin. All rights reserved.
//

#import "MergeSortViewController.h"

#import "NodeView.h"

#import <TreeStructures/TreeStructures.h>

/** Block of code for animating a UIView */
typedef void(^AnimationBlock)(void);

/** Aniamtion up/down indicates that the nodes in question are being sorted */
static const CGFloat yNodeAnimationDistance = 30.f;

@interface MergeSortViewController ()

/** Initial list of nodes to sort */
@property (strong, nonatomic) SinglyLinkedList *rawDataLinkedList;

/** How far apart node views are spaced */
@property (assign, nonatomic) CGFloat distanceBetweenNodes;

/** Queue of animations to illustrate the sort */
@property (strong, nonatomic) NSMutableArray* animationBlocks;

/**
 *  Colors to set nodes when they are the left half of a merge. Sort depth
 *  indicates the array index.
 */
@property (strong, nonatomic) NSArray *leftListColors;

/**
 *  Colors to set nodes when they are the right half of a merge. Sort depth
 *  indicates the array index.
 */
@property (strong, nonatomic) NSArray *rightListColors;

@end

@implementation MergeSortViewController
            
- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.animationBlocks = [NSMutableArray new];
    
    self.distanceBetweenNodes = (self.view.frame.size.width / 10);
    [self addStartupData];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self sortList];
}

/**
 *  Add the initial values to the linked list
 */
- (void)addStartupData {
    
    self.rawDataLinkedList = [SinglyLinkedList new];
    [self addNodeWithIntegerValue:4];
    [self addNodeWithIntegerValue:2];
    [self addNodeWithIntegerValue:8];
    [self addNodeWithIntegerValue:6];
    [self addNodeWithIntegerValue:0];
    [self addNodeWithIntegerValue:5];
    [self addNodeWithIntegerValue:1];
    [self addNodeWithIntegerValue:7];
    [self addNodeWithIntegerValue:3];
    [self addNodeWithIntegerValue:9];
}

/**
 *  Create a node view with a display and sort value of the given integer
 *
 *  @param integerValue  Sort and display value for the added node
 */
- (void)addNodeWithIntegerValue:(NSInteger)integerValue {
    
    Node *node = [[Node alloc] initWithObject:[NSNumber numberWithInteger:integerValue]];
    
    NodeView* nodeView = [[[NSBundle mainBundle] loadNibNamed:@"NodeView"
                                                        owner:self
                                                      options:nil] firstObject];
    nodeView.fillColor = [[UIColor blueColor] CGColor];
    nodeView.valueNode = node;
    CGPoint nodeCenter;
    nodeCenter.x = [self xPositionForNodeView:(NodeView *)nodeView
                                      atIndex:self.rawDataLinkedList.lengthOfList];
    nodeCenter.y = self.view.center.y + 70.f;
    nodeView.center = nodeCenter;
    [self.view addSubview:nodeView];
    
    [self.rawDataLinkedList appendObject:nodeView];
}

/**
 *  Where would the given node view go if at the given index in the sortable set
 *
 *  @param nodeView  View to hypothetically position on x
 *  @param index     What position in the list this view would have
 */
- (CGFloat)xPositionForNodeView:(NodeView *)nodeView
                        atIndex:(NSUInteger)index {
    
    return (index * self.distanceBetweenNodes) + (nodeView.frame.size.width * 0.5f) + 3.f;;
}

/**
 *  Perform merge sort on the raw data list
 */
- (void)sortList {
    
    self.rawDataLinkedList = [self mergeSortList:self.rawDataLinkedList
                              withTotalListIndex:0];
    [self executeAnimations];
}

/**
 *  After sorting completes, the process of sorting is animated. Add a y-axis
 *  animation to every node view in a list.
 *
 *  @param list       Set of nodes to animate
 *  @param animateUp  When YES, go up the screen. Otherwise go down.
 */
- (void)queueAnimationOfWholeList:(SinglyLinkedList *)list
                               up:(BOOL)animateUp {
    
    CGFloat verticalOffset = animateUp ? -yNodeAnimationDistance : yNodeAnimationDistance;
    
    [self.animationBlocks addObject:^{
        for (NSUInteger i = 0; i < list.lengthOfList; ++i) {
            
            NodeView *nodeView = [list objectAtIndex:i];
            nodeView.center = CGPointMake(nodeView.center.x, nodeView.center.y + verticalOffset);
        }
    }];
}

/**
 *  After sorting completes, the process of sorting is animated. Colorize lists
 *  that are being merged.
 *
 *  @param list       Set of nodes to colorize
 *  @param colorRef   Color to user when drawing the node
 */
- (void)queueColorChangeOfWholeList:(SinglyLinkedList *)list
                       withColorRef:(CGColorRef)colorRef {
    
    // Copy the array
    __strong SinglyLinkedList *strongList = [SinglyLinkedList new];
    for (NSUInteger i = 0; i < list.lengthOfList; ++i) {
        [strongList appendObject:[list objectAtIndex:i]];
    }
    
    [self.animationBlocks addObject:^{
        for (NSUInteger i = 0; i < strongList.lengthOfList; ++i) {
            
            NodeView *nodeView = [strongList objectAtIndex:i];
            nodeView.fillColor = colorRef;
            [nodeView setNeedsDisplay];
        }
    }];
}

/**
 *  Perform the set of queued animations one at a time.
 */
- (void)executeAnimations {
    
    AnimationBlock nextBlock = [self.animationBlocks firstObject];
    [self.animationBlocks removeObjectAtIndex:0];
    
    [UIView animateWithDuration:1.f
                          delay:0.f
         usingSpringWithDamping:1.f
          initialSpringVelocity:2.f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:nextBlock
                     completion:^(BOOL finished) {
                         
                         if (self.animationBlocks.count > 0) {
                             [self executeAnimations];
                         }
                     }];

}

/**
 *  Perform sorting on the given sublist
 *
 *  @param listToSort     Sublist being sorted
 *  @param totalListIndex Where the start of this list lies in the total raw
 *                        dataset. Used for calculating x-position for
 *                        animation.
 *
 *  @return The sorted list
 */
- (SinglyLinkedList *)mergeSortList:(SinglyLinkedList *)listToSort
                 withTotalListIndex:(NSUInteger)totalListIndex {
    
    [self queueAnimationOfWholeList:listToSort
                                 up:YES];
    
    if (listToSort.lengthOfList <= 1) {
        
        [self queueAnimationOfWholeList:listToSort
                                     up:NO];
        return listToSort;
    }
    
    /*
     function merge_sort(m)
     if length(m) ≤ 1
     return m
     var list left, right, result*/
    SinglyLinkedList *leftList = [SinglyLinkedList new];
    SinglyLinkedList *rightList = [SinglyLinkedList new];
    SinglyLinkedList *resultList = [SinglyLinkedList new];
    
    NSUInteger middleIndex = (listToSort.lengthOfList + 1) / 2;
    NSUInteger i = 0;
    
    /*
     var integer middle = length(m) / 2
     for each x in m up to middle
     add x to left
     for each x in m after middle
     add x to right*/
    while (i < middleIndex) {
        
        [leftList appendObject:[listToSort objectAtIndex:i]];
        ++i;
    }
    
    while (i < listToSort.lengthOfList) {
        
        [rightList appendObject:[listToSort objectAtIndex:i]];
        ++i;
    }
    
    /*
     left = merge_sort(left)
     right = merge_sort(right)
     */
    SinglyLinkedList *sortedLeftList = [self mergeSortList:leftList
                                        withTotalListIndex:totalListIndex];
    
    SinglyLinkedList *sortedRightList = [self mergeSortList:rightList
                                         withTotalListIndex:totalListIndex + sortedLeftList.lengthOfList];
    
    /*
    result = merge(left, right)
    return result
    */
    resultList = [self mergeLeftList:sortedLeftList
                       withRightList:sortedRightList
                  withTotalListIndex:totalListIndex];

    return resultList;
}


/**
 *  Merge two sorted lists into one sorted list
 *
 *  @param leftList       First sorted list
 *  @param rightList      Second sorted list
 *  @param totalListIndex Where the start of this list lies in the total raw
 *                        dataset. Used for calculating x-position for
 *                        animation.
 *
 *  @return               The sorted consolidated list
 */
- (SinglyLinkedList *)mergeLeftList:(SinglyLinkedList *)leftList
                      withRightList:(SinglyLinkedList *)rightList
                 withTotalListIndex:(NSUInteger)totalListIndex {
    
    // Colorize these lists to show which side is which
    [self queueColorChangeOfWholeList:leftList
                         withColorRef:[[UIColor redColor] CGColor]];
    [self queueColorChangeOfWholeList:rightList
                         withColorRef:[[UIColor greenColor] CGColor]];
    
    SinglyLinkedList *resultList = [SinglyLinkedList new];
    
    NodeView *firstLeftNode = [leftList objectAtIndex:0];
    CGFloat startXPosition = [self xPositionForNodeView:firstLeftNode
                                                atIndex:totalListIndex];
    
    while ((leftList.lengthOfList > 0)
           || (rightList.lengthOfList > 0)) {
        
        NodeView *nodeToAdd;
        BOOL leftHasValues = (leftList.lengthOfList > 0);
        BOOL rightHasValues = (rightList.lengthOfList > 0);
        if (leftHasValues
            && rightHasValues) {
            
            NSComparisonResult comparison = [[leftList objectAtIndex:0] compare:[rightList objectAtIndex:0]];
            if (comparison != NSOrderedDescending) {
                
                nodeToAdd = [leftList objectAtIndex:0];
                [resultList appendObject:nodeToAdd];
                [leftList removeObjectAtIndex:0];
            } else {
                
                nodeToAdd = [rightList objectAtIndex:0];
                [resultList appendObject:nodeToAdd];
                [rightList removeObjectAtIndex:0];
            }
        } else if (leftHasValues) {
            
            nodeToAdd = [leftList objectAtIndex:0];
            [resultList appendObject:nodeToAdd];
            [leftList removeObjectAtIndex:0];
        } else if (rightHasValues) {
            
            nodeToAdd = [rightList objectAtIndex:0];
            [resultList appendObject:nodeToAdd];
            [rightList removeObjectAtIndex:0];
        }
        
        // Reposition the nodes
        [self.animationBlocks addObject:^{
            nodeToAdd.center = CGPointMake(startXPosition, nodeToAdd.center.y + yNodeAnimationDistance);
        }];
        startXPosition += self.distanceBetweenNodes;
        
    }
    
    // Now that the lists are consolidated, reset the color
    [self queueColorChangeOfWholeList:resultList
                         withColorRef:[[UIColor blueColor] CGColor]];
    
    return resultList;
}

@end
