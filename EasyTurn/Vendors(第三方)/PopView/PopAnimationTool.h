//
//  PopAnimationTool.h
//  PopView
//
//  Created by 李志超 on 2019/8/3.
//  Copyright © 2019年 李林. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PopView.h"

@interface PopAnimationTool : NSObject
+ (CABasicAnimation *)getShowPopAnimationWithType:(PopViewDirection)popDirecton contentView:(UIView *)contentView belowView:(UIView *)belowView;
+ (CABasicAnimation *)getHidenPopAnimationWithType:(PopViewDirection)popDirecton contentView:(UIView *)contentView belowView:(UIView *)belowView;
@end
