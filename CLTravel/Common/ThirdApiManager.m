//
//  ThirdApiManager.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/22.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "ThirdApiManager.h"
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <ShareSDKUI/ShareSDKUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
//微信SDK头文件
#import "WXApi.h"
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "WeiboSDK.h"
#import <AlipaySDK/AlipaySDK.h>
#import "RSADataSigner.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AlicloudMobileAnalitics/ALBBMAN.h>

@implementation ThirdApiManager

+ (ThirdApiManager *)shareManager
{
    static dispatch_once_t pred;
    static ThirdApiManager *shared = nil;
    dispatch_once(&pred, ^{
        
        shared = [[self alloc]init];
    });
    return shared;
}

- (void)registerThirdApi
{
    //amap
    [AMapServices sharedServices].apiKey = AMapAppKey;
    
    //获取阿里云移动统计服务
    [[ALBBMANAnalytics getInstance] initWithAppKey:@"24804709" secretKey:@"cb01739d09d9fafdf693aee1e7d245d7"];
    [[ALBBMANAnalytics getInstance] setAppVersion:CLIENT_VERSION];
    [[ALBBMANAnalytics getInstance] setChannel:@"App Store"];
    
    
    //ShareSdk
//    [WXApi registerApp:@"wx369d283e29d7eb9a"];
//
////    [SSUIShareActionSheetStyle setShareActionSheetStyle:ShareActionSheetStyleSimple];
//    [ShareSDK registerActivePlatforms:@[@(SSDKPlatformSubTypeWechatSession),
//                                        @(SSDKPlatformSubTypeWechatTimeline),
//                                        @(SSDKPlatformTypeSinaWeibo),
//                                        @(SSDKPlatformTypeQQ),
//                                        @(SSDKPlatformTypeSMS)]
//                             onImport:^(SSDKPlatformType platformType) {
//
//                                 switch (platformType)
//                                 {
//                                     case SSDKPlatformTypeWechat:
//                                         //                             [ShareSDKConnector connectWeChat:[WXApi class]];
//                                         [ShareSDKConnector connectWeChat:[WXApi class] delegate:self];
//                                         break;
//                                     case SSDKPlatformTypeQQ:
//                                         [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
//                                         break;
//                                     case SSDKPlatformTypeSinaWeibo:
//                                         [ShareSDKConnector connectWeibo:[WeiboSDK class]];
//                                         break;
//                                    default:
//                                         break;
//                                 }
//                             }
//                      onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
//
//                          switch (platformType)
//                          {
//                              case SSDKPlatformTypeWechat:
//                                  [appInfo SSDKSetupWeChatByAppId:@"wx369d283e29d7eb9a"
//                                                        appSecret:@"eec7d5a1e5aabb3aa48d8798891845e5"];
//                                  break;
//                              case SSDKPlatformTypeQQ:
//                                  [appInfo SSDKSetupQQByAppId:@"1106414945"
//                                                       appKey:@"jE1TPurEWNJkaqrs"
//                                                     authType:SSDKAuthTypeBoth];
//                                  break;
//                              case SSDKPlatformTypeSinaWeibo:
//                                  //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
//                                  [appInfo SSDKSetupSinaWeiboByAppKey:@"1016033152"
//                                                            appSecret:@"ae3b97c6fbf54e24a25b24c06b08fae6"
//                                                          redirectUri:@"http://qyueche.com"
//                                                             authType:SSDKAuthTypeBoth];
//                                  break;
//                              default:
//                                  break;
//                          }
//                      }];

}

- (void)getThirdUserInfoCompletion:(void (^)(NSString *uid,NSString *nickName,NSString *headUrl))userBlock
{
//    if ([ShareSDK hasAuthorized:SSDKPlatformTypeWechat]) {
//        [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
//    }
//    [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
//        
//        if (state == SSDKResponseStateSuccess){
//            
////            NSLog(@"uid=%@",user.uid);
////            NSLog(@"%@",user.credential);
////            NSLog(@"token=%@",user.credential.token);
////            NSLog(@"nickname=%@",user.nickname);
//            if (userBlock) {
//                userBlock(user.uid,user.nickname,user.icon);
//            }
//        }
//        else{
//            NSLog(@"%@",error);
//        }
//    }];
}

