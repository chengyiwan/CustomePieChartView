//
//  PieChartView.h
//  CustomePieChartView
//
//  Created by apple-CXTX on 16/9/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PieChartView : UIView

//填充颜色
@property (strong,nonatomic) UIColor *strokeColor;

//圆心
@property (assign,nonatomic) CGPoint centerPoint;

//起始角度
@property (assign,nonatomic) CGFloat startAngle;

//终止角度
@property (assign,nonatomic) CGFloat endAngle;



@end
