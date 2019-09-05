//
//  ETWxPhoneViewController.h
//  EasyTurn
//
//  Created by 程立 on 2019/8/13.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETWxPhoneViewController : UIViewController
@property(nonatomic,strong)void (^block)(void);
@end

NS_ASSUME_NONNULL_END
