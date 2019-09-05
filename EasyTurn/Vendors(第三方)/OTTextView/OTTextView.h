//
//  OTTextView.h
//  OTTextView
//
//  Created by OUT MAN on 16/8/3.
//  Copyright © 2016年 OUT MAN. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OTTextViewDelegate;
@interface OTTextView : UITextView

/**
 * 代理: 设置代理, 实现对应方法, 可以实时获取 OTTextView 的高度
 */
@property (nonatomic, weak) id<OTTextViewDelegate> ot_delegate;

/**
 * 占位文字
 */
@property (nonatomic, strong) NSString *placeholder;

/**
 * 占位文字颜色
 */
@property (nonatomic, strong) UIColor *placeholderColor;

/**
 * 占位文字大小
 */
@property (nonatomic, strong) UIFont *placeholderFont;

/**
 * 占位文字居上距离
 */
@property (nonatomic, assign) CGFloat placeholderTopSpace;

/**
 * 占位文字居左距离
 */
@property (nonatomic, assign) CGFloat placeholderLeftSpace;

@end

@protocol OTTextViewDelegate <NSObject>

@optional
/**
 实时获取 OTTextView 高度

 @param vText OTTextView 对象
 @param currentHeight 当前高度
 */
- (void)textView:(OTTextView *)vText currentHeight:(CGFloat)currentHeight;

@end
