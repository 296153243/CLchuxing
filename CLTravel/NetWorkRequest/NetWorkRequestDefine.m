//
//  NetWorkRequestDefine.m
//  QuDriver
//
//  Created by 朱青 on 2017/9/21.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "NetWorkRequestDefine.h"

NSString *XQApiNameEnum(XQApiName name)
{
    switch (name) {
        case getCode:return @"code/getCode";
            break;
        case checkCode:return @"code/checkCode";
            break;
        case bindWeChat:return @"code/bindWeChat";
            break;
        case checkWeChatCode:return @"code/checkWeChatCode";
            break;
        case autoLand:return @"code/autoLand";
            break;
        case getCity:return @"city/getCity";
            break;
        case openCityData:return @"city/openCityData";
            break;
        case siteMatch:return @"site/siteMatch";
            break;
        case getFighting:return @"site/getFighting";
            break;
        case flightMatch:return @"line/flightMatch";
            break;
        case getFlightDetails:return @"site/getFlightDetails";
            break;
        case recharge:return @"orderInfo/recharge";
            break;
        case updateBalance:return @"member/updateBalance";
            break;
        case getBalance:return @"member/getBalance";
            break;
        case ticketDate:return @"orderInfo/ticketDate";
            break;
        case addOrder:return @"orderInfo/addOrder";
            break;
     
        case addFlight:return @"apply/addFlight";
            break;
        case payMoney:return @"orderInfo/payMoney";
            break;
        case getOrderDetail:return @"orderInfo/getOrderDetail";
            break;
        case initiatingRoute:return @"site/initiatingRoute";
            break;
        case shareTheme:return @"site/theme";
            break;
        case getMyOrderInfo:return @"member/getTransactionsPage";
            break;
        case isTicket:return @"msg/isTicket";
            break;
        case isNewMsg:return @"msg/isNewMsg";
            break;

        case getMyOrderDetail:return @"member/getMyOrderDetail";

            break;
        case getTicketList:return @"orderInfo/getTicketList";

            break;
        case getRefundsDate:return @"orderInfo/getRefundsDate";
            
            break;
            
        case cancelOrder:return @"orderInfo/cancelOrder";
            
            break;
        case getComment:return @"comment/getComment";
            
            break;
        case addComment:return @"comment/addComment";
            
            break;
            
        case addEmergencyPeople:return @"people/addEmergencyPeople";
            break;
            
        case setCommuteTime:return @"code/setCommuteTime";
            break;
            
        case uploadImage:return @"personal/uploadImage";
            break;
            
        case getUserCouponList:return @"coupon/getUserCouponList";
            break;
            
        case getUserCoupon:return @"coupon/getUserCoupon";
            break;
        case getRemark:return @"site/getRemark";
            break;
        case getLink:return @"service/getLink";
            break;
        case getMyOrderHistory:return @"member/getMyOrderHistory";
            break;
        case isCheck:return @"trail/isCheck";
            break;
        case receiveCoupon:return @"coupon/receiveCoupon";
            break;
        case iosMsgHistory:return @"msg/iosMsgHistory";
            break;
        case iosChangeMsgStatus:return @"msg/iosChangeMsgStatus";
            break;
        case getShortLink:return @"carCode/getShortLink";
            break;
        case callBackSuccess:return @"carCode/callBackSuccess";
            break;
        case getPersonalInformation:return @"code/getPersonalInformation";
            break;
        case checkSpecialLine:return @"line/checkSpecialLine";
            break;
        case checkVersion:return @"app/checkVersion";
            break;
        case getBootPage:return @"bootPage/getBootPage";
            break;
        default:return @"";
            break;
    }
}

@implementation NetWorkRequestDefine

@end
