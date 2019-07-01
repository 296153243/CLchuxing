//
//  LocalDataModel.m
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/8/3.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import "LocalDataModel.h"

@implementation LocalDataModel

+ (NSMutableArray *)arrayForMainLeftCategory
{
    NSArray *nameArray = @[@"行程",@"钱包",@"客服",@"设置"];
    NSArray *signArray = @[@"main_xch_icon",@"main_bdrzh_icon",@"main_gywm_icon",@"main_szh_icon"];
    NSArray *lineArray = @[@"0",@"1",@"2",@"3"];
    
    NSMutableArray *firstArray = [[NSMutableArray alloc]initWithCapacity:7];
    
    for (NSInteger i = 0; i < nameArray.count; i++) {
        
        LocalDataModel *firstModel = [[LocalDataModel alloc]init];
        firstModel.name = [nameArray objectAtIndex:i];
        firstModel.imageName = [signArray objectAtIndex:i];
        firstModel.sign = [lineArray[i] integerValue];
        [firstArray addObject:firstModel];
    }
    
    
    return firstArray;
}

+ (NSMutableArray *)arrayForLinkRelation
{
    NSArray *nameArray = @[@"父母",@"兄弟姐妹",@"夫妻",@"朋友",@"同事"];
    NSArray *signArray = @[@"5",@"1",@"2",@"3",@"4"];
 
    NSMutableArray *firstArray = [[NSMutableArray alloc]initWithCapacity:5];
    
    for (NSInteger i = 0; i < nameArray.count; i++) {
        
        LocalDataModel *firstModel = [[LocalDataModel alloc]init];
        firstModel.name = [nameArray objectAtIndex:i];
        firstModel.imageName = [signArray objectAtIndex:i];
  
        [firstArray addObject:firstModel];
    }
    
    
    return firstArray;
}

@end


@implementation UserSetModel

+ (NSMutableArray *)arrayForUserSet
{
    NSMutableArray *bigArray = [[NSMutableArray alloc]initWithCapacity:1];
    
    NSArray *nameArray = @[@"头像"];
    NSArray *signArray = @[@""];
    
    NSMutableArray *firstArray = [[NSMutableArray alloc]initWithCapacity:3];
    
    for (NSInteger i = 0; i < nameArray.count; i++) {
        
        UserSetModel *firstModel = [[UserSetModel alloc]init];
        firstModel.name = [nameArray objectAtIndex:i];
        firstModel.subName = [signArray objectAtIndex:i];
        
        [firstArray addObject:firstModel];
    }
    
    NSArray *secondNameArray = @[@"昵称",@"性别",@"个性签名"];
    NSArray *secondSignArray = @[@"",@"",@""];
    
    NSMutableArray *secondArray = [[NSMutableArray alloc]initWithCapacity:3];
    
    for (NSInteger i = 0; i < secondNameArray.count; i++) {
        
        UserSetModel *firstModel = [[UserSetModel alloc]init];
        firstModel.name = [secondNameArray objectAtIndex:i];
        firstModel.subName = [secondSignArray objectAtIndex:i];
        
        [secondArray addObject:firstModel];
    }
    
    [bigArray addObject:firstArray];
    [bigArray addObject:secondArray];
    
    return bigArray;
}

@end

