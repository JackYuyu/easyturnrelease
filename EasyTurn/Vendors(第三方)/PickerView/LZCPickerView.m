//
//  LZCPickerView.m
//  CareMonitor
//
//  Created by 李志超 on 2017/6/15.
//  Copyright © 2017年 李志超. All rights reserved.
//

#import "LZCPickerView.h"

void ifDebug(dispatch_block_t blcok) {
#if DEBUG
    if (blcok) {
        blcok();
    }
#endif
}

@interface LZCPickerView ()

@property (strong, nonatomic) UIView *pickerView;

@end

static const CGFloat kPickerViewHeight = 260.0f;

@implementation LZCPickerView

#pragma mark - public use methods
+ (LZCPickerView *)showSingleColPickerWithToolBarText:(NSString *)toolBarText withData :(NSArray<NSString *> *)data withDefaultIndex:(NSInteger)defaultIndex withCancelHandler:(CancelHandler)cancelHandler withDoneHandler:(SingleDoneHandler)doneHandler {
    LZCPickerView *usefulPickerView = [LZCPickerView new];
    
    __weak LZCPickerView *weakUsefulPickerView = usefulPickerView;
    /// 解决循环引用的问题
    LZCSinglePickerView *single = [[LZCSinglePickerView alloc] initWithToolBarText:toolBarText withDefaultIndex:defaultIndex withData:data withValueDidChangedHandler:nil cancelAction:^{
        
        if (cancelHandler) {
            cancelHandler();
        }
        __strong LZCPickerView *strongUsefulPickerView = weakUsefulPickerView;
        if (strongUsefulPickerView) {
            /// 移除
            [strongUsefulPickerView hidePickerView];
            
        }
        
    } doneAction:^(NSInteger selectedIndex, NSString *selectedValue){
        
        if (doneHandler) {
            doneHandler(selectedIndex, selectedValue);
        }
        __strong LZCPickerView *strongUsefulPickerView = weakUsefulPickerView;
        if (strongUsefulPickerView) {
            /// 移除
            [strongUsefulPickerView hidePickerView];
        }
    }];
    /// 设置pickerView --- 在重写的set方法里面会将pickerView添加到usefulPickerView上
    usefulPickerView.pickerView = single;
    /// 弹出usefulPickerView
    [usefulPickerView showPickerView];
    /// 返回usefulPickerView --- 便于使用者自定义一些toolBar的属性
    return usefulPickerView;
}

+ (LZCPickerView *)showDatePickerWithToolBarText:(NSString *)toolBarText maxDateStr:(nullable NSString *)dateStr withStyle:(LZCDatePickerStyle *)style fromStyle:(DatePickerFromStyle)fromStyle withCancelHandler:(CancelHandler)cancelHandler withDoneHandler:(DateDoneHandler)doneHandler{
    LZCPickerView *usefulPickerView = [LZCPickerView new];
    __weak LZCPickerView *weakUsefulPickerView = usefulPickerView;
    
    LZCDatePickerView *datePicker = [[LZCDatePickerView alloc] initWithToolBarText:toolBarText maxDateStr:dateStr withStyle:style fromStyle:(DatePickerFromStyle)fromStyle withValueDidChangedHandler:nil cancelAction:^{
        if (cancelHandler) {
            cancelHandler();
        }
        __strong LZCPickerView *strongUsefulPickerView = weakUsefulPickerView;
        if (strongUsefulPickerView) {
            [strongUsefulPickerView hidePickerView];
            
        }
    } doneAction:^(NSDate *selectedDate){
        if (doneHandler) {
            doneHandler(selectedDate);
        }
        __strong LZCPickerView *strongUsefulPickerView = weakUsefulPickerView;
        if (strongUsefulPickerView) {
            [strongUsefulPickerView hidePickerView];
            
        }
    }];
    
    usefulPickerView.pickerView = datePicker;
    [usefulPickerView showPickerView];
    return usefulPickerView;
}

#pragma mark - life cycle
- (instancetype)init {
    if (self = [super init]) {
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapedSelf:)];
        tapGes.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGes];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)dealloc {
    NSLog(@"ZJUsefulPickerView ===== dealloc");
}

- (void)tapedSelf:(UITapGestureRecognizer *)tap {
    CGPoint location = [tap locationInView:self];
    
    // 点击空白背景移除self
    if (location.y <= [UIScreen mainScreen].bounds.size.height - kPickerViewHeight) {
        [self hidePickerView];
    }
}

#pragma mark - helper
- (void)showPickerView {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window) {
        /// 移除键盘第一响应者, 否则键盘始终会在界面的最上层
        [window endEditing:YES];
        /// 添加view
        [window addSubview:self];
        /// 设置pickerView的frame为屏幕底部外面 --- 动画初始位置
        self.pickerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, kPickerViewHeight);
        
        self.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.1];
        
        [UIView animateWithDuration:0.25f animations:^{
            
            /// 设置pickerView的动画结束位置, 显示在屏幕底部
            self.pickerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - kPickerViewHeight, [UIScreen mainScreen].bounds.size.width, kPickerViewHeight);;
        } completion:nil];
    }
}

- (void)hidePickerView {
    [UIView animateWithDuration:0.25f animations:^{
        self.backgroundColor = [UIColor clearColor];
        self.pickerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, kPickerViewHeight);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.superview) {
        self.frame = self.superview.bounds;
        self.pickerView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - kPickerViewHeight, [UIScreen mainScreen].bounds.size.width, kPickerViewHeight);
    }
}

#pragma mark - setter getter
- (void)setPickerView:(UIView *)pickerView {
    _pickerView = pickerView;
    [self addSubview:_pickerView];
}

- (PickerToolBar *)toolBar {
    if ([self.pickerView isKindOfClass:[LZCSinglePickerView class]]) {
        return ((LZCSinglePickerView *)self.pickerView).toolBar;
    }
    else {
        return [PickerToolBar new];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
