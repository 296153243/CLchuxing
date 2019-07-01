//
//  QuPointAnnotation.h
//  QuPassenger
//
//  Created by 朱青 on 2017/12/12.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

@interface QuPointAnnotation : MAPointAnnotation

@property (strong, nonatomic) NSString *pointTag;
@property (strong, nonatomic) NSArray *imageArray;

@end
