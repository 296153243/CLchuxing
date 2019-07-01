//
//  NSString+Help.h
//  FreshFood
//
//  Created by 朱青 on 2017/7/17.
//  Copyright © 2017年 FreshFood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (base64)

+ (NSData *)dataWithBase64EncodedString:(NSString *)string;

- (NSString *)base64EncodedStringWithWrapWidth:(NSUInteger)wrapWidth;

- (NSString *)base64EncodedString;

@end

@interface NSString (Help)

- (NSDate *)swithStringToDate;
+ (NSString *)swithDateToString:(NSDate *)date;

+ (NSString *)swithDate:(NSDate *)date toFormatDate:(NSString *)format;
/**
 默认时间格式转化 原始格式 yyyy-MM-dd HH:mm:ss

 @param format 需转化的时间格式 如:yyyy年MM月dd日 HH:mm:ss
 @return string
 */
- (NSString *)timeIntervalDefaultFormatToFormatDate:(NSString *)format;

/**
 时间格式转化

 @param origalFormat 原始格式:  如yyyyMMddHHmmss
 @param format 需转化的时间格式 如:yyyy-MM-dd HH:mm:ss
 @return string
 */
- (NSString *)timeIntervalOrigalFormat:(NSString *)origalFormat toFormatDate:(NSString *)format;


/**
 时间戳转化    原始格式:时间戳

 @param format 需转化的时间格式 如:yyyy-MM-dd HH:mm:ss
 @return string
 */
- (NSString *)timeStampToFormatDate:(NSString *)format;

- (NSString *)replace:(NSString *)target withString:(NSString *)replacement;

/**
 md5加密
 */
- (NSString *)md5_32bit;

/**
 手机号码判断
 */
-(BOOL)isMobileNumber;

- (NSString *)priceStringWithUnit:(BOOL)unit;

- (NSString *)trim;
- (BOOL)contains:(NSString *)substring;

- (NSString *)base64EncodedString;
- (NSString *)base64DecodedString;

//判断是否为整形：
- (BOOL)isPureInt;
//判断是否为浮点形：
- (BOOL)isPureFloat;

- (BOOL)isValidateEmail;
//
- (CGFloat)calculateTextFont:(int)font textMaxWidth:(CGFloat)width;
- (NSInteger)countOccurencesOfString:(NSString*)searchString;
+ (NSString *)showPhoneNumberWithNumber:(NSString *)number;
+ (BOOL)judgeIsEmptyWithString:(NSString *)string;//判断字符串是否为空 NUll
+ (NSString *)decimalWithFormat:(NSString *)format floatV:(float)floatV;

@end