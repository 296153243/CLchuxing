//
//  NetWorkRequestModel.h
//  GuangYiGuang_App
//
//  Created by 朱青 on 16/7/3.
//  Copyright © 2016年 朱青. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkRequestModel : NSObject

@end

@interface BaseRequest : NSObject

//@property (strong, nonatomic) NSString *versionNo;
//@property (strong, nonatomic) NSString *channelNo;
//@property (strong, nonatomic) NSString *device;

@end
//TODO:-------优惠券列表Model
@interface GetCouponListModel : NSObject

@property (strong, nonatomic) NSString *carType;
@property (strong, nonatomic) NSString *couponName;
@property (nonatomic) NSInteger couponType;//1.折扣券 2.现金券）
@property (nonatomic)float discount;//现金值
@property (strong, nonatomic) NSString *endTime;
@property (nonatomic)double fixedAmount;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *totalMoney;
@property (strong, nonatomic) NSString *isValid;
@property(nonatomic)NSInteger overly;//(1允许叠加 2不允许）
@property (nonatomic)float minAmount;
@property (strong, nonatomic) NSString *startTime;
@property (strong, nonatomic) NSString *endTimeStr;
@property (strong, nonatomic) NSString *takeCouponType;// --1新用户领取 2参加活动领取 10任务发放微信分享11任务发放微博分享
@property (nonatomic) NSInteger status;//  --1 未生效 2 生效中 3 已失效 4 已使用
@property (strong, nonatomic) NSString *createTime;
@property (strong, nonatomic) NSString *useTime;
@property (assign, nonatomic) NSInteger limitMoneyType;
@property (nonatomic) NSInteger isSelect;//是否选择  1 选中

@end


@interface PageResponse : NSObject

@property (assign, nonatomic) NSInteger begin;
@property (assign, nonatomic) NSInteger pageSize;
@property (assign, nonatomic) NSInteger totalRows;
@property (assign, nonatomic) NSInteger pageCount;
@property(strong,nonatomic) NSArray *itemPage;
@end

@interface BaseResponse : NSObject

@property (strong, nonatomic) NSString *message;
@property (assign, nonatomic) NSInteger code;
@end

@interface BasePageResponse : BaseResponse

@property (strong, nonatomic)PageResponse *data;
@end

//获取验证码
@interface GetCodeReq : BaseRequest

@property (strong, nonatomic) NSString *phone;
@property (assign, nonatomic) NSInteger type; //1:手机登陆 type 2:微信绑定

@end

//验证码登录
@interface CheckCodeReq : BaseRequest

@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *code;


@end

@interface QuUserInfo : NSObject

@property (strong, nonatomic) NSString *memberID;
@property (strong, nonatomic) NSString *code;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *nickName;
@property (strong, nonatomic) NSString *weixinCode;
@property (strong, nonatomic) NSString *idCard;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *phoneCode;
@property (strong, nonatomic) NSString *sex;
@property (strong, nonatomic) NSString *headImg;
@property (strong, nonatomic) NSString *travelNum;
@property (strong, nonatomic) NSString *cancelNum;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSString *token;
@property (strong, nonatomic) NSString *device;
@property (strong, nonatomic) NSString *upTime;
@property (strong, nonatomic) NSString *downTime;
@property (strong, nonatomic) NSString *downAddress;
@property (strong, nonatomic) NSString *upAddress;
@property (strong, nonatomic) NSString *linkName;
@property (strong, nonatomic) NSString *linkMobile;
@property (strong, nonatomic) NSString *balance;
@property (strong, nonatomic) NSString *dateOfBrith;
@property (strong, nonatomic) NSString *company;
@property (strong, nonatomic) NSString *sign;
@property (strong, nonatomic) NSString *dt;
@property (strong, nonatomic) NSString *alias;

@end

@interface CheckCodeRsp : BaseResponse

@property (strong, nonatomic) QuUserInfo *data;

@end

//微信登录
@interface BindWeChatReq : BaseRequest

@property (strong, nonatomic) NSString *winXinKey;
@property (strong, nonatomic) NSString *phone;

@end

@interface BindWeChatRsp : BaseResponse

@property (strong, nonatomic) QuUserInfo *data;

@end

