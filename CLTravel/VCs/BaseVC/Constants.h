//
//  Constants.h
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/7/3.
//  Copyright © 2016年 朱青. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#import "AFNetworking.h"
#import "UIColor+HEX.h"
#import "MJExtension.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "QuRefreshHeader.h"
#import "QuLoadingHUD.h"
#import "ThirdApiManager.h"
#import "WZLBadgeImport.h"
#import "IQKeyboardManager.h"
#import "NSString+Help.h"
#import "NetWorkRequestModel.h"
#import "NetWorkClassModel.h"
#import "AccountInfo.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "PublicManager.h"
#import "LocalDataModel.h"
#import "CHAlertView.h"
#import "QuHudHelper.h"
#import "BaseNavigationController.h"
#import "BaseWebViewController.h"
#import "BaseInputVC.h"
#import "LoginViewController.h"
#import "NetWorkReqManager.h"
#import "UITextField+Help.h"
#import "UIImage+Help.h"
#import "UIView+Help.h"
#import "MAMapView+Help.h"
#import "UITableView+FooterBlank.h"
#import "UIScrollView+EmptyDataSet.h"
#import "UIDevice+DeviceModel.h"
#import "JPUSHService.h"
#import "QuDBManager.h"
#import "QuLocationManager.h"
#import "NSDate+HYBHelperKit.h"
#import "HDAlertView.h"
#import "QuShareView.h"
#import "UIButton+Help.h"
//高德地图
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>//地图
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>

#ifdef DEBUG

//#define HOSTNAME @"https://test.qyueche.cn/api/"
//#define HOSTNAME @"http://dev.qyueche.cn/api/"
//#define HOSTNAME @"http://192.168.1.189:8081/api/"
#define HOSTNAME @"https://main.qyueche.com/api/"
//#define HOSTNAME @"https://pre.qyueche.com/api/"

#define BUSPLANURL @"http://test.qyueche.cn/busline.html?"
#define NSLog(...) NSLog(__VA_ARGS__)


#else
//#define HOSTNAME @"https://main.qyueche.com/api/"
//#define HOSTNAME @"https://pre.qyueche.com/api/"
#define HOSTNAME @"https://test.qyueche.cn/api/"

#define BUSPLANURL @"http://test.qyueche.cn/busline.html?"
//在release版本禁止输出NSLog内容
#define NSLog(...){}

#endif


#define ScreenWidthRatio [[UIScreen mainScreen] bounds].size.width/375

//防止block里引用self造成循环引用
#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//RGB取色值
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//十六进制取色值
#define HEXCOLOR(value)  [UIColor colorWithHexString:value]

//主题色
#define COLOR_THEME HEXCOLOR(@"00a653")
//背景色
#define COLOR_BACK  HEXCOLOR(@"f6f6f6")
//字体大小
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]

//JPush AppKey
#define JPushAppKey @"b7aa3bd77e51c9087b0d67dd"
//高德地图AppKey
#define AMapAppKey @"8aebec3734eba4e0e5c2913f631de701"

//当前屏幕大小
#define SCREEN_SIZE   [[UIScreen mainScreen] bounds].size
#define SCREEN_WIDTH   [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height
#define SCREEN_NAV_HEIGHT ([[UIScreen mainScreen] bounds].size.height == 812.0 ? 88 : 64)
#define SCREEN_STATUSBAR_HEIGHT ([[UIScreen mainScreen] bounds].size.height == 812.0 ? 44 : 20)
#define SCREEN_BOTTOM_MARGIN ([[UIScreen mainScreen] bounds].size.height == 812.0 ? 34 : 0)

#define BUNDLE_ID [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]
#define CLIENT_VERSION [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleShortVersionString"]

#define APP_VERCODE_LIMIT 60

#define ACCOUNTINFO [AccountInfo shareRsp]

//==================支付宝支付===================
#define ALI_PARTNER                                  @"2016082401793923"
#define ALI_SELLTER                                  @"2088421321062320"
#define ALI_PRIVATE_KEY                           @"MIICdgIBADANBgkqhkiG9w0BAQEFAASCAmAwggJcAgEAAoGBAMVw0C9WBb6XLvlKuXn4qc60xMTAQscKG0itl8kLD7VjClTAA7XXhoB5tp8zw1uI8Lwki7YGAz/VF3vjmrShlwT+aL01rX+mEQd/5R2wyZPCJhcRa+IdJZ1DA8kbS2ZYw5aHtfJzKIbQ4k/a/ULYK/XGLlv2lO3ifEvqeUXHLT2RAgMBAAECgYB0U+yFB0TpL0Ag5xLytzytKjqIxdJSXTUIFCdK73Z443qRxnQpLmvzxEKB+EiQ5NUZtNqQC2jcshtdBhP/evlzkKr4jsfDY5c/pJKhqspWO0ZR6vyfswbwBqOlIevBeBdokmNg9sqXhP1J7x/AaZiump0Drviq6JeUfVYRfjh7xQJBAPcO4lelL3T2A2pziRyG+DAyX+dFWe24EUKRTRJZI64LmH2DlTSvgYeNZALqemPWGTnhrvoFdMxCEOmzYh7/2uMCQQDMljLfx9fS4/rL5X7uBABhVNQwMzQqvjSuqArTZ3DwGfHQzwhp14BM3C9QTvxKj1CYgER/478QSKnITXH3NKv7AkApG+/rt4/K/XiaCPmCpq67jlZI7FBHbv5oPjc921lFh6ZrFC8Koj2CabN/jLaq0CBIclYkQi4qIsAfsvqbv+UTAkBetlovB1F/LFP6+O/eOLQEW0UwW0QXVZ8GDH2WiRjbzucICBCZD08yRe0RfL+HtPlW4GrV2hWl8D3JoTDVhOjpAkEAoWK7c2CcU6PMUPanXng51KaFe2cOMYbv9r56VCSbt0gNlBRVDQy/pkW+V7qKNPZ0nmr+BzlaaK6kE7NfxJ7t+g=="

#define ALI_CALLBACK_URL                             @"http://121.40.216.91:8080/notify_url.jsp"
//==============================================

//判断是否大于ios几
#define IOS(a) ([[[UIDevice currentDevice] systemVersion] floatValue] >= a)
//屏幕尺寸
#define IS_iPhoneX        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 6P、6sP、7P、8P
#define IS_iPhone678_Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
// 6、6s、7、8
#define IS_iPhone678      ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
// 5、5s
#define IS_iPhone5        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
// 3g、4、4s
#define IS_iPhone34       ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define LOCATION_SUCCESS_NOTIFICATION  @"LOCATION_SUCCESS_NOTIFICATION"
#define TOKEN_INVAILD_NOTIFICATION  @"TOKEN_INVAILD_NOTIFICATION"
#define SHOW_VOICE_NOTIFICATION  @"SHOW_VOICE_NOTIFICATION"

#define URL_WALLET_RULE @"http://app-files.qyueche.com/public/wallet_rule.html"
#define URL_PROTOCOL_RULE @"http://app-files.qyueche.com/public/service_protocol_rule.html"
#define URL_COUPON_RULE @"http://app-files.qyueche.com/public/coupon_rule.html"
#define URL_TICKET_RULE @"http://app-files.qyueche.com/public/buy_refund_rule.html"
#define URL_SERVICE_RULE @"https://kefu.qyueche.com"

#define URL_APP_CHECK @"itms-apps://itunes.apple.com/cn/app/id1298945423?mt=8"

#endif /* Constants_h */
