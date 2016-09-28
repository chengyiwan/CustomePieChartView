//
//  ViewController.m
//  CustomePieChartView
//
//  Created by apple-CXTX on 16/9/28.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ViewController.h"
#import "PieChartView.h"
#import "CenterPoint.h"

NSInteger const SmallArcRadius = 3;//控制间隔大小
CGPoint const SmallArcCenter = {160,200};

@interface ViewController ()


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray * percentArray = @[@0.34,@0.26,@0.21,@0.19];//百分比
    NSArray *colorArray = @[[UIColor greenColor],[UIColor redColor],[UIColor blueColor],[UIColor yellowColor],[UIColor blueColor]];//颜色，数量要大于等于百分比个数
    NSMutableArray *centerPointArray = [self convertArcCenterPoint:percentArray];
    for (int i = 0; i < centerPointArray.count; i ++) {
        
        float startAngle = 0.0;
        float endAngle = 0.0;
        for (int j = 0; j <= i; j ++) {
            if (i == centerPointArray.count - 1) {
                if (j == i) {
                    CenterPoint *centerPoint = centerPointArray[i];
                    PieChartView *chartView = [[PieChartView alloc]initWithFrame:self.view.frame];
                    NSNumber *percent = percentArray[j];
                    endAngle = endAngle + percent.floatValue*M_PI*2;
                    chartView.centerPoint = CGPointMake(centerPoint.x, centerPoint.y);
                    chartView.strokeColor = colorArray[i];
                    chartView.startAngle = -M_PI/2 + startAngle;
                    chartView.endAngle = -M_PI/2;
                    chartView.backgroundColor = [UIColor clearColor];
                    [self.view addSubview:chartView];
                } else {
                    NSNumber *percent = percentArray[j];
                    startAngle = startAngle + percent.floatValue*M_PI*2;
                    endAngle = endAngle + percent.floatValue*M_PI*2;
                }
                continue;
            }
            if (j == i) {
                CenterPoint *centerPoint = centerPointArray[i];
                PieChartView *chartView = [[PieChartView alloc]initWithFrame:self.view.frame];
                NSNumber *percent = percentArray[j];
                endAngle = endAngle + percent.floatValue*M_PI*2;
                chartView.centerPoint = CGPointMake(centerPoint.x, centerPoint.y);
                chartView.strokeColor = colorArray[i];
                chartView.startAngle = -M_PI/2 + startAngle;
                chartView.endAngle = -M_PI/2 + endAngle;
                chartView.backgroundColor = [UIColor clearColor];
                [self.view addSubview:chartView];
            } else {
                NSNumber *percent = percentArray[j];
                startAngle = startAngle + percent.floatValue*M_PI*2;
                endAngle = endAngle + percent.floatValue*M_PI*2;
            }
        }
        
//        if (i == 0) {
//            CenterPoint *centerPoint = centerPointArray[i];
//            PieChartView *chartView = [[PieChartView alloc]initWithFrame:self.view.frame];
//            NSNumber *percent = percentArray[i];
//            chartView.centerPoint = CGPointMake(centerPoint.x, centerPoint.y);
//            chartView.strokeColor = [UIColor redColor];
//            chartView.startAngle = -M_PI/2;
//            chartView.endAngle = -M_PI/2 + percent.doubleValue*M_PI*2;
//            chartView.backgroundColor = [UIColor clearColor];
//            [self.view addSubview:chartView];
//        } if (i == 1) {
//            NSNumber *percent = percentArray[0];
//            NSNumber *percent2 = percentArray[1];
//            CenterPoint *centerPoint = centerPointArray[i];
//            PieChartView *chartView = [[PieChartView alloc]initWithFrame:self.view.frame];
//            chartView.startAngle = -M_PI/2 + percent.doubleValue*M_PI*2;
//            chartView.endAngle = -M_PI/2 + percent.doubleValue*M_PI*2+percent2.doubleValue*M_PI*2;
//            chartView.strokeColor = [UIColor greenColor];
//            chartView.centerPoint = CGPointMake(centerPoint.x, centerPoint.y);
//            chartView.backgroundColor = [UIColor clearColor];
//            [self.view addSubview:chartView];
//        } if (i == 2) {
//            NSNumber *percent = percentArray[0];
//            NSNumber *percent2 = percentArray[1];
//            NSNumber *percent3 = percentArray[2];
//            CenterPoint *centerPoint = centerPointArray[i];
//            PieChartView *chartView = [[PieChartView alloc]initWithFrame:self.view.frame];
//            chartView.startAngle = -M_PI/2 + percent.doubleValue*M_PI*2+percent2.doubleValue*M_PI*2;
//            chartView.endAngle = -M_PI/2 + percent.doubleValue*M_PI*2+percent2.doubleValue*M_PI*2 + percent3.doubleValue*M_PI*2;
//            chartView.strokeColor = [UIColor yellowColor];
//            chartView.centerPoint = CGPointMake(centerPoint.x, centerPoint.y);
//            chartView.backgroundColor = [UIColor clearColor];
//            [self.view addSubview:chartView];
//        } if (i == 3) {
//            NSNumber *percent = percentArray[0];
//            NSNumber *percent2 = percentArray[1];
//            NSNumber *percent3 = percentArray[2];
//            NSNumber *percent4 = percentArray[3];
//            CenterPoint *centerPoint = centerPointArray[i];
//            PieChartView *chartView = [[PieChartView alloc]initWithFrame:self.view.frame];
//            chartView.startAngle = -M_PI/2 + percent.doubleValue*M_PI*2+percent2.doubleValue*M_PI*2 + percent3.doubleValue*M_PI*2;
//            chartView.endAngle = -M_PI/2;
//            chartView.strokeColor = [UIColor purpleColor];
//            chartView.centerPoint = CGPointMake(centerPoint.x, centerPoint.y);
//            chartView.backgroundColor = [UIColor clearColor];
//            [self.view addSubview:chartView];
//        }
    }
    
}


/**
 计算饼图各个模块的圆心

 @param percentArray 百分比数组
 */
- (NSMutableArray *)convertArcCenterPoint :(NSArray *)percentArray {
    NSMutableArray *mutableArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < percentArray.count; i ++) {
        float previousTotalAngle = 0.0;
        for (int j = 0; j <= i; j ++) {
            if (j == i) {
                NSNumber *percent = percentArray[i];
                float angle = percent.floatValue * M_PI + previousTotalAngle;
                float x = SmallArcCenter.x + sin(angle)*SmallArcRadius;
                float y = SmallArcCenter.y - cos(angle)*SmallArcRadius;
                CenterPoint *point = [[CenterPoint alloc]init];
                point.x = x;
                point.y = y;
                [mutableArray addObject:point];
                
            } else {
                NSNumber *percent = percentArray[j];
                float angle = 2 * percent.floatValue * M_PI;
                previousTotalAngle = previousTotalAngle + angle;

            }
        }
    }
    return mutableArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
