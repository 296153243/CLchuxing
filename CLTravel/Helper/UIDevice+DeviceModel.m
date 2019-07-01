//
//  UIDevice+DeviceModel.m
//  iOS_Teachers
//
//  Created by 朱青 on 15/11/6.
//  Copyright © 2015年 朱青. All rights reserved.
//

#import "UIDevice+DeviceModel.h"

@implementation UIDevice (DeviceModel)

+ (iPhoneModel)deviceModel
{

    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        
        return iPad;
    }
    
    CGRect rect = [[UIScreen mainScreen] bounds];
    
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    
    //get current interface Orientation
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    //unknown
    if (UIInterfaceOrientationUnknown == orientation) {
        return UnKnown;
    }
    
    //    portrait   width * height
    //    iPhone4:320*480
    //    iPhone5:320*568
    //    iPhone6:375*667
    //    iPhone6Plus:414*736
    //    iPhonex:375*812
    //portrait
    if (orientation == UIInterfaceOrientationPortrait || orientation ==UIInterfaceOrientationPortraitUpsideDown) {
        if (width == 320.0f) {
            if (height == 480.0f) {
                return iPhone4;
            }
        
            return iPhone5;
        }
        else if (width == 375.0f){
            
            if (height == 812.0f) {
                return iPhoneX;
            }
            return iPhone6;
        }
        else if (width == 414.0f){
            return iPhone6Plus;
        }
        
        
    }
    else if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight){
        
        if (height == 320.0f) {
            if (width == 480.0f) {
                return iPhone4;
            }
            
            return iPhone5;
        }
        else if (height == 375.0f){
            
            if (width == 812.0f) {
                return iPhoneX;
            }
            return iPhone6;
        }
        else if (height == 414.0f){
            return iPhone6Plus;
        }
    }
    return UnKnown;
}

@end
