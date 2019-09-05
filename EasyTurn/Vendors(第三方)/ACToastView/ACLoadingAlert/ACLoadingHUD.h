//
//  ACLoadingHUD.h
//  FFLoadingViewExample
//
//  Created by zhangMo on 2017/11/7.
//  Copyright © 2017年 organization. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^LoadingCompleteBlock) (void);

@interface ACLoadingHUD : UIView

@property (nonatomic, assign) CGFloat lineWidth;//线条宽度
@property (nonatomic, strong) UIColor *loadingColor;//loading线条颜色
@property (nonatomic, strong) UIColor *successColor;//success线条颜色
@property (nonatomic, strong) UIColor *failureColor;//failure线条颜色
@property (nonatomic, assign, readonly) NSTimeInterval animationTime;// 仅仅是打钩打叉的动画时间

/**
 * 开始Loading动画
 */
- (void)startLoading;

/**
 * 结束Loading动画，视图会被移除
 */
- (void)endLoading;

/**
 * 以成功结束动画
 *
 * @param block 回调
 */
- (void)finishWithSuccess:(LoadingCompleteBlock)block;

/**
 * 以失败结束动画
 *
 * @param block 回调
 */
- (void)finishWithFailure:(LoadingCompleteBlock)block;

@end
