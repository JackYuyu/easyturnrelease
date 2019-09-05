//
//  LZCDatePickerView.h
//  CareMonitor
//
//  Created by 李志超 on 2017/6/18.
//  Copyright © 2017年 李志超. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PickerToolBar;

@interface LZCDatePickerStyle : NSObject
/** 显示样式 默认为显示年月日 UIDatePickerModeDate*/
@property (nonatomic) UIDatePickerMode datePickerMode;
/** 显示的默认时间*/
@property (strong, nonatomic) NSDate * _Nullable date;
/** 最小时间*/
@property (strong, nonatomic) NSDate * _Nullable minimumDate;
/** 最大时间*/
@property (strong, nonatomic) NSDate * _Nullable maximumDate;
/** 地区, 默认为China*/
@property (strong, nonatomic) NSLocale   * _Nullable locale;

@end

@interface LZCDatePickerView : UIView

typedef void(^DateDoneHandler)(NSDate * _Nullable selectedDate);
typedef void(^DateSelectedHandler)(NSDate * _Nullable selectedDate);
typedef void(^BtnAction)();

@property (strong, nonatomic, readonly) PickerToolBar * _Nullable toolBar;

- (instancetype _Nullable )initWithToolBarText:(NSString *_Nullable)toolBarText maxDateStr:(nullable NSString *)dateStr withStyle: (LZCDatePickerStyle *_Nullable)style fromStyle:(DatePickerFromStyle)fromStyle withValueDidChangedHandler:(DateSelectedHandler _Nullable )valueDidChangedHandler cancelAction:(BtnAction _Nullable )cancelAction doneAction: (DateDoneHandler _Nullable )doneAction;

@end
