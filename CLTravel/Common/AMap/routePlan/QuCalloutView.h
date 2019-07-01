//
//  CustomCalloutView.h
//  Category_demo2D
//
//  Created by xiaoming han on 13-5-22.
//  Copyright (c) 2013年 songjian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuCalloutView : UIView

@property (copy, nonatomic) void (^calloutBlock) (NSInteger type);//type 1:展示站点图片 2.导航
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *subName;
@property (assign, nonatomic) BOOL showNav;//是否展示导航

@end