//微信绑定手机号
@interface CheckWeChatCodeReq : BaseRequest

@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *winXinKey;
@property (strong, nonatomic) NSString *nick;
@property (strong, nonatomic) NSString *headImage;
@property (strong, nonatomic) NSString *code;

@end

@interface CheckWeChatCodeRsp : BaseResponse

@property (strong, nonatomic) QuUserInfo *data;

@end

//自动登录
@interface AutoLoginReq : BaseRequest

@property (strong, nonatomic) NSString *userId;

@end

@interface AutoLoginRsp : BaseResponse

@property (strong, nonatomic) QuUserInfo *data;

@end

//获取用户信息
@interface GetPersonalInformationReq : BaseRequest

@property (strong, nonatomic) NSString *userId;

@end

@interface GetPersonalInformationRsp : BaseResponse

@property (strong, nonatomic) QuUserInfo *data;

@end

//获取城市
@interface GetCityReq : BaseRequest

@end

@interface GetCityRsp : BaseResponse

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSArray *data1;

@end

@interface MainReq : BaseRequest

@property (strong, nonatomic) NSString *cityCode;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *lat;

@end

@interface MainBannerData : NSObject

@property (assign, nonatomic) CGFloat bannerHigh;
@property (assign, nonatomic) CGFloat bannerLong;
@property (assign, nonatomic) CGFloat bannerThan;
@property (assign, nonatomic) CGFloat intervalTime;
@property (strong, nonatomic) NSArray *bannerList;

@end

@interface MainRsp : BaseResponse

@property (strong, nonatomic) MainBannerData *banner;
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSArray *data1;
@property (assign, nonatomic) NSInteger isOpen;


@end

@interface MainBannerModel : NSObject

@property (strong, nonatomic) NSString *bannerUrl;
@property (strong, nonatomic) NSString *bannerLink;
@property (strong, nonatomic) NSString *bannerType;

@end

@interface MainRouteModel : NSObject

@property (strong, nonatomic) NSString *carNo;
@property (strong, nonatomic) NSString *carType;
@property (strong, nonatomic) NSString *driverId;
@property (strong, nonatomic) NSString *driverName;
@property (strong, nonatomic) NSString *exceptArrivalTime;
@property (strong, nonatomic) NSString *flightId;
@property (strong, nonatomic) NSString *flightName;
@property (strong, nonatomic) NSString *goTime;
@property (strong, nonatomic) NSString *lineId;
@property (strong, nonatomic) NSString *onTrainId;
@property (strong, nonatomic) NSString *onTrainName;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *sumVote;
@property (strong, nonatomic) NSString *downTrainId;
@property (strong, nonatomic) NSString *downTrainName;
//@property (strong, nonatomic) NSString *goTimeStr;
@property (strong, nonatomic) NSString *flightDateStr;
@property (assign, nonatomic) NSInteger startSiteType;//1：企业站点 0：普通站点
@property (assign, nonatomic) NSInteger endSiteType;//1：企业站点 0：普通站点
@property (assign, nonatomic) NSInteger companyLineType; //1：企业班线 0：普通班线

@end

//MARK:-----检索附近地址请求MOdel
@interface SiteMatchReq : BaseRequest

@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *cityCode;
@property (strong, nonatomic) NSString  *str;

@end
//MARK:-----检索附近地址返回Model

@interface SiteMatchRsp : BaseResponse


@property (strong, nonatomic) NSArray *data;


