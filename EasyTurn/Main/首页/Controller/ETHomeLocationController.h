//
//  ETHomeLocationController.h
//  EasyTurn
//
//  Created by 程立 on 2019/7/27.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ACViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, JMColumnMenuType1) {
    JMColumnMenuTypeTencent1, //腾讯新闻
    JMColumnMenuTypeTouTiao1, //今日头条
};
@interface ETHomeLocationController : ACViewController
/** 类型 */
@property (nonatomic, assign) JMColumnMenuType1 type;
/** 导航栏的背景颜色 */
@property (nonatomic, strong) UIColor *navBackgroundColor;
/** 导航栏文字颜色 */
@property (nonatomic, strong) UIColor *navTitleColor;
/** 导航栏文字 */
@property (nonatomic, copy) NSString *navTitleStr;
/** 导航栏右侧关闭按钮 */
@property (nonatomic, strong) UIImage *navRightIV;
@end

NS_ASSUME_NONNULL_END
