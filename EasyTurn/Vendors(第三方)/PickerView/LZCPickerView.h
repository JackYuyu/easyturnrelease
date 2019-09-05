//
//  LZCPickerView.h
//  CareMonitor
//
//  Created by 李志超 on 2017/6/15.
//  Copyright © 2017年 李志超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PickerToolBar.h"
#import "LZCSinglePickerView.h"
#import "LZCDatePickerView.h"

@interface LZCPickerView : UIView

typedef void(^CancelHandler)();
typedef void(^SingleDoneHandler)(NSInteger selectedIndex, NSString *_Nonnull selectedValue);
typedef void(^DateDoneHandler)(NSDate * _Nullable selectedDate);

@property (strong, nonatomic, readonly)PickerToolBar * _Nullable toolBar;

+ (LZCPickerView *_Nonnull)showSingleColPickerWithToolBarText:(NSString *_Nullable)toolBarText withData:(NSArray<NSString *> *_Nonnull)data withDefaultIndex:(NSInteger)defaultIndex withCancelHandler:(CancelHandler _Nonnull )cancelHandler withDoneHandler:(SingleDoneHandler _Nonnull )doneHandler;

+ (LZCPickerView *_Nullable)showDatePickerWithToolBarText:(NSString *_Nonnull)toolBarText  maxDateStr:(nullable NSString *)dateStr withStyle:(LZCDatePickerStyle *_Nullable)style fromStyle:(DatePickerFromStyle)fromStyle withCancelHandler:(CancelHandler _Nonnull )cancelHandler withDoneHandler:(DateDoneHandler _Nullable )doneHandler;

@end
