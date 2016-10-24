//
//  PieChartView.m
//  CustomePieChartView
//
//  Created by apple-CXTX on 16/9/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "PieChartView.h"

@implementation PieChartView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    //画扇形
    float totalValue = 0.0;
    _centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    for (int i = 0; i < _valueArray.count; i ++) {
        NSString * angle = _valueArray[i];
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:_centerPoint radius:_radius/2 startAngle:-M_PI/2 + 2*M_PI *totalValue endAngle:-M_PI/2 + 2*M_PI*angle.floatValue + 2*M_PI *totalValue clockwise:YES];
        path.lineWidth = _radius;
        //[[UIColor clearColor] setStroke];
        UIColor *color = _colorArray[i];
        [color setStroke];
        //[path fill];
        [path stroke];
        totalValue = totalValue +angle.floatValue;
    }
    
    
    
    //画分割线
    totalValue = 0.0;
    for (int i = 0; i < _valueArray.count; i ++) {
        NSString * angle = _valueArray[i];
        
        
        
        
        //获得处理的上下文
        
        
        CGContextRef
        context = UIGraphicsGetCurrentContext();
        
        
        //指定直线样式
        
        
        CGContextSetLineCap(context,
                            kCGLineCapSquare);
        
        
        //直线宽度
        
        
        CGContextSetLineWidth(context,
                              5.0);
        
        
        //设置颜色
        
        
        //CGContextSetRGBStrokeColor(context,
          //                         0.314, 0.486, 0.859, 1.0);
        [[UIColor whiteColor]setStroke];
        
        //开始绘制
        
        
        CGContextBeginPath(context);
        
        
        //画笔移动到点(31,170)
        
        
        CGContextMoveToPoint(context,
                             _centerPoint.x, _centerPoint.y);
        
        
        //下一点
        
        CGFloat x = _centerPoint.x + sin(totalValue * 2 *M_PI)*_radius;
        CGFloat y = _centerPoint.y - cos(totalValue * 2 *M_PI)*_radius;
        
        CGContextAddLineToPoint(context,
                                x, y);
        
        
        //下一点
        
        
       // CGContextAddLineToPoint(context,
           //                     159, 148);
        
        
        //绘制完成
        
        
        CGContextStrokePath(context);
        
        
        
        
        totalValue = totalValue +angle.floatValue;
    }

    //画label的线
    totalValue = 0.0;
    for (int i = 0; i < _valueArray.count; i ++){
        NSString * angle = _valueArray[i];
        
        
        
        CGFloat x = _centerPoint.x + sin((totalValue + angle.floatValue/2) * 2 *M_PI)*_radius;
        CGFloat y = _centerPoint.y - cos((totalValue + angle.floatValue/2) * 2 *M_PI)*_radius;
        
        
        //获得处理的上下文
        
        
        CGContextRef
        context = UIGraphicsGetCurrentContext();
        
        
        //指定直线样式
        
        
        CGContextSetLineCap(context,
                            kCGLineCapSquare);
        
        
        //直线宽度
        
        
        CGContextSetLineWidth(context,
                              1.0);
        
        
        //设置颜色
        UIColor *color = _colorArray[i];
        
        //CGContextSetRGBStrokeColor(context,
        //                         0.314, 0.486, 0.859, 1.0);
        [color setStroke];
        
        //开始绘制
        
        
        CGContextBeginPath(context);
        
        
        //画笔移动到点(31,170)
        
        
        CGContextMoveToPoint(context,
                             x, y);
        
        CGFloat m = 0;
        CGFloat n = 0;
        //下一点
        if ((totalValue + angle.floatValue/2) <= 0.25) {
            
            m = x + 10*sin(M_PI/4);
            n = y - 10*cos(M_PI/4);
            
        }
        
        if ((totalValue + angle.floatValue/2) > 0.25 && (totalValue + angle.floatValue/2) <= 0.5) {
            
            m = x + 10*sin(M_PI/4);
            n = y + 10*cos(M_PI/4);
            
        }
        
        if ((totalValue + angle.floatValue/2) > 0.5 && (totalValue + angle.floatValue/2) <= 0.75) {
            
            m = x - 10*sin(M_PI/4);
            n = y + 10*cos(M_PI/4);
            
        }
        
        if ((totalValue + angle.floatValue/2) > 0.75 && (totalValue + angle.floatValue/2) <= 1.1) {
            
            m = x - 10*sin(M_PI/4);
            n = y - 10*cos(M_PI/4);
            
        }
        
        CGContextAddLineToPoint(context,
                                m, n);
        
        
        //下一点
        
        float paramAngle = angle.floatValue * 100;
        NSString *paramText = [NSString stringWithFormat:@"%.0f",paramAngle];
        
        
        if ((totalValue + angle.floatValue/2) <= 0.5) {
            
            CGContextAddLineToPoint(context,
                                    m + 20, n);
            [self initPercentLabel:CGPointMake(m+20, n) text:paramText color:color];
            
        } else {
            CGContextAddLineToPoint(context,
                                    m - 20, n);
            [self initPercentLabel:CGPointMake(m-20-40, n) text:paramText color:color];
        }
        
    
        
        //绘制完成
        
        
        CGContextStrokePath(context);
        

        
        
        totalValue = totalValue +angle.floatValue;
    }
    
}

- (void)initPercentLabel:(CGPoint)point text : (NSString *)titletext color :(UIColor *)color{
    
    UILabel *lab = [[UILabel alloc]initWithFrame:CGRectMake(point.x, point.y-10, 40, 20)];
    lab.backgroundColor = [UIColor clearColor];
    lab.text = [NSString stringWithFormat:@"%@%%",titletext];
    lab.textColor = color;
    lab.font = [UIFont systemFontOfSize:13];
    lab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lab];
}

@end
