//
//  NetWorkClassModel.h
//  QuPassenger
//
//  Created by Chenmusong on 2017/10/24.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NetWorkClassModel : NSObject

@end

//MARK:-------initiatingRoute
@interface InitiatingRouteReq : BaseRequest
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *startName;
@property (strong, nonatomic) NSString *endName;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *updateTime;
@property (strong, nonatomic) NSString *startLat;
@property (strong, nonatomic) NSString *startLong;
@property (strong, nonatomic) NSString *endlat;
@property (strong, nonatomic) NSString *endLong;
@property (strong, nonatomic) NSString *remarkId;
@end

//MARK:-------票列表Req
@interface GetTicketListReq : BaseRequest
@property (strong, nonatomic) NSString *userId;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSInteger currentSize;
@end

//MARK:-------票列表rsp
@interface GetTicketListRsp : BaseResponse

@property (nonatomic,strong) NSArray *SumTicket;
@property (nonatomic,assign) NSInteger totalPage;

@end
//MARK:-------票列表model
@interface GetTicketListModel : BaseResponse


@property (nonatomic) NSInteger carType;
@property (strong, nonatomic) NSString *endStation;
@property (strong, nonatomic) NSString *startStation;
@property (strong, nonatomic) NSString *busTime;
@property (strong, nonatomic) NSArray *busTimes;
@property (strong, nonatomic) NSString *flightDateStr;
@property (nonatomic) NSInteger flightId;
@property (nonatomic) NSInteger totalFlightId;
@property (strong, nonatomic) NSString *orderNo;
@property (nonatomic) NSInteger ticketCount;
@property (strong, nonatomic) NSString *barcode;
@property (assign, nonatomic) NSInteger canShowCode;
@end

//MARK:-------获取评论标语Rsp
@interface GetCommentRsp : BaseResponse
@property (strong, nonatomic)NSArray *data;

@end
//MARK:-------获取评论标语Rsp
@interface GetCommentModel : BaseResponse
@property (nonatomic)NSInteger id;
@property (strong, nonatomic) NSString *comment;
@property (strong, nonatomic) NSString *createTime;

@end
//MARK:-------获取评论标语
@interface AddCommentReq : BaseRequest
@property (strong, nonatomic) NSString *flightId;
@property (strong, nonatomic) NSString *userId;
@property (nonatomic) NSInteger starLevel;
@property (nonatomic) NSInteger commentId;
@end

@interface StarAndEndMOdel : NSObject
//@property (strong, nonatomic) NSString *starId;
@property (strong, nonatomic) NSString *starName;
@property (strong, nonatomic) NSString *startLongitude;
@property (strong, nonatomic) NSString *startLat;

//@property (strong, nonatomic) NSString *endId;
@property (strong, nonatomic) NSString *endName;
@property (strong, nonatomic) NSString *endLongitude;
@property (strong, nonatomic) NSString *endLat;


- (instancetype)initWithDic:(NSDictionary *)dictionary;

@end

//MARK:-------上下班地址Req
@interface SetCommuteTimeReq : BaseRequest
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *upTime;
@property (strong, nonatomic) NSString *upAddress;
@property (strong, nonatomic) NSString *downTime;
@property (strong, nonatomic) NSString *downAddress;
@end
//MARK:-------个人信息修改
@interface UserInfoUploadImgReq : BaseRequest
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *file;
@property (strong, nonatomic) NSString *nickName;
@property (nonatomic,strong) NSString *sex;
@property (strong, nonatomic) NSString *sign;
@end
//MARK:-------优惠券详情req
@interface CouponReq : BaseRequest
@property (strong, nonatomic) NSString *userId;
@property (nonatomic) NSInteger currentPage;
@property (nonatomic) NSInteger pageSize;
@property (nonatomic) NSInteger status;//0 不可用 2 可用）
@property(nonatomic,strong) NSString *orderNo;
@end

@interface CouponUserListRsp : BasePageResponse
@property(nonatomic,strong)NSArray *itemPage;
@end

@interface CouponDetailsRsp : BaseResponse
@property(nonatomic,strong)BaseResponse *data;
@end
//MARK:-------优惠券详情Model
@interface CouponDetailModel : BaseResponse
@property (nonatomic)NSInteger couponType;//1.折扣 2现金
@property (strong, nonatomic) NSString *couponName;
@property (nonatomic) float discount;//现金值
@property (nonatomic) float fixedAmount;//折扣值
@property (nonatomic) NSInteger issueMode;//( 1领取 2任务发放）
@property (strong, nonatomic) NSString *startTime;
@property (strong, nonatomic) NSString *endTime;
@property (nonatomic) NSInteger carType;//(3购票摆渡/4购票通勤车）
@property (nonatomic) NSInteger overly;//(1允许叠加 2不允许）
@property (nonatomic) NSInteger limitMoneyType;//(1不限制 2满用）
@property (strong, nonatomic) NSString *minAmount;//(优惠券最低使用金额
@property (strong, nonatomic) NSString *remark;//(优惠券说明）
@property (strong, nonatomic) NSString *isValid;//(0 不可用 1 可用）
@property (strong, nonatomic) NSString *userId;//创建人id
@property (strong, nonatomic) NSString *createTime;//领取券时间
@property(strong, nonatomic)NSArray *lineList;
@property(nonatomic)float noteH;
@property(nonatomic)float lineH;


@end

//MARK:-------优惠券详情req
@interface CouponDetaliReq : BaseRequest
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *id;

@end
//MARK:-------优惠券详情req
@interface GetRemarkRsp : BaseResponse
@property (strong, nonatomic) NSArray *data;

@end

@interface GetRemarkModel : BaseResponse
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *id;

@end
