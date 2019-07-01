//
//  UIImage+Help.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/22.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "UIImage+Help.h"

@implementation UIImage (Help)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    
    @autoreleasepool {
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context,
                                       
                                       color.CGColor);
        
        CGContextFillRect(context, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        
        
        return img;
        
    }
}

+ (UIImage *)resizableImageName:(NSString *)imgName  WithCapInsets:(UIEdgeInsets)capInsets
{
    if (imgName.length == 0) {
        return nil;
    }
    UIImage *img = [UIImage imageNamed:imgName];
    img = [img resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
    if (img) {
        return img;
    }
    return [UIImage imageNamed:imgName];
}

@end