@end
//MARK:-----检索附近地址数据解析Model
@interface SiteInfoModel : BaseResponse

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *cityCode;
@property (strong, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *siteName;
@property (strong, nonatomic) NSArray *imgList;
@property (strong, nonatomic) NSString *seconds;
@property (assign, nonatomic) NSInteger type;//本地使用字段 0.始发站 1.末站 2.用户上车站 3 用户下车站
@property (assign, nonatomic) NSInteger siteType;//1.企业站点 0.普通站点


@end
//MARK:-----班次匹配请求MOdel
@interface GetFightingReq : BaseRequest

@property (strong, nonatomic) NSString *startId;
@property (strong, nonatomic) NSString *endId;
@property (strong, nonatomic) NSString *cityCode;

@property (strong, nonatomic) NSString *seconds;
@property (assign, nonatomic) NSInteger type;//本地使用字段 0.始发站 1.末站 2.用户上车站 3 用户下车站

@end
//MARK:-----班次匹配请求MOdel
@interface FlightMatchReq : BaseRequest

@property (strong, nonatomic) NSString *startName;
@property (strong, nonatomic) NSString *startLat;
@property (strong, nonatomic) NSString *startLongitude;

@property (strong, nonatomic) NSString *endName;
@property (strong, nonatomic) NSString *endLat;
@property (strong, nonatomic) NSString *endLongitude;

@end

//MARK:-----班次匹配返回Model

@interface GetFightingRsp : BaseResponse


@property (strong, nonatomic) NSArray *data;


@end
//MARK:-----班次匹配数据解析Model
@interface GetFightingModel : BaseResponse

@property (strong, nonatomic) NSString *carNo;
@property (strong, nonatomic) NSString *carType;
@property (nonatomic) NSInteger goTime;
@property (strong, nonatomic) NSString *siteSeconds;
@property (strong, nonatomic) NSString *intervalTime;//多长时间一班
@property (strong, nonatomic) NSString *flightDateStr;
@property (strong, nonatomic) NSString *flightDateStr1;
@property (strong, nonatomic) NSString *endName;
@property (strong, nonatomic) NSString *endId;
@property (strong, nonatomic) NSString *requriedTime;
@property (nonatomic) double downTrainlat;
@property (nonatomic) double downTrainlongitude;
@property (strong, nonatomic) NSString *startId;
@property (strong, nonatomic) NSString *startName;
@property (nonatomic) double onTrainlat;
@property (nonatomic) double onTrainlongitude;
@property (strong, nonatomic) NSString *lineId;
@property (nonatomic) NSInteger exceptArrivalTime;
@property (strong, nonatomic) NSString *flightId;
@property (strong, nonatomic) NSString *sumVote;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *driverId;
@property (strong, nonatomic) NSString *driverName;
@property (assign, nonatomic) NSInteger startSiteType;//1：企业站点 0：普通站点
@property (assign, nonatomic) NSInteger endSiteType;//1：企业站点 0：普通站点
@property (assign, nonatomic) NSInteger companyLineType; //1：企业班线 默认0：普通班线
@property(strong,nonatomic)NSArray *sites;
@end


@interface GetFlightDetailsReq : BaseRequest

@property (strong, nonatomic) NSString *flightId;
@property (strong, nonatomic) NSString *startId;
@property (strong, nonatomic) NSString *endId;

@end

@interface GetFlightDetailsModel : NSObject

@property (strong, nonatomic) NSString *carNo;
@property (strong, nonatomic) NSString *carType;
@property (strong, nonatomic) NSString *driverId;
@property (strong, nonatomic) NSString *driverName;
@property (strong, nonatomic) NSString *exceptArrivalTime;
@property (strong, nonatomic) NSString *flightId;
@property (strong, nonatomic) NSString *goTime;
//@property (strong, nonatomic) NSString *goTimeStr;
@property (strong, nonatomic) NSString *flightDateStr;
@property (strong, nonatomic) NSString *lineId;
@property (strong, nonatomic) NSString *onTrainId;
@property (strong, nonatomic) NSString *price;
@property (strong, nonatomic) NSString *startId;
@property (strong, nonatomic) NSString *startName;
@property (strong, nonatomic) NSString *endId;
@property (strong, nonatomic) NSString *endName;
@property (strong, nonatomic) NSArray *sites;
@property (assign, nonatomic) NSInteger startSiteType;//1：企业站点 2：普通站点
@property (assign, nonatomic) NSInteger endSiteType;//1：企业站点 2：普通站点


@end

@interface GetFlightDetailsRsp : BaseResponse

@property (strong, nonatomic) GetFlightDetailsModel *data;

@end

@interface RechargeReq : BaseRequest

@property (strong, nonatomic) NSString *fees;
@property (strong, nonatomic) NSString *memberId;
@property (assign, nonatomic) NSInteger type;

@end

@interface WXPayModel : NSObject

@property (strong, nonatomic) NSString *appId;
@property (strong, nonatomic) NSString *nonceStr;
@property (strong, nonatomic) NSString *package;
@property (strong, nonatomic) NSString *partnerid;
@property (strong, nonatomic) NSString *prepayid;
@property (strong, nonatomic) NSString *sign;
@property (assign, nonatomic) UInt32 timeStamp;
@property (strong, nonatomic) NSString *orderNo;

@end

@interface AlipayModel : NSObject

@property (strong, nonatomic) NSString *orderStr;
@property (strong, nonatomic) NSString *orderNo;

@end

@interface RechargeRsp : BaseResponse

@property (strong, nonatomic) WXPayModel *data;
@property (strong, nonatomic) AlipayModel *data1;

@end

@interface UpdateBalanceReq : BaseRequest

@property (strong, nonatomic) NSString *orderNo;
@property (assign, nonatomic) NSInteger type;//1.充值 2.购票

@end

@interface UpdateBalanceRsp : BaseResponse


@end

@interface GetBalanceReq : BaseRequest

@property (strong, nonatomic) NSString *memberId;

@end

@interface GetBalanceModel : NSObject

@property (strong, nonatomic) NSString *balance;

@end

@interface GetBalanceRsp : BaseResponse

@property (strong, nonatomic) GetBalanceModel *data;

@end

@interface TicketDateReq : BaseRequest

@property (strong, nonatomic) NSString *flightId;
@property (strong, nonatomic) NSString *startId;
@property (strong, nonatomic) NSString *endId;
@property (strong, nonatomic) NSString *memberId;

@end

@interface TicketDateModel : NSObject

@property (strong, nonatomic) NSString *flightId;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *ticketDate;
@property (strong, nonatomic) NSString *ticketPrice;
@property (strong, nonatomic) NSString *carType;

@property (strong, nonatomic) NSDate *buyDate;
@property (assign, nonatomic) BOOL *canChoose;
@property (assign, nonatomic) NSInteger buyCount;

@end

@interface TicketDateRsp : BaseResponse

@property (strong, nonatomic) NSArray *data;

@end

@interface AddOrderReq : BaseRequest

@property (strong, nonatomic) NSString *flightId;
@property (strong, nonatomic) NSString *startId;
@property (strong, nonatomic) NSString *endId;
@property (strong, nonatomic) NSString *fees;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *memberId;

@end

@interface AddOrderModel : NSObject

@property (strong, nonatomic) NSString *orderNo;
@property (strong, nonatomic) NSString *totalMoney;
@property (strong, nonatomic) NSString *trueMoney;
@property (assign, nonatomic) NSInteger isCompanyPay;//是否支持企业支付 1.支持 0.不支持
@property (strong, nonatomic) GetCouponListModel *coupon;

@end

@interface AddOrderRsp : BaseResponse

@property (strong, nonatomic) AddOrderModel *data;

@end

@interface GetCouponListReq : BaseRequest

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *orderNo;

@end

@interface GetCouponListRsp : BaseResponse

@property (strong, nonatomic) NSArray *data;

@end

@interface AddFlightReq : BaseRequest

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *lineId;

@end

@interface PayMoneyReq : BaseRequest

@property (strong, nonatomic) NSString *orderNo;
@property (assign, nonatomic) NSInteger type;
@property(nonatomic,strong)NSString *couponId;

@end

@interface PayMoneyRsp : BaseResponse

@property (strong, nonatomic) WXPayModel *data;
@property (strong, nonatomic) AlipayModel *data1;

@end

@interface GetOrderListReq : BaseRequest

@property (strong, nonatomic) NSString *memberId;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger pageSize;

@end

@interface GetOrderListModel : NSObject

@property (strong, nonatomic) NSString *changeDate;
@property (strong, nonatomic) NSString *changeDateStr;
@property (strong, nonatomic) NSString *end;
@property (strong, nonatomic) NSString *endAddrX;
@property (strong, nonatomic) NSString *endAddrY;
@property (strong, nonatomic) NSString *fees;
@property (strong, nonatomic) NSString *goTime;
//@property (strong, nonatomic) NSString *goTimeStr;
@property (strong, nonatomic) NSString *flightDateStr;
@property (strong, nonatomic) NSString *memberOrderNo;
@property (strong, nonatomic) NSString *memo;
@property (strong, nonatomic) NSString *peoples;
@property (strong, nonatomic) NSString *stAddrX;
@property (strong, nonatomic) NSString *stAddrY;
@property (strong, nonatomic) NSString *start;
@property (strong, nonatomic) NSString *flightId;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *type;

@end

@interface GetOrderModel : NSObject

@property (assign, nonatomic) NSInteger begin;
@property (assign, nonatomic) NSInteger pageSize;
@property (assign, nonatomic) NSInteger totalRows;
@property (assign, nonatomic) NSInteger pageCount;
@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSArray *itemPage;


@end

@interface GetOrderListRsp : BaseResponse

@property (strong, nonatomic) GetOrderModel *data;

@end

@interface GetMyOrderHistoryReq : BaseRequest

@property (strong, nonatomic) NSString *userId;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger pageSize;

@end

@interface GetMyOrderHistoryModel : NSObject

@property (strong, nonatomic) NSString *OrderNo;
@property (strong, nonatomic) NSString *end;
@property (strong, nonatomic) NSString *exceptArrivalTime;
@property (strong, nonatomic) NSString *flightId;
//@property (strong, nonatomic) NSString *goTime;
@property (strong, nonatomic) NSString *flightDateStr;
@property (strong, nonatomic) NSString *start;
@property (strong, nonatomic) NSString *carType;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *starLevel;

@end

@interface GetMyOrderHistoryData : NSObject

@property (assign, nonatomic) NSInteger begin;
@property (assign, nonatomic) NSInteger pageSize;
@property (assign, nonatomic) NSInteger totalRows;
@property (assign, nonatomic) NSInteger pageCount;
@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSArray *itemPage;


@end

@interface GetMyOrderHistoryRsp : BaseResponse

@property (strong, nonatomic) GetMyOrderHistoryData *data;

@end

@interface ShareThemeReq : BaseRequest

@property (strong, nonatomic) NSString *memberId;
@property (strong, nonatomic) NSString *startId;
@property (strong, nonatomic) NSString *endId;

@end


@interface QuShareModel : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) id pictureLinking;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *pictureUrl;
@property (strong, nonatomic) NSArray *platforms;
@property (strong, nonatomic) NSArray *platform;

