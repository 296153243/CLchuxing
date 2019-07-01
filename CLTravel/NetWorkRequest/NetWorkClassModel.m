//
//  NetWorkClassModel.m
//  QuPassenger
//
//  Created by Chenmusong on 2017/10/24.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "NetWorkClassModel.h"

@implementation NetWorkClassModel

@end

@implementation InitiatingRouteReq

@end

@implementation GetTicketListReq

@end

@implementation GetTicketListRsp
- (instancetype)init{
    if (self == [super init]) {
        [GetTicketListRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"SumTicket":@"GetTicketListModel"};
        }];
    }
    return self;
}
@end
@implementation GetTicketListModel

@end

@implementation GetCommentRsp
- (instancetype)init{
    if (self == [super init]) {
        [GetCommentRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"GetCommentModel"};
        }];
    }
    return self;
}

@end

@implementation GetCommentModel


@end

@implementation AddCommentReq


@end
@implementation StarAndEndMOdel

- (instancetype)initWithDic:(NSDictionary *)dictionary{
    if (self == [super init]) {
//        _starId = dictionary[@"starId"];
//        _endId = dictionary[@"endId"];

        _starName = dictionary[@"starName"];
        _endName = dictionary[@"endName"];
        _startLongitude = dictionary[@"startLongitude"];
        _startLat = dictionary[@"startLat"];
        _endLongitude = dictionary[@"endLongitude"];
        _endLat = dictionary[@"endLat"];
    }
    return self;
}

@end


@implementation SetCommuteTimeReq



@end

@implementation UserInfoUploadImgReq



@end

@implementation CouponReq

@end

@implementation CouponUserListRsp
-(id)init{
    if (self == [super init]) {
        [CouponUserListRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"itemPage":@"GetCouponListModel"};
        }];
    }
    return self;
}
@end

@implementation CouponDetailsRsp

@end

@implementation CouponDetailModel


@end

@implementation CouponDetaliReq

@end
@implementation GetRemarkRsp
-(id)init{
    if (self == [super init]) {
        [GetRemarkRsp mj_setupObjectClassInArray:^NSDictionary *{
            return @{@"data":@"GetRemarkModel"};
        }];
    }
    return self;
}
@end
@implementation GetRemarkModel

@end

