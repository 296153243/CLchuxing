//
//  CustomAnnotationView.h
//  CustomAnnotationDemo
//
//  Created by songjian on 13-3-11.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "QuCalloutView.h"

@interface QuAnnotationView : MAAnnotationView

@property (copy, nonatomic) void (^calloutBlock) (NSInteger type, NSArray *imageArray);//type 1:展示站点图片 2.导航
@property (copy, nonatomic) void (^selectBlock) (void);
@property (strong, nonatomic) NSString *name;
@property (assign, nonatomic) BOOL showNav;//是否展示导航
@property (strong, nonatomic) NSArray *imageArray;
@property (strong, nonatomic) QuCalloutView *calloutView;

@end
