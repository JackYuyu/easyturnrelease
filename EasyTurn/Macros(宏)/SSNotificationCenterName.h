//
//  DCNotificationCenterName.h
//  CDDStoreDemo
//
//  Created by dashen on 2017/12/6.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSNotificationCenterName : NSObject

#pragma mark - 项目中所有通知

/** 登录成功选择控制器通知 */
UIKIT_EXTERN NSString *const LOGINSELECTCENTERINDEX;
/** 腾讯IM登录通知 */
UIKIT_EXTERN NSString *const LoginSuccessTIMNotification;
/** 退出登录成功选择控制器通知 */
UIKIT_EXTERN NSString *const LOGINOFFSELECTCENTERINDEX;

/** 跳转订单详情页面控制器通知 */
UIKIT_EXTERN NSString *const ORDER_DETAISNTERINDEX;

/** 刷新购物车列表页面 */
UIKIT_EXTERN NSString *const Refresh_ShopCart;

/** 提交订单后刷新购物车列表(删除提交订单的购物车商品) */
UIKIT_EXTERN NSString *const PushOrder_Refresh_ShopCart;

/** 修改昵称或者邮箱后,刷新上一个界面 */
UIKIT_EXTERN NSString *const EditorNickNameWithEmailSucceed;

/** 修改头像后,刷新我的界面 */
UIKIT_EXTERN NSString *const UpdateHeadPortraitWithEmailSucceed;

/** 添加或删除地址成功后,刷新上一个界面 */
UIKIT_EXTERN NSString *const EditorAddressSucceed;

/** 删除订单后,刷新上一个界面 */
UIKIT_EXTERN NSString *const CancleOrderSucceed;

/** 删除服务单后,刷新上一个界面 */
UIKIT_EXTERN NSString *const CancleServiceTicketSucceed;

/** 远程推送收到通知后,更新我的页面显示的消息总个数 */
UIKIT_EXTERN NSString *const push_Update_MessageCount;

/** 支付成功跳转支付成功页面 */
UIKIT_EXTERN NSString *const Push_PaySucceed;

/** 支付成功返回支付结果 */
UIKIT_EXTERN NSString *const Request_PayResult;

/** 添加购物车或者立即购买通知 */
UIKIT_EXTERN NSString *const SELECTCARTORBUY;

/** 刷新我的页面 */
UIKIT_EXTERN NSString *const Refresh_Mine;

/** 刷新任务页面 */
UIKIT_EXTERN NSString *const Refresh_Task;

/** 滚动到商品详情界面通知 */
UIKIT_EXTERN NSString *const SCROLLTODETAILSPAGE;

/** 滚动到商品评论界面通知 */
UIKIT_EXTERN NSString *const SCROLLTOCOMMENTSPAGE;

/** 展现顶部自定义工具条View通知 */
UIKIT_EXTERN NSString *const SHOWTOPTOOLVIEW;

/** 隐藏顶部自定义工具条View通知 */
UIKIT_EXTERN NSString *const HIDETOPTOOLVIEW;

/** 商品属性选择返回通知 */
UIKIT_EXTERN NSString *const SHOPITEMSELECTBACK;

/** 分享弹出通知 */
UIKIT_EXTERN NSString *const SHAREALTERVIEW;

/** 消息个数改变通知 */
UIKIT_EXTERN NSString *const DCMESSAGECOUNTCHANGE;

/** tabbar消息-消息个数改变通知 */
UIKIT_EXTERN NSString *const TabbarMessagesCountChange;

/** tabbar购物车个数-消息个数改变通知 */
UIKIT_EXTERN NSString *const TabbarGoodsCarCountChange;

/** 账号过期 */
UIKIT_EXTERN NSString *const LoginBeOverdue;

/** 直播间关注刷新页面 */
UIKIT_EXTERN NSString *const SSfollowLiveRoomRefresh;
@end

