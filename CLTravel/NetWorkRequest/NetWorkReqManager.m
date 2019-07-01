//
//  BaseNetWorkRequest.m
//  FreshFood
//
//  Created by 朱青 on 2017/7/24.
//  Copyright © 2017年 FreshFood. All rights reserved.
//

#import "NetWorkReqManager.h"
#import "AppDelegate.h"

@implementation NetWorkReqManager

- (instancetype)initWithApiName:(XQApiName)apiName params:(id)params
{
    _apiName = apiName;
    _params = params;
    return [self init];
}

- (void)postRequestWithResponse:(requestSuccess)responseBlock errorResponse:(requestFailure)errorBlock
{
    NSMutableDictionary *muParams;
    if (self.params) {
        if ([self.params isKindOfClass:[NSDictionary class]]) {
            muParams = [NSMutableDictionary dictionaryWithDictionary:self.params];
        }
        else{
            NSDictionary *dic = [self.params mj_keyValues];
            muParams = [NSMutableDictionary dictionaryWithDictionary:dic];
        }
    }
    else{
        muParams = [NSMutableDictionary new];
    }
    [NetWorkEngine addHeaderFieldsWithDictionary:[NetWorkReqManager addCustomHeaders]];
    [NetWorkEngine requestWithType:HttpRequestTypePost withUrlString:@"" withParaments:muParams withSuccessBlock:^(NSDictionary *responseObject) {
        NSLog(@"返回数据:%@",responseObject);
        BaseResponse *response = [BaseResponse mj_objectWithKeyValues:responseObject];

        if (response.code == 400004){
            //预留token过期处理
//            [QuLoadingHUD dismiss];
//            [PublicManager showAlert:response.message withDoneBlock:^{
//                
//                [NetWorkReqManager tokenInvalidActionWithApiName:apiName];
//            }];
        }
        else{
            responseBlock(responseObject);
//            errorBlock(response.message);
        }
    } withFailureBlock:errorBlock progress:nil];
}

+ (void)requestDataWithApiName:(XQApiName)apiName params:(id)params response:(requestSuccess)responseBlock errorResponse:(requestFailure)errorBlock
{
    
   
    NSMutableDictionary *muParams;
    if (params) {
        if ([params isKindOfClass:[NSDictionary class]]) {
            muParams = [NSMutableDictionary dictionaryWithDictionary:params];
        }
        else{
            NSDictionary *dic = [params mj_keyValues];
            muParams = [NSMutableDictionary dictionaryWithDictionary:dic];
        }
    }
    else{
        muParams = [NSMutableDictionary new];
    }
   
    NSString *urlString = [HOSTNAME stringByAppendingString:XQApiNameEnum(apiName)];
    NSLog(@"请求URL：%@",urlString);
    NSLog(@"请求参数：%@",muParams);
    [NetWorkEngine addHeaderFieldsWithDictionary:[NetWorkReqManager addCustomHeaders]];
    [NetWorkEngine requestWithType:HttpRequestTypePost withUrlString:urlString withParaments:muParams withSuccessBlock:^(NSDictionary *responseObject) {
        NSLog(@"返回数据:%@",responseObject);
        BaseResponse *response = [BaseResponse mj_objectWithKeyValues:responseObject];
        
        if (response.code == 400004){
            //预留token过期处理
            [QuLoadingHUD dismiss];
            [PublicManager showAlert:response.message withDoneBlock:^{
                
                [NetWorkReqManager tokenInvalidActionWithApiName:apiName];
            }];
        }
        else{
            responseBlock(responseObject);
//            errorBlock(response.message);
        }
    } withFailureBlock:errorBlock progress:nil];
}

+ (void)requestTencentTrackTestWithParams:(MapTrackReq *)params response:(requestSuccess)responseBlock errorResponse:(requestFailure)errorBlock
{
    
    NSString *urlString = [NSString stringWithFormat:@"https://apis.map.qq.com/tws/v1/object/search?key=%@&service_id=%@&object_id=%@",params.key,params.service_id,params.object_id];
 
    [NetWorkEngine requestWithType:HttpRequestTypeGet withUrlString:urlString withParaments:nil withSuccessBlock:^(NSDictionary *responseObject) {
        NSLog(@"返回数据:%@",responseObject);
        BaseResponse *response = [BaseResponse mj_objectWithKeyValues:responseObject];
        
        if (response.code == 1001){
            //token过期处理
            
            
        }
        else{
            responseBlock(responseObject);
            //            errorBlock(response.message);
        }
    } withFailureBlock:errorBlock progress:nil];
}

//设置请求头
+ (NSDictionary *)addCustomHeaders
{
    NSMutableDictionary *headers = [NSMutableDictionary dictionary];

    [headers setObject:[PublicManager getDeviceId] forKey:@"device"];
    [headers setObject:@"iOS" forKey:@"channelNo"];
    [headers setObject:CLIENT_VERSION forKey:@"versionNo"];
    
    if(ACCOUNTINFO.userInfo.token.trim.length > 0){
        
        [headers setObject:ACCOUNTINFO.userInfo.token forKey:@"token"];
    }
    else{
        [headers setObject:@"" forKey:@"token"];
    }

    return headers;
}

//token过期处理
+ (void)tokenInvalidActionWithApiName:(XQApiName)apiName
{
    ACCOUNTINFO.userInfo = nil;
    ACCOUNTINFO.isLogin = NO;
    [JPUSHService deleteAlias:^(NSInteger iResCode, NSString *iAlias, NSInteger seq) {
        
    } seq:0];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    BaseNavigationController *nav = (BaseNavigationController *)delegate.window.rootViewController;
    [nav popToRootViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter]postNotificationName:TOKEN_INVAILD_NOTIFICATION object:nil];
}

@end