@end

@interface ShareThemeRsp : BaseResponse

@property (strong, nonatomic) QuShareModel *data;

@end

@interface GetMyOrderInfoReq : BaseRequest

@property (strong, nonatomic) NSString *userId;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) NSInteger pageSize;
@property (strong, nonatomic) NSString *startTime;

@end


@interface GetMyOrderInfoModel : NSObject

//返回：name：退款名称,fees 金额,orderNo 订单id,tranType类型  1: 收支-充值   2：收支-退款  3：消费,createTime 创建时间  type:0拼车/1专车/2充值/3购票摆渡/4购票通勤车
@property (assign, nonatomic) NSInteger companyId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *fees;
@property (strong, nonatomic) NSString *orderNo;
@property (strong, nonatomic) NSString *createTime;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *tranType;

@end

@interface GetMyOrderModel : NSObject

@property (assign, nonatomic) NSInteger begin;
@property (assign, nonatomic) NSInteger pageSize;
@property (assign, nonatomic) NSInteger totalRows;
@property (assign, nonatomic) NSInteger pageCount;
@property (assign, nonatomic) NSInteger currentPage;
@property (strong, nonatomic) NSArray *itemPage;


@end

@interface GetMyOrderInfoRsp : BaseResponse

@property (strong, nonatomic) GetMyOrderModel *data;

