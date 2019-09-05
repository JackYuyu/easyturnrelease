//
//  ETEnterpriseServiceListSegment.h
//  EasyTurn
//
//  Created by 刘盖 on 2019/8/8.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETEnterpriseServiceListSegment : UIView

+ (instancetype)enterpriseServiceListSegment:(void (^)(NSInteger segIndex, NSString *itemId))clickBlock;

@end

NS_ASSUME_NONNULL_END
