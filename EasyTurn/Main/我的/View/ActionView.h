//
//  ActionView.h
//  XingHou
//
//  Created by 陈林 on 16/6/24.
//  Copyright © 2016年 CYX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionView : UIView

//- (ActionView *)initWithCancelTitle:(NSString *)cancelTitle andOtherTitles:(NSArray *)otherTitles;

@property(copy, nonatomic)void (^block)(UIButton *);

@end
