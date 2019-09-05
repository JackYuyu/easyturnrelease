//
//  ETDynamicListSegment.h
//  EasyTurn
//
//  Created by 刘盖 on 2019/8/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETDynamicListSegItem : UIView
@property (nonatomic,assign)  BOOL isSelected;
+ (instancetype)dynamicListSegItem:(NSString *)title isNeedImage:(BOOL)isNeedImage click:(void (^)(NSInteger itemIndex))clickBlock;
- (void)resetSelectState:(BOOL)isSelect;
- (void)resetBtnTitle:(NSString *)title;
@end

@interface ETDynamicListSegment : UIView
+ (instancetype)dynamicListSegmentWithClick:(void (^)(NSInteger segIndex, NSString *cityId))clickBlock;

@end

NS_ASSUME_NONNULL_END
