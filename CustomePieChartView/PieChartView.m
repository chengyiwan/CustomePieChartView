//
//  PieChartView.m
//  CustomePieChartView
//
//  Created by apple-CXTX on 16/9/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PieChartView.h"

@implementation PieChartView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
   // CGContextSetRGBFillColor(context, 1, 0, 0, 1);
    CGContextSetLineWidth(context, 50);
  //  CGContextSetRGBStrokeColor(context, 0, 1, 0, 1);
    [self.strokeColor setStroke];
    CGContextAddArc(context, _centerPoint.x, _centerPoint.y, 100, _startAngle, _endAngle, 0);
    CGContextDrawPath(context, kCGPathStroke);
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:_centerPoint radius:100 startAngle:_startAngle endAngle:_endAngle clockwise:YES];
//    path.lineWidth = 100;
//    [self.strokeColor setStroke];
//    [path stroke];
}


@end
