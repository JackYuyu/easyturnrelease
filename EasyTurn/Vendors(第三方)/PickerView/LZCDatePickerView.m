//
//  LZCDatePickerView.m
//  CareMonitor
//
//  Created by 李志超 on 2017/6/18.
//  Copyright © 2017年 李志超. All rights reserved.
//

#import "LZCDatePickerView.h"
#import "PickerToolBar.h"

@implementation LZCDatePickerStyle

- (instancetype)init {
    if (self = [super init]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _date = [NSDate date];
    _datePickerMode = UIDatePickerModeDate;
    
    NSString *localeLanguageCode = [[NSLocale currentLocale] objectForKey:NSLocaleLanguageCode];
    if ([localeLanguageCode isEqualToString:@"en"]) {
        _locale = [NSLocale localeWithLocaleIdentifier:@"en"];
    }else if ([localeLanguageCode isEqualToString:@"zh-tw"]){
        _locale = [NSLocale localeWithLocaleIdentifier:@"zh-tw"];
    }else{
        _locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
    }
}

@end

@interface LZCDatePickerView (){
    NSDate *_selectedDate;
}

@property (strong, nonatomic) PickerToolBar *toolBar;
@property (strong, nonatomic) UIDatePicker *pickerView;
@property (strong, nonatomic) LZCDatePickerStyle *style;
@property (copy, nonatomic) DateSelectedHandler valueDidChangeHandler;
@property (assign, nonatomic) DatePickerFromStyle fromStyle;//added by zhichao.li on bug444

@end

@implementation LZCDatePickerView

#pragma mark - life cycle
// 限制最大时间跟最小时间
- (instancetype)initWithToolBarText:(NSString *)toolBarText maxDateStr:(nullable NSString *)dateStr withStyle: (LZCDatePickerStyle *)style fromStyle:(DatePickerFromStyle)fromStyle withValueDidChangedHandler:(DateSelectedHandler)valueDidChangedHandler cancelAction:(BtnAction)cancelAction doneAction: (DateDoneHandler)doneAction {
    
    if (self = [super init]) {

        _style = style;
        _fromStyle = fromStyle;//added by zhichao.li on bug444
        
        // 默认为当前时间
        //        _selectedDate = [NSDate date];
#pragma mark - 设置默认选中值  added by zhichao.li on bug444
        if (_fromStyle == FromFemaleHouseStyle) {
            NSString *defaultDateStr = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@_%@",@"",@"date"]];
            if (defaultDateStr) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *defaultDate = [formatter dateFromString:defaultDateStr];
                _selectedDate = defaultDate;
            }else{
                _selectedDate = [NSDate date];
            }
        }else{
            _selectedDate = [NSDate date];
        }

        

        // 1.创建一个时间格式化对象
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        
        // 2.格式化对象的样式/z大小写都行/格式必须严格和字符串时间一样
        formatter.dateFormat = @"yyyy-MM-dd";
        
        if (dateStr) {
            // 3.利用时间格式化对象让字符串转换成时间 (自动转换0时区/东加西减)
            NSDate *date = [formatter dateFromString:dateStr];
            _style.maximumDate = date;
        }
        _valueDidChangeHandler = valueDidChangedHandler;
        __weak typeof(self) weakSelf = self;
        _toolBar = [[PickerToolBar alloc] initWithToolbarText:toolBarText cancelAction:cancelAction doneAction:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if (strongSelf) {
                if (doneAction) {
                    NSLog(@"%@",_selectedDate);
                    doneAction(strongSelf->_selectedDate);
                }
            }
        }];
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:_toolBar];
        [self addSubview:self.pickerView];
        /// 选中日期改变
        [self setupSelectedValueDidChanged];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat kToolBarHeight = 44.0f;

    NSLayoutConstraint *toolBarLeft = [NSLayoutConstraint constraintWithItem:self.toolBar attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0f];
    NSLayoutConstraint *toolBarRight = [NSLayoutConstraint constraintWithItem:self.toolBar attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0f];
    
    NSLayoutConstraint *toolBarHeight = [NSLayoutConstraint constraintWithItem:self.toolBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:kToolBarHeight];
    NSLayoutConstraint *toolBarTop = [NSLayoutConstraint constraintWithItem:self.toolBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0f];
    self.toolBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:@[toolBarLeft, toolBarRight, toolBarHeight, toolBarTop]];
    
    NSLayoutConstraint *pickerViewLeft = [NSLayoutConstraint constraintWithItem:self.pickerView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0.0f];
    NSLayoutConstraint *pickerViewRight = [NSLayoutConstraint constraintWithItem:self.pickerView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0.0f];
    
    NSLayoutConstraint *pickerViewHeight = [NSLayoutConstraint constraintWithItem:self.pickerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:self.bounds.size.height - kToolBarHeight];
    NSLayoutConstraint *pickerViewBottom = [NSLayoutConstraint constraintWithItem:self.pickerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0f];
    self.pickerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraints:@[pickerViewLeft, pickerViewRight, pickerViewHeight, pickerViewBottom]];
}

- (void)dealloc {
    //    JSDLog(@"ZJDatePickerView ===== dealloc");
}

- (void)setupSelectedValueDidChanged {
    if (_valueDidChangeHandler) {
        _valueDidChangeHandler(_selectedDate);
    }
}

- (void)datePickerDidSelected:(UIDatePicker *)datePicker {
    _selectedDate = datePicker.date;
    [self setupSelectedValueDidChanged];
    
}

- (UIDatePicker *)pickerView {
    if (!_pickerView) {
        UIDatePicker *picker = [UIDatePicker new];
        [picker addTarget:self action:@selector(datePickerDidSelected:) forControlEvents:UIControlEventValueChanged];
        picker.datePickerMode = UIDatePickerModeDate;
        picker.locale = [NSLocale localeWithLocaleIdentifier:@"zh_CN"];
        if (_style) {
//            picker.date = _style.date;
#pragma mark - 设置默认选中值  added by zhichao.li on bug444
            if (_fromStyle == FromFemaleHouseStyle) {
                NSString *defaultDateStr = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"%@_%@",@"",@"date"]];
                if (defaultDateStr) {
                    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
                    [formatter setDateFormat:@"yyyy-MM-dd"];
                    NSDate *defaultDate = [formatter dateFromString:defaultDateStr];
                    picker.date = defaultDate;
                }else{
                    picker.date = _style.date;
                }
            }else{
                picker.date = _style.date;
            }

            picker.minimumDate = _style.minimumDate;
            picker.maximumDate = _style.maximumDate;
            picker.datePickerMode = _style.datePickerMode;
            picker.locale = _style.locale;
            
//            _selectedDate = _style.date;

        }
        
        _pickerView = picker;
    }
    return _pickerView;
}

@end

