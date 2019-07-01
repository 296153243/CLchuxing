//
//  AccountInfo.h
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/7/21.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountInfo : NSObject

@property (strong, nonatomic) QuUserInfo *userInfo;
@property (assign, nonatomic) BOOL isLogin;
//@property (assign, nonatomic) BOOL isTrack;//轨迹是否在使用

+ (AccountInfo *)shareRsp;

@end