@end

@interface IsTicketReq : BaseRequest

@property (strong, nonatomic) NSString *userId;

@end

@interface IsTicketRsp : BaseResponse

@property (assign, nonatomic) NSInteger data;

@end

@interface GetMyOrderDetailReq : BaseRequest

@property (strong, nonatomic) NSString *orderNo;
@property (strong, nonatomic) NSString *flightId;

@end

@interface GetMyOrderSiteModel : NSObject

@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *siteName;
@property (strong, nonatomic) NSString *cityCode;
@property (strong, nonatomic) NSString *longitude;
@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *cityName;
@property (strong, nonatomic) NSArray *imgList;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *seconds;
@property (strong, nonatomic) NSString *pictureUrl;



@end

@interface GetMyOrderDetalData : NSObject

@property (strong, nonatomic) NSString *stAddrX;
@property (strong, nonatomic) NSString *stAddrY;
@property (strong, nonatomic) NSString *end;
@property (strong, nonatomic) NSString *endAddrX;
@property (strong, nonatomic) NSString *endAddrY;
@property (strong, nonatomic) NSString *start;
@property (strong, nonatomic) NSString *startId;
@property (strong, nonatomic) NSString *endId;
@property (strong, nonatomic) NSString *driverId;
@property (strong, nonatomic) NSString *carNo;
@property (strong, nonatomic) NSString *memberOrderNo;
@property (strong, nonatomic) NSString *peoples;
@property (strong, nonatomic) NSString *fees;
@property (strong, nonatomic) NSString *memo;
@property (strong, nonatomic) NSString *state;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *lineId;
@property (strong, nonatomic) NSString *barcode;
@property (assign, nonatomic) NSInteger canShowCode;
@property (strong, nonatomic) NSString *changeDate;
@property (strong, nonatomic) NSString *comment;
@property (strong, nonatomic) NSString *goTime;
@property (strong, nonatomic) NSString *qcode;//条形码
@property (strong, nonatomic) NSString *siteNum;
@property (strong, nonatomic) NSString *minuteNum;
@property (strong, nonatomic) NSString *status;//1：已评价 其他：未评价
@property (strong, nonatomic) NSString *changeDateStr;
@property (strong, nonatomic) NSString *starLevel;
//@property (strong, nonatomic) NSString *goTimeStr;
//@property (strong, nonatomic) NSString *arriveTime;
@property (strong, nonatomic) NSString *flightDateStr;
@property (strong, nonatomic) NSArray *siteId1;
@property (strong, nonatomic) NSArray *siteList;
@property (strong, nonatomic) NSArray *object_id;

