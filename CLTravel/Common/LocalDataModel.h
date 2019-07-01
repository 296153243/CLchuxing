//
//  LocalDataModel.h
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/8/3.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalDataModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *imageName;
@property (assign, nonatomic) NSInteger sign;

//首页左侧分类
+ (NSMutableArray *)arrayForMainLeftCategory;
//联系人关系
+ (NSMutableArray *)arrayForLinkRelation;

@end

@interface UserSetModel : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *subName;

+ (NSMutableArray *)arrayForUserSet;

@end
