//
//  UIButton+Help.m
//  CLDriver
//
//  Created by MOOSON_ on 2018/10/24.
//  Copyright © 2018年 MOOSON_. All rights reserved.
//

#import "UIButton+Help.h"

@implementation UIButton (Help)
+ (void)addBtnShadow:(UIButton *)btn{
    btn.clipsToBounds = YES;
    btn.layer.cornerRadius = 5;
    btn.backgroundColor = [UIColor colorWithRed:73/255.0 green:95/255.0 blue:178/255.0 alpha:1];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(25,414.5,325,50);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:73/255.0 green:84/255.0 blue:117/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithRed:70/255.0 green:78/255.0 blue:102/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:77/255.0 blue:101/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithRed:78/255.0 green:87/255.0 blue:117/255.0 alpha:0.8].CGColor];
    gl.locations = @[@(0.0),@(0.0),@(0.5),@(1.0)];
    [btn.layer addSublayer:gl];
}
@end
