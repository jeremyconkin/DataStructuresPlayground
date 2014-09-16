//
//  NodeView.m
//  DataStructuresPlayground
//
//  Created by Jeremy Conkin on 9/15/14.
//  Copyright (c) 2014 Jeremy Conkin. All rights reserved.
//

#import "NodeView.h"

@interface NodeView ()

@end

@implementation NodeView

- (void)setValueNode:(Node *)valueNode {
    
    _valueNode = valueNode;
    NSString *valueDescription = [NSString stringWithFormat:@"%@", self.valueNode.object];
    self.descriptionLabel.text = valueDescription;
}

- (void)drawRect:(CGRect)rect {
    
    static const CGFloat lineWidth = 2.f;
    static const CGFloat doubleLineWidth = lineWidth * 2.f;
    CGRect borderRect = CGRectMake(lineWidth, lineWidth, self.frame.size.width - doubleLineWidth, self.frame.size.height - doubleLineWidth);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.5f, 0.5f, 0.5f, 1.0);
    CGContextSetFillColorWithColor(context, self.fillColor);
    CGContextSetLineWidth(context, lineWidth);
    CGContextFillEllipseInRect (context, borderRect);
    CGContextStrokeEllipseInRect(context, borderRect);
    CGContextFillPath(context);
}

- (NSComparisonResult)compare:(NodeView *)otherNode {
    
    return [self.valueNode compare:otherNode.valueNode];
}

- (NSString *)description {
    
    return [NSString stringWithFormat:@"%@", self.valueNode];
}

@end