@end

@interface GetMyOrderDetailRsp : BaseResponse

@property (strong, nonatomic) GetMyOrderDetalData *data;

@end


@interface GetRefundsDateReq : BaseRequest

@property (strong, nonatomic) NSString *lineId;
@property (strong, nonatomic) NSString *memberId;
@property (strong, nonatomic) NSString *start;
@property (strong, nonatomic) NSString *end;
@property (strong, nonatomic) NSString *orderNo;

@end

@interface GetRefundsDateModel : NSObject

@property (strong, nonatomic) NSString *flightId;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *ticketDate;
@property (strong, nonatomic) NSString *ticketPrice;
@property (strong, nonatomic) NSString *carType;

@property (strong, nonatomic) NSDate *buyDate;
@property (assign, nonatomic) BOOL *canChoose;
@property (assign, nonatomic) NSInteger buyCount;
@property (assign, nonatomic) NSInteger refundCount;

@end

@interface GetRefundsDateRsp : BaseResponse

@property (strong, nonatomic) NSArray *data;
@property (assign, nonatomic) NSInteger data1;

@end

@interface CancelOrderReq : BaseRequest

@property (strong, nonatomic) NSString *flightId;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *orderNo;

@end

@interface AddLinkReq : BaseRequest

@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *phone;
@property (strong, nonatomic) NSString *relationId;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *id;

@end

@interface AddLinkModel : NSObject

@property (strong, nonatomic) NSString *emergencyId;
@property (strong, nonatomic) NSString *emergencyPeople;
@property (strong, nonatomic) NSString *emergencyPhone;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *userId;

@end

@interface AddLinkRsp : BaseResponse

@property (strong, nonatomic) NSArray *data;

@end


@interface MessageListModel : NSObject

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *time;
@property (strong, nonatomic) NSString *msgId;
@property (strong, nonatomic) NSString *userId;
@property (assign, nonatomic) NSInteger isRead;//1:已读 2:未读

@property (assign, nonatomic) NSInteger isShowHeight;

@end

@interface FerryDateModel : NSObject

@property (strong, nonatomic) NSString *day;
@property (strong, nonatomic) NSString *week;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) NSString *ticketPrice;
@property (assign, nonatomic) NSInteger buyCount;

@end

@interface MapTrackReq : NSObject

