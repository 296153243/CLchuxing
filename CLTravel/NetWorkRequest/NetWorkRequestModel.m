//
//  NetWorkRequestModel.m
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/7/3.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import "NetWorkRequestModel.h"

@implementation NetWorkRequestModel

@end

@implementation BaseRequest

- (id)init
{
    if (self = [super init]) {

//        self.versionNo = CLIENT_VERSION;
//        self.channelNo = @"iOS";
//        self.device = [PublicManager getDeviceId];

    }
    return self;
    
}

@end

@implementation BaseResponse

@end
@implementation BasePageResponse



@end
@implementation PageResponse

@end

@implementation GetCodeReq


@end

@implementation CheckCodeReq


@end

@implementation QuUserInfo


@end

@implementation CheckCodeRsp


@end

@implementation BindWeChatReq


@end

@implementation BindWeChatRsp


@end

@implementation CheckWeChatCodeReq


@end

@implementation CheckWeChatCodeRsp


@end

@implementation AutoLoginReq


@end

@implementation AutoLoginRsp


@end

@implementation GetPersonalInformationReq


@end

@implementation GetPersonalInformationRsp


@end

@implementation GetCityReq


@end

@implementation GetCityRsp

- (id)init{
    if (self = [super init]) {
        [GetCityRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"QuCityModel",
                     @"data1" : @"QuCityModel"};
        }];
    }
    return self;
}


@end

@implementation MainReq

@end

@implementation MainBannerData

- (id)init{
    if (self = [super init]) {
        [MainBannerData mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"bannerList" : @"MainBannerModel"};
        }];
    }
    return self;
}

@end

@implementation MainRsp

- (id)init{
    if (self = [super init]) {
        [MainRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"MainBannerModel",
                     @"data1" : @"MainRouteModel"};
        }];
    }
    return self;
}

@end

@implementation MainBannerModel



@end

@implementation MainRouteModel



@end

//检索路线 请求Model
@implementation SiteMatchReq



@end

@implementation SiteMatchRsp
-(instancetype)init{
    if (self == [super init]) {
        [SiteMatchRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"SiteInfoModel"};
        }];
    }
    return self;
}


@end
@implementation SiteInfoModel



@end
//检索路线 请求Model
@implementation GetFightingReq



@end
//检索路线 请求Model--1.1.0.4
@implementation FlightMatchReq


@end

@implementation GetFightingRsp
-(instancetype)init{
    if (self == [super init]) {
        [GetFightingRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"GetFightingModel"};
        }];
    }
    return self;
}


@end
@implementation GetFightingModel
-(id)init{
    if (self == [super init]) {
        [GetFightingModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"sites":@"SiteInfoModel"};
        }];
    }
    return self;
}


@end

@implementation GetFlightDetailsReq



@end

@implementation GetFlightDetailsModel

- (id)init{
    if (self = [super init]) {
        [GetFlightDetailsModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"sites" : @"SiteInfoModel"};
        }];
    }
    return self;
}


@end

@implementation GetFlightDetailsRsp



@end

@implementation RechargeReq



@end

@implementation WXPayModel



@end

@implementation AlipayModel



@end

@implementation RechargeRsp



@end

@implementation UpdateBalanceReq



@end

@implementation UpdateBalanceRsp



@end

@implementation GetBalanceReq



@end

@implementation GetBalanceModel



@end

@implementation GetBalanceRsp



@end


@implementation TicketDateReq



@end

@implementation TicketDateModel



@end

@implementation TicketDateRsp

- (id)init{
    if (self = [super init]) {
        [TicketDateRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"TicketDateModel"};
        }];
    }
    return self;
}


@end

@implementation AddOrderReq



@end

@implementation AddOrderModel



@end

@implementation AddOrderRsp

@end

@implementation GetCouponListReq



@end

@implementation GetCouponListModel



@end

@implementation GetCouponListRsp

