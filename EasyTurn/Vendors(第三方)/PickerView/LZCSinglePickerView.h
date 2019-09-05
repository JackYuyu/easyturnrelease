//
//  LZCSinglePickerView.h
//  CareMonitor
//
//  Created by 李志超 on 2017/6/15.
//  Copyright © 2017年 李志超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickerToolBar;

@interface LZCSinglePickerView : UIView

typedef void(^SingleDoneHandler)(NSInteger selectedIndex, NSString *selectedValue);
typedef void(^SingleSelectedHandler)(NSString *selectedValue);
typedef void(^BtnAction)();

@property (strong, nonatomic, readonly) PickerToolBar *toolBar;

- (instancetype)initWithToolBarText:(NSString *)toolBarText withDefaultIndex: (NSInteger)defaultIndex withData:(NSArray<NSString *> *)data withValueDidChangedHandler:(SingleSelectedHandler)valueDidChangedHandler cancelAction:(BtnAction)cancelAction doneAction: (SingleDoneHandler)doneAction;

@end
