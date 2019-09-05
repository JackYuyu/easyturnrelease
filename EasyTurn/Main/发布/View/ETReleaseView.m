//
//  ETReleaseView.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/25.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import "ETReleaseView.h"

@interface ETReleaseView ()
@property (nonatomic,strong) UIView *view;
@end
@implementation ETReleaseView

- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self addSubview:self.view];
        [self.view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(Screen_Width, Screen_Height));
        }];
        
        [self addSubview:self.publishImg];
        [self.publishImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(459);
            make.left.mas_equalTo(57);
            make.size.mas_equalTo(CGSizeMake(44, 44));
        }];
        
        [self addSubview:self.publishLab];
        [self.publishLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(505);
            make.left.mas_equalTo(50);
            make.size.mas_equalTo(CGSizeMake(59, 21));
        }];
        
        [self addSubview:self.publishBtn];
        [self.publishBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(459);
            make.left.mas_equalTo(50);
            make.size.mas_equalTo(CGSizeMake(59, 65));
        }];
        
        [self addSubview:self.fanhuiBtn];
        [self.fanhuiBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(552);
            make.left.mas_equalTo(175);
            make.size.mas_equalTo(CGSizeMake(21, 21));
        }];
    }
    return self;
}

- (UIView *)view {
    if (!_view) {
        _view=[[UIView alloc]init];
        _view.backgroundColor=[UIColor whiteColor];
    }
    return _view;
}

- (UIImageView *)publishImg {
    if (!_publishImg) {
        _publishImg= [[UIImageView alloc]init];
        _publishImg.image=[UIImage imageNamed:@"shangpin"];
    }
    return _publishImg;
}

- (UILabel *)publishLab {
    if (!_publishLab) {
        _publishLab= [[UILabel alloc]init];
        _publishLab.text=@"发布出售";
        _publishLab.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        _publishLab.font=[UIFont systemFontOfSize:13];
    }
    return _publishLab;
}

- (UIButton *)publishBtn {
    if (!_publishBtn) {
        _publishBtn= [[UIButton alloc]init];
    }
    return _publishBtn;
}

- (UIButton *)fanhuiBtn {
    if (!_fanhuiBtn) {
        _fanhuiBtn=[[UIButton alloc]init];
        [_fanhuiBtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
        [_fanhuiBtn addTarget:self action:@selector(putWebVCBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fanhuiBtn;
}
- (void)putWebVCBtnClick:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(putWebVC:)]) {
        [self.delegate putWebVC:sender];
    }
}

//- (void)agreementBtnClick:(UIButton*)sender
//{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(jumpWebVC:)]) {
//        [self.delegate jumpWebVC:sender];
//    }
//}
//
//- (void)agreementBtnClick1:(UIButton*)sender
//{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(jumpWebVC1:)]) {
//        [self.delegate jumpWebVC1:sender];
//    }
//}
//
//- (void)agreementBtnClick2:(UIButton*)sender
//{
//    if (self.delegate && [self.delegate respondsToSelector:@selector(jumpWebVC2:)]) {
//        [self.delegate jumpWebVC2:sender];
//    }
//}

@end
