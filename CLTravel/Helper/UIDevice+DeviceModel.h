//
//  UIDevice+DeviceModel.h
//  iOS_Teachers
//
//  Created by 朱青 on 15/11/6.
//  Copyright © 2015年 朱青. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, iPhoneModel){
    
    iPhone4 = 0,//320*480 4,4s
    iPhone5,    //320*568 5,5s,5c
    iPhone6,    //375*667 6,6s,7,8
    iPhone6Plus,//414*736 6Plus,6sPlus,7Plus,8Plus
    iPhoneX,//375*812 x
    iPad,
    UnKnown
    
};

@interface UIDevice (DeviceModel)

+ (iPhoneModel)deviceModel;


@end
