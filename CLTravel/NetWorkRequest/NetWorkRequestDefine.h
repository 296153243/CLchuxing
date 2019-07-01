//
//  NetWorkRequestDefine.h
//  QuDriver
//
//  Created by 朱青 on 2017/9/21.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import <Foundation/Foundation.h>

//接口名
typedef NS_ENUM(NSInteger,XQApiName) {
    getCode,          //获取验证码
    checkCode,        //验证码登录
    bindWeChat,       //微信登录
    checkWeChatCode,       //微信绑定手机号
    autoLand,       //自动登录
    getCity,        //获取城市
    openCityData,   //首页
    siteMatch,//获取附近站点
    getFighting,//匹配线路获取班次
    flightMatch,//匹配线路获取班次1.1.0.4改动
    getFlightDetails,//获取路线详情
    recharge,//充值
    updateBalance,//更新用户余额
    getBalance,//获取用户余额
    ticketDate,//可购票日期
    addOrder,//购票下单
    addFlight,//申请增加班次
    payMoney,//购票支付
    getOrderDetail,//获取订单详情
    initiatingRoute,//发起线路
    shareTheme,//线路分享
    getMyOrderInfo,//获取明细
    isTicket,//是否有票
    isNewMsg,//是否有新消息
    getMyOrderDetail,//行程详情
    getTicketList,//购票列表
    getRefundsDate,//获取可退票日期
    cancelOrder,//退票
    getComment,//获取评论标语
    addComment,//行程评论
    addEmergencyPeople,//添加联系人
    setCommuteTime,//设置上下班
    uploadImage,//修改个人信息
    getUserCouponList,//获取优惠券列表
    getUserCoupon,// 优惠券详情
    getRemark,//获取发起路线目的
    getLink,//获取客服链接
    getMyOrderHistory,//获取历史行程
    isCheck,//刷新车票
    receiveCoupon,//领取优惠券
    iosMsgHistory,//消息历史
    iosChangeMsgStatus,//改变消息状态
    getShortLink,//用户分享二维码获取短链接
    callBackSuccess,//分享乘车码成功回调
    getPersonalInformation,//获取用户信息
    checkSpecialLine,//用户是否可以查看专线线路详情
    checkVersion,//检查更新
    getBootPage,//获取引导图
};
NSString *XQApiNameEnum(XQApiName name);

@interface NetWorkRequestDefine : NSObject

@end