- (void)sendThirdPayReqWithPayType:(QuPayType)payType payModel:(id)payModel success:(void (^)(void))paySuccessBlock fail:(void (^)(void))payFailBlock
{
    self.thirdPaySuccessBlock = paySuccessBlock;
    self.thirdPayFailBlock = payFailBlock;
    
    if (payType == QuPayType_WX) {
        
        WXPayModel *pay = (WXPayModel *)payModel;
       
//        PayMoneyReq *request = [[PayMoneyReq alloc]init];
//        request.partnerId = pay.partnerid;
//        request.prepayId = pay.prepayid;
//        request.package = pay.package;
//        request.nonceStr = pay.nonceStr;
//        request.timeStamp = pay.timeStamp;
//        request.sign = pay.sign;
//        [WXApi sendReq:request];
    }
    else{
        
        AlipayModel *pay = (AlipayModel *)payModel;
        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
        NSString *appScheme = @"Qyueche";
        
        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
        NSString *orderString = pay.orderStr;
        
        // NOTE: 调用支付结果开始支付
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            NSLog(@"reslut = %@",resultDic);
            NSString *result = [resultDic objectForKey:@"resultStatus"];
            
            if ([@"9000" isEqualToString:result]) {
                
                if (paySuccessBlock) {
                    paySuccessBlock();
                }
                
            }
            else{
                if (payFailBlock) {
                    payFailBlock();
                }
                
            }
            
        }];
        
    }
    
}

//- (void)sendThirdShareWithView:(UIView *)view model:(id)shareModel success:(void (^)(void))shareSuccessBlock fail:(void (^)(void))shareFailBlock
//{
//    QuShareModel *model = (QuShareModel *)shareModel;
//    
//    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//    [shareParams SSDKSetupShareParamsByText:model.content
//                                     images:model.pictureLinking
//                                        url:[NSURL URLWithString:model.pictureUrl]
//                                      title:model.title
//                                       type:SSDKContentTypeAuto];
//
//    [ShareSDK showShareActionSheet:view
//                             items:model.platforms
//                       shareParams:shareParams
//               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//                   
//                   switch (state) {
//                           
//                       case SSDKResponseStateBegin:
//                       {
//                           //设置UI等操作
//                           break;
//                       }
//                       case SSDKResponseStateSuccess:
//                       {
//                           if (shareSuccessBlock) {
//                               shareSuccessBlock();
//                           }
//                           break;
//                       }
//                       case SSDKResponseStateFail:
//                       {
//                           NSLog(@"%@",error);
//                           if (shareFailBlock) {
//                               shareFailBlock();
//                           }
//                           break;
//                       }
//                       case SSDKResponseStateCancel:
//                       {
//                           
//                           break;
//                       }
//                       default:
//                           break;
//                   }
//               }];
//
//}
//
//- (void)sendThirdShareWithPlatform:(SSDKPlatformType)platform model:(id)shareModel success:(void (^)(void))shareSuccessBlock fail:(void (^)(void))shareFailBlock
//{
//    QuShareModel *model = (QuShareModel *)shareModel;
//    
//    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
//    [shareParams SSDKSetupShareParamsByText:model.content
//                                     images:model.pictureLinking
//                                        url:[NSURL URLWithString:model.pictureUrl]
//                                      title:model.title
//                                       type:SSDKContentTypeAuto];
//    
//    //进行分享
//    [ShareSDK share:platform //传入分享的平台类型
//         parameters:shareParams
//     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
//         
//         switch (state) {
//                 
//             case SSDKResponseStateBegin:
//             {
//                 //设置UI等操作
//                 break;
//             }
//             case SSDKResponseStateSuccess:
//             {
//                 if (shareSuccessBlock) {
//                     shareSuccessBlock();
//                 }
//                 break;
//             }
//             case SSDKResponseStateFail:
//             {
//                 NSLog(@"%@",error);
//                 if (shareFailBlock) {
//                     shareFailBlock();
//                 }
//                 break;
//             }
//             case SSDKResponseStateCancel:
//             {
//                 
//                 break;
//             }
//             default:
//                 break;
//         }
//
//     }];
//    
//    
//}

@end
