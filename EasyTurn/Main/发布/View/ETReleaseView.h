//
//  ETReleaseView.h
//  EasyTurn
//
//  Created by 王翔 on 2019/7/25.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AccountBindingDelegate <NSObject>
- (void)putWebVC:(UIButton*)sender;
- (void)jumpWebVC:(UIButton*)sender;
- (void)jumpWebVC1:(UIButton*)sender;
- (void)jumpWebVC2:(UIButton*)sender;
@end
@interface ETReleaseView : UIView
@property (nonatomic, weak) id<AccountBindingDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
