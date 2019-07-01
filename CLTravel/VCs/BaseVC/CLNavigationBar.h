//
//  CLNavigationBar.h
//  QuPassenger
//
//  Created by 朱青 on 2017/9/26.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLNavigationBar : UIView

@property (strong, nonatomic) UIColor *barTintColor;
@property (strong, nonatomic) UIColor *titleColor;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIView *leftView;
@property (strong, nonatomic) UIView *rightView;

@property (strong, nonatomic) UIView *titleView;

+ (CLNavigationBar *)showCLNavigationBarWithController:(UIViewController *)controller;
+ (CLNavigationBar *)showCLNavigationBarWithController:(UIViewController *)controller offset:(BOOL)offset;
+(void)showLeftBankView;
@end
