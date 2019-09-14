//
//  EaseSyetemListCell.m
//  EasyTurn
//
//  Created by 王翔 on 2019/9/8.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "EaseSyetemListCell.h"
#import "ETProductModel.h"
@interface EaseSyetemListCell ()
@property (nonatomic, strong) UILabel *laTitle;
@property (nonatomic, strong) UILabel *laSubTitle;
@property (nonatomic, strong) UILabel *laTime;
@end

@implementation EaseSyetemListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = kACColorWhite1_R242_G242_B242_A1;
        [self createSubViewsAndConstraints];
        
    }
    return self;
}

- (void)createSubViewsAndConstraints {
    
    UIView *bgview = [[UIView alloc]init];
    [bgview addCornerRadiusWithRadius:8.0f];
    bgview.backgroundColor = kACColorWhite;
    [self.contentView addSubview:bgview];
    [bgview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-2);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
    
    [bgview addSubview:self.laTitle];
    [bgview addSubview:self.laSubTitle];
    [bgview addSubview:self.laTime];
    
    [self.laTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(18);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(21);
    }];
    
    [self.laSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.laTitle.mas_bottom).offset(9);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-5);
    }];
    
    [self.laTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.laTitle);
        make.right.mas_equalTo(-7);
        make.height.mas_equalTo(23);
    }];
}

- (void)makeCellWithETProductModel:(ETProductModel *)model WithIndexPath:(NSIndexPath *)indexPath {
//    _laSubTitle.text = model.text;
    _laTime.text = model.timestr;
}

- (UILabel *)laTitle {
    if (!_laTitle) {
        _laTitle = [[UILabel alloc]init];
        _laTitle.text = @"通知";
        _laTitle.textColor = kACColorBlackTypeface;
        _laTitle.font = kFontSize(15);
    }
    return _laTitle;
}

- (UILabel *)laSubTitle {
    if (!_laSubTitle) {
        _laSubTitle = [[UILabel alloc]init];
        _laSubTitle.numberOfLines = 0;
        _laSubTitle.text = @"欢呼来到易转大家庭!";
        _laSubTitle.textColor = kACColorRGB(153, 153, 153);
        _laSubTitle.font = kFontSize(13);
    }
    return _laSubTitle;
}

- (UILabel *)laTime {
    if (!_laTime) {
        _laTime = [[UILabel alloc]init];
        _laTime.text = @"2019-09-07 12:39";
        _laTime.textColor = kACColorRGB(102, 102, 102);;
        _laTime.font = kFontSize(12);
    }
    return _laTime;
}

@end
