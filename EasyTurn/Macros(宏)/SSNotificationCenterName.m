
//
//  DCNotificationCenterName.m
//  CDDStoreDemo
//
//  Created by dashen on 2017/12/6.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "SSNotificationCenterName.h"

@implementation SSNotificationCenterName


/** 跳转登录页面控制器通知 */
NSString *const LOGINSELECTCENTERINDEX = @"LOGINSELECTCENTERINDEX";
/** 腾讯IM登录通知 */
NSString *const LoginSuccessTIMNotification = @"loginSuccessTIMNotification";
/** 退出登录成功选择控制器通知 */
NSString *const LOGINOFFSELECTCENTERINDEX = @"LOGINOFFSELECTCENTERINDEX";

/** 跳转订单详情页面控制器通知 */
NSString *const ORDER_DETAISNTERINDEX = @"ORDER_DETAISNTERINDEX";

/** 刷新购物车列表页面 */
NSString *const Refresh_ShopCart = @"Refresh_ShopCart";

/** 提交订单后刷新购物车列表(删除提交订单的购物车商品) */
NSString *const PushOrder_Refresh_ShopCart = @"PushOrder_Refresh_ShopCart";

/** 修改昵称或者邮箱后,刷新上一个界面 */
NSString *const EditorNickNameWithEmailSucceed = @"EditorNickNameWithEmailSucceed";

/** 修改头像后,刷新我的界面 */
NSString *const UpdateHeadPortraitWithEmailSucceed = @"UpdateHeadPortraitWithEmailSucceed";

/** 添加或删除地址成功后,刷新上一个界面 */
NSString *const EditorAddressSucceed = @"EditorAddressSucceed";

/** 删除订单后,刷新上一个界面 */
NSString *const CancleOrderSucceed = @"CancleOrderSucceed";

/** 删除服务单后,刷新上一个界面 */
NSString *const CancleServiceTicketSucceed = @"CancleServiceTicketSucceed";

/** 远程推送收到通知后,更新我的页面显示的消息总个数 */
NSString *const push_Update_MessageCount = @"push_Update_MessageCount";

/** 支付成功跳转支付成功页面 */
NSString *const Push_PaySucceed = @"Push_PaySucceed";

/** 支付成功返回支付结果 */
NSString *const Request_PayResult = @"Request_PayResult";

/** 添加购物车或者立即购买通知 */
NSString *const SELECTCARTORBUY = @"SELECTCARTORBUY";

/** 刷新我的页面 */
NSString *const Refresh_Mine = @"Refresh_Mine";

/** 刷新任务页面 */
NSString *const Refresh_Task = @"Refresh_Task";

/** 滚动到商品详情界面通知 */
NSString *const SCROLLTODETAILSPAGE = @"SCROLLTODETAILSPAGE";

/** 滚动到商品评论界面通知 */
NSString *const SCROLLTOCOMMENTSPAGE = @"SCROLLTOCOMMENTSPAGE";

/** 展现顶部自定义工具条View通知 */
NSString *const SHOWTOPTOOLVIEW = @"SHOWTOPTOOLVIEW";

/** 隐藏顶部自定义工具条View通知 */
NSString *const HIDETOPTOOLVIEW = @"HIDETOPTOOLVIEW";

/** 商品属性选择返回通知 */
NSString *const SHOPITEMSELECTBACK = @"SHOPITEMSELECTBACK";

/** 分享弹出通知 */
NSString *const SHAREALTERVIEW= @"SHAREALTERVIEW";

/** 消息中心列表-消息个数改变通知 */
NSString *const DCMESSAGECOUNTCHANGE = @"DCMESSAGECOUNTCHANGE";

/** tabbar消息个数-消息个数改变通知 */
NSString *const TabbarMessagesCountChange = @"TabbarMessagesCountChange";

/** tabbar购物车个数-消息个数改变通知 */
NSString *const TabbarGoodsCarCountChange = @"TabbarGoodsCarCountChange";

/** 账号过期 */
NSString *const LoginBeOverdue = @"LoginBeOverdue";

/** 直播间关注刷新页面 */
NSString *const SSfollowLiveRoomRefresh = @"SSfollowLiveRoomRefresh";
@end