- (id)init{
    if (self = [super init]) {
        [GetCouponListRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"GetCouponListModel"};
        }];
    }
    return self;
}

@end

@implementation AddFlightReq

@end

@implementation PayMoneyReq



@end

@implementation PayMoneyRsp



@end


@implementation GetOrderListReq



@end

@implementation GetOrderListModel



@end

@implementation GetOrderModel


- (id)init{
    if (self = [super init]) {
        [GetOrderModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"itemPage" : @"GetOrderListModel"};
        }];
    }
    return self;
}


@end

@implementation GetOrderListRsp

@end

@implementation GetMyOrderHistoryReq

@end

@implementation GetMyOrderHistoryModel

@end

@implementation GetMyOrderHistoryData

- (id)init{
    if (self = [super init]) {
        [GetMyOrderHistoryData mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"itemPage" : @"GetMyOrderHistoryModel"};
        }];
    }
    return self;
}

@end

@implementation GetMyOrderHistoryRsp

@end

@implementation ShareThemeReq



@end

@implementation QuShareModel



@end

@implementation ShareThemeRsp

@end

@implementation GetMyOrderInfoReq



@end

@implementation GetMyOrderInfoModel

@end

@implementation GetMyOrderModel

- (id)init{
    if (self = [super init]) {
        [GetMyOrderModel mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"itemPage" : @"GetMyOrderInfoModel"};
        }];
    }
    return self;
}


@end

@implementation GetMyOrderInfoRsp

@end

@implementation IsTicketRsp



@end

@implementation IsTicketReq

@end

@implementation GetMyOrderDetailReq

@end

@implementation GetMyOrderDetailRsp



@end

@implementation GetMyOrderSiteModel



@end

@implementation GetMyOrderDetalData

- (id)init{
    if (self = [super init]) {
        [GetMyOrderDetalData mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"siteList" : @"GetMyOrderSiteModel"};
        }];
    }
    return self;
}

@end

@implementation GetRefundsDateReq



@end

@implementation GetRefundsDateModel



@end

@implementation GetRefundsDateRsp

- (id)init{
    if (self = [super init]) {
        [GetRefundsDateRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"GetRefundsDateModel"};
        }];
    }
    return self;
}

@end

@implementation CancelOrderReq



@end

@implementation AddLinkReq



@end

@implementation AddLinkModel



@end

@implementation AddLinkRsp

- (id)init{
    if (self = [super init]) {
        [AddLinkRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"AddLinkModel"};
        }];
    }
    return self;
}

@end


@implementation MessageListModel

@end

@implementation FerryDateModel

@end

@implementation MapTrackReq

@end

@implementation MapTrackObject

@end

@implementation MapTrackLocation

@end

@implementation MapTrackRsp

- (id)init{
    if (self = [super init]) {
        [MapTrackRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"objects" : @"MapTrackObject"};
        }];
    }
    return self;
}

@end

@implementation ServiceLinkData

@end

@implementation ServiceLinkRsp

@end

@implementation RefreshTicketReq

@end

@implementation RefreshTicketData

@end

@implementation RefreshTicketRsp

@end

@implementation ReceiveCouponReq

@end

@implementation ReceiveCouponRsp

@end

@implementation MessageListReq

@end

@implementation MessageListRsp

- (id)init{
    if (self = [super init]) {
        [MessageListRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data" : @"MessageListModel"};
        }];
    }
    return self;
}

@end

@implementation MessageChangeReq

@end

@implementation TicketShareReq

@end

@implementation TicketShareCallBackReq

@end

@implementation CheckCompanyLineReq

@end

@implementation CheckAppVersionReq

@end

@implementation CheckAppVersionData

@end

@implementation CheckAppVersionRsp

@end

@implementation GetBootPageReq

@end

@implementation GetBootPageData

@end

@implementation GetBootPageRsp

@end

@implementation BusRouteModel

- (id)init{
    if (self = [super init]) {
        
        _busListArray = [[NSMutableArray alloc]init];
    }
    return self;
}


@end
