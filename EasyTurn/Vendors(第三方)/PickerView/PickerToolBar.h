//
//  PickerToolBar.h
//  CareMonitor
//
//  Created by 李志超 on 2017/6/15.
//  Copyright © 2017年 李志超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PickerToolBar : UIView

typedef void(^BtnAction)();
@property (strong, readonly, nonatomic) UIButton *doneBtn;
@property (strong, readonly, nonatomic) UIButton *cancelBtn;
@property (strong, readonly, nonatomic) UILabel *label;

- (instancetype)initWithToolbarText:(NSString *)toolBarText cancelAction:(BtnAction)cancelAction doneAction:(BtnAction)doneAction;

@end
