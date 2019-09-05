//
//  OTButton.h
//  AutoTraderCloud
//
//  Created by OUT MAN on 2017/9/8.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, OTButtonImageViewAndLabelAlignmentStyle) {
    /** 左图右文(默认) */
    OTButtonImageViewAndLabelAlignmentStyleImageViewLeftAndLabelRight = 0,
    /** 左文右图 */
    OTButtonImageViewAndLabelAlignmentStyleImageViewRightAndLabelLeft,
    /** 上图下文 */
    OTButtonImageViewAndLabelAlignmentStyleImageViewTopAndLabelBottom,
    /** 上文下图 */
    OTButtonImageViewAndLabelAlignmentStyleImageViewBottomAndLabelTop
};
@interface OTButton : UIButton

/**
 * ImageView 和 Label 的样式
 */
@property (nonatomic, assign) OTButtonImageViewAndLabelAlignmentStyle ot_styleWithImageViewAndLabelAlignment;

/**
 * ImageView 和 Label 之间的间隔
 */
@property (nonatomic, assign) CGFloat ot_marginWithImageViewAndLabel;

@end
