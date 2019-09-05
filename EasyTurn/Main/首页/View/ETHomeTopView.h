//
//  ETHomeTopView.h
//  EasyTurn
//
//  Created by 程立 on 2019/7/19.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface ETHomeTopView : UIView
@property (nonatomic, strong) void (^block)(void);
@property (nonatomic, strong) void (^block1)(void);

@property (nonatomic, strong) UIButton *btnLocation;
@property (nonatomic, strong) OTButton *btnLocationDown;

@end

NS_ASSUME_NONNULL_END
