//
//  PickerToolBar.m
//  CareMonitor
//
//  Created by 李志超 on 2017/6/15.
//  Copyright © 2017年 李志超. All rights reserved.
//

#import "PickerToolBar.h"

@interface PickerToolBar ()

@property (strong, nonatomic) UIButton *doneBtn;
@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UIView *lineView;

@property (copy, nonatomic) BtnAction doneAction;
@property (copy, nonatomic) BtnAction cancelAction;

@end

@implementation PickerToolBar

- (instancetype)initWithToolbarText:(NSString *)toolBarText cancelAction:(BtnAction)cancelAction doneAction:(BtnAction)doneAction {
    if (self = [super init]) {
        _doneAction = [doneAction copy];
        _cancelAction = [cancelAction copy];
        self.label.text = toolBarText;
        [self addSubview:self.doneBtn];
        [self addSubview:self.cancelBtn];
        [self addSubview:self.label];
        [self addSubview:self.lineView];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat padding = 10.0f;
    CGFloat btnWidth = 75.0f;
    CGFloat lineViewHeight = 0.5f;
    CGFloat btnOrLabelHeight = self.bounds.size.height - lineViewHeight;
    CGFloat selfWidth = self.bounds.size.width;
    
    {
        CGRect cancelBtnRect = CGRectZero;
        cancelBtnRect.origin.x = padding;
        cancelBtnRect.size.width = btnWidth;
        cancelBtnRect.size.height = btnOrLabelHeight;
        self.cancelBtn.frame = cancelBtnRect;
    }
    
    {
        CGRect doneBtnRect = CGRectZero;
        doneBtnRect.size.width = btnWidth;
        doneBtnRect.origin.x = selfWidth - padding - doneBtnRect.size.width;
        doneBtnRect.size.height = btnOrLabelHeight;
        self.doneBtn.frame = doneBtnRect;
    }
    
    {
        CGRect labelRect = CGRectZero;
        labelRect.origin.x = CGRectGetMaxX(self.cancelBtn.frame) + padding;
        labelRect.size.width = selfWidth - labelRect.origin.x - 2*padding - btnWidth;
        labelRect.size.height = btnOrLabelHeight;
        self.label.frame = labelRect;
    }
    
    {
        self.lineView.frame = CGRectMake(0.0, btnOrLabelHeight, selfWidth, lineViewHeight);
    }
}

- (void)doneBtnOnClick:(UIButton *)btn {
    if (self.doneAction) {
        self.doneAction(btn);
    }
}

- (void)cancelBtnOnClick:(UIButton *)btn {
    if (self.cancelAction) {
        self.cancelAction(btn);
    }
}

- (void)dealloc {
    //    JSDLog(@"ZJToolBar ===== dealloc");
}

- (UIButton *)doneBtn {
    if (!_doneBtn) {
        UIButton *btn = [[UIButton alloc] init];
        [btn addTarget:self action:@selector(doneBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"完成" forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [btn setTitleColor:RGBCOLOR(0.21*255, 0.54*255, 0.97*255) forState:UIControlStateNormal];
        btn.titleLabel.adjustsFontSizeToFitWidth = YES;
        _doneBtn = btn;
    }
    return _doneBtn;
}

- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        UIButton *btn = [[UIButton alloc] init];
        [btn addTarget:self action:@selector(cancelBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitleColor:RGBACOLOR(170, 170, 170, 1) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
        [btn setTitle:@"取消" forState:UIControlStateNormal];
        _cancelBtn = btn;
    }
    
    return _cancelBtn;
}

- (UILabel *)label {
    if (!_label) {
        UILabel *label = [UILabel new];
        label.textColor = RGBACOLOR(120, 120, 120, 1);
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:16.0f];
        label.adjustsFontSizeToFitWidth = YES;
        
        _label = label;
    }
    
    return _label;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = RGBACOLOR(220, 220, 220, 1);
    }
    return _lineView;
}

@end