@property (strong, nonatomic) NSString *key;
@property (strong, nonatomic) NSString *service_id;
@property (strong, nonatomic) NSString *object_id;


@end

@interface MapTrackLocation : NSObject

@property (strong, nonatomic) NSString *accuracy;
@property (strong, nonatomic) NSString *altitude;
@property (strong, nonatomic) NSString *bearing;
@property (strong, nonatomic) NSString *speed;
@property (strong, nonatomic) NSString *create_time;
@property (strong, nonatomic) NSString *provider;
@property (strong, nonatomic) NSString *lng;
@property (strong, nonatomic) NSString *lat;

@end

@interface MapTrackObject : NSObject

@property (strong, nonatomic) NSString *create_time;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *update_time;
@property (strong, nonatomic) MapTrackLocation *latest_location;

@end

@interface MapTrackRsp : NSObject

@property (assign, nonatomic) NSInteger count;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSArray *objects;

@end

@interface ServiceLinkData : NSObject

@property (strong, nonatomic) NSString *linkUrl;

@end

@interface ServiceLinkRsp : BaseResponse

@property (strong, nonatomic) ServiceLinkData *data;

@end

@interface RefreshTicketReq : BaseRequest

@property (strong, nonatomic) NSString *orderNo;

@end

@interface RefreshTicketData : NSObject

@property (strong, nonatomic) NSString *orderNo;
@property (strong, nonatomic) NSString *barcode;

@end

@interface RefreshTicketRsp : BaseResponse

@property (strong, nonatomic) RefreshTicketData *data;

@end

@interface ReceiveCouponReq : BaseRequest

@property (strong, nonatomic) NSString *takeCouponType;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *couponId;

@end

@interface ReceiveCouponRsp : BaseResponse


@end

@interface MessageListReq : BaseRequest

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *userId;

@end

@interface MessageListRsp : BaseResponse

@property (strong, nonatomic) NSArray *data;

@end

@interface MessageChangeReq : BaseRequest

@property (strong, nonatomic) NSString *msgId;
@property (strong, nonatomic) NSString *userId;

@end

@interface TicketShareReq : BaseRequest

@property (strong, nonatomic) NSString *pr;
@property (strong, nonatomic) NSString *qr;

@end

@interface TicketShareCallBackReq : BaseRequest

@property (strong, nonatomic) NSString *pr;

@end

@interface CheckCompanyLineReq : BaseRequest

@property (strong, nonatomic) NSString *lineId;
@property (strong, nonatomic) NSString *userId;

@end

@interface CheckAppVersionReq : BaseRequest

@property (strong, nonatomic) NSString *appVersion;
@property (strong, nonatomic) NSString *appName;

@end

@interface CheckAppVersionData : NSObject

@property (strong, nonatomic) NSString *appInstruct;
@property (strong, nonatomic) NSString *appTitle;

@end

@interface CheckAppVersionRsp : BaseResponse

@property (strong, nonatomic) CheckAppVersionData *data;

@end

@interface GetBootPageReq : BaseRequest

@property (strong, nonatomic) NSString *type;//类型 0：趣约车用户版（Android）、1：趣约车用户版（iOS）、2：趣约车司机版（Android）
@property (strong, nonatomic) NSString *sizeType;//尺寸类型 1：默认, 2：iPhone 5/5s/SE（ldpi），3：iPhone 6/6s/7/8（mdpi），4：iPhone 6p/6sp/7p/8p（hdpi），5：iPhone X（xhdpi），6:（xxhdpi）
@property (strong, nonatomic) NSString *version;

@end

@interface GetBootPageData : NSObject

@property (strong, nonatomic) NSArray *pagePicArr;
@property (strong, nonatomic) NSString *version;

@end

@interface GetBootPageRsp : BaseResponse

@property (strong, nonatomic) GetBootPageData *data;

@end

@interface BusRouteModel : NSObject

@property (strong, nonatomic) NSMutableArray *busListArray;
@property (assign, nonatomic) NSInteger duration;
@property (assign, nonatomic) NSInteger walkingDistance;
@property (assign, nonatomic) CGFloat   cost;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *startSite;
@property (assign, nonatomic) NSInteger siteCount;

@end
