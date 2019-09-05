//
//  ETMineHeaderView.m
//  EasyTurn
//
//  Created by 王翔 on 2019/9/2.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETMineHeaderView.h"


@interface ETMineHeaderView ()
@property (nonatomic, strong) UIImageView *imagevHeader;
@property (nonatomic, strong) UILabel *laName;
@property (nonatomic, strong) UIImageView *imagevUserType;
@property (nonatomic, strong) UILabel *laVip;
@property (nonatomic, strong) UILabel *laIdAuthentication;
@property (nonatomic, strong) UIButton *btnPayVip;
@end

@implementation ETMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self createSubViewsAndConstraints];
        
    }
    return self;
}

- (void)createSubViewsAndConstraints {
    
    [self addSubview:self.imagevHeader];
    [self addSubview:self.laName];
    [self addSubview:self.laVip];
    [self addSubview:self.btnPayVip];
    
    [self.imagevHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(60, 60));
    }];
    
    [self.laName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imagevHeader);
        make.left.equalTo(self.imagevHeader.mas_right).offset(15);
        make.height.mas_equalTo(21);
    }];
    
    [self.imagevUserType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.laName);
        make.left.equalTo(self.laName.mas_right).offset(4);
        make.size.mas_equalTo(CGSizeMake(27, 12));
    }];
    
    [self.laVip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.laName.mas_bottom).offset(3);
        make.left.equalTo(self.laName);
        make.height.mas_equalTo(17);
        make.right.mas_equalTo(-100);
    }];
    
    [self.laIdAuthentication mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.laVip.mas_bottom).offset(3);
        make.left.equalTo(self.laName);
        make.height.mas_equalTo(17);
        make.right.mas_equalTo(-100);
    }];
    
    [self.btnPayVip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imagevHeader);
        make.right.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(90, 33));
    }];
    
}

- (UIImageView *)imagevHeader {
    if (!_imagevHeader) {
        _imagevHeader = [[UIImageView alloc]init];
        _imagevHeader.contentMode = UIViewContentModeScaleAspectFit;
        [_imagevHeader addCornerRadiusWithRadius:4.0f];
    }
    return _imagevHeader;
}

- (UILabel *)laName {
    if (!_laName) {
        _laName = [[UILabel alloc]init];
        _laName.textColor = kACColorRGB(51, 51, 51);
        _laName.font = kFontSize(15);
    }
    return _laName;
}

- (UIImageView *)imagevUserType {
    if (!_imagevUserType) {
        _imagevUserType = [[UIImageView alloc]init];
        _imagevUserType.contentMode = UIViewContentModeScaleAspectFit;
        _imagevUserType.image = [UIImage imageNamed:@"我的_企服者"];
    }
    return _imagevHeader;
}

- (UILabel *)laVip {
    if (!_laVip) {
        _laVip = [[UILabel alloc]init];
        _laVip.textColor = kACColorRGB(153, 153, 153);
        _laVip.font = kFontSize(12);
    }
    return _laVip;
}

- (UILabel *)laIdAuthentication {
    if (!_laIdAuthentication) {
        _laIdAuthentication = [[UILabel alloc]init];
        _laIdAuthentication.textColor = kACColorRGB(153, 153, 153);
        _laIdAuthentication.font = kFontSize(12);
    }
    return _laIdAuthentication;
}

- (UIButton *)btnPayVip {
    if (!_btnPayVip) {
        _btnPayVip = [UIButton buttonWithType:UIButtonTypeCustom];
        [_btnPayVip setImage:[UIImage imageNamed:@"我的_续费VIP"] forState:UIControlStateNormal];
        [_btnPayVip setImage:[UIImage imageNamed:@"我的_续费VIP"] forState:UIControlStateHighlighted];
    }
    return _btnPayVip;
}
@end
