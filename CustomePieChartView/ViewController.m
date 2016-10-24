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
#define SCREEM_WIDTH [UIScreen mainScreen].bounds.size.width


NSInteger const SmallArcRadius = 3;//控制间隔大小
CGPoint const SmallArcCenter = {160,200};

@interface ViewController ()


@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    PieChartView *pieChartView = [[PieChartView alloc]initWithFrame:CGRectMake((SCREEM_WIDTH - 250)/2, 100 , 250, 250)];
    
    //比例
    pieChartView.valueArray = @[@"0.1",@"0.3",@"0.4",@"0.2"];
    
    //颜色
    pieChartView.colorArray = @[[UIColor redColor],[UIColor blueColor],[UIColor orangeColor],[UIColor greenColor]];
    
    //半径
    pieChartView.radius = 100;
    
    [self.view addSubview:pieChartView];
    
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
