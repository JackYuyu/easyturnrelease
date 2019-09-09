//
//  ETMineListViewCell.m
//  EasyTurn
//
//  Created by 王翔 on 2019/9/3.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETMineListViewCell.h"
#import "ETMineViewModel.h"
@interface ETMineListViewCell ()
@property (nonatomic, strong) UIImageView *imagevGoods;
@property (nonatomic, strong) UILabel *laName;
@property (nonatomic, strong) UILabel *laSubTitle;
@property (nonatomic, strong) UIImageView *imagevLocation;
@property (nonatomic, strong) UILabel *laStatus;
@property (nonatomic, strong) UILabel *laAddress;
@property (nonatomic, strong) UILabel *laTime;
@property (nonatomic, strong) UILabel *laLookCount;
@property (nonatomic, strong) UILabel *laPrice;
@property (nonatomic, strong) UIButton *btnShare;
@property (nonatomic, strong) UIButton *btnRefresh;
@property (nonatomic, strong) UIButton *btnDelete;
@property (nonatomic, strong) UIButton *btnLook;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation ETMineListViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self createSubViewsAndConstraints];
        
    }
    return self;
}

- (void)createSubViewsAndConstraints {
    
    [self.contentView addSubview:self.imagevGoods];
    [self.contentView addSubview:self.laName];
    [self.contentView addSubview:self.laSubTitle];
    [self.contentView addSubview:self.imagevLocation];
    [self.contentView addSubview:self.laStatus];
    [self.contentView addSubview:self.laAddress];
    [self.contentView addSubview:self.laTime];
    [self.contentView addSubview:self.laLookCount];
    [self.contentView addSubview:self.laPrice];
    [self.contentView addSubview:self.btnShare];
    [self.contentView addSubview:self.btnRefresh];
    [self.contentView addSubview:self.btnDelete];
    [self.contentView addSubview:self.btnLook];
    
    [self.imagevGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(17);
        make.left.mas_equalTo(16);
        make.size.mas_equalTo(CGSizeMake(145, 95));
    }];
    
    [self.laName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imagevGoods);
        make.left.equalTo(self.imagevGoods.mas_right).offset(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(21);
    }];
    
    [self.laSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.laName.mas_bottom).offset(5);
        make.left.equalTo(self.laName);
        make.right.equalTo(self.laName);
        make.height.mas_equalTo(19);
    }];
    
    [self.imagevLocation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.laSubTitle.mas_bottom).offset(9);
        make.left.equalTo(self.laName);
        make.size.mas_equalTo(CGSizeMake(10, 10));
    }];
    
    [self.laAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imagevLocation);
        make.left.equalTo(self.imagevLocation.mas_right).offset(3);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    [self.laTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.laAddress);
        make.left.equalTo(self.laAddress.mas_right).offset(5);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(15);
    }];
    
    [self.laPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.laAddress.mas_bottom).offset(5);
        make.left.equalTo(self.laName);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(20);
    }];
    
    [self.laStatus mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.laPrice);
        make.right.equalTo(self.laName);
        make.height.mas_equalTo(20);
    }];
    
    [self.btnShare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12);
        make.left.mas_equalTo(159);
        make.size.mas_equalTo(CGSizeMake(61, 26));
    }];
    
    [self.btnRefresh mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12);
        make.left.equalTo(self.btnShare.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(61, 26));
    }];
    
    [self.btnDelete mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-12);
        make.left.equalTo(self.btnRefresh.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(61, 26));
    }];
    
    
}

- (void)makeCellWithUserInfosReleaseModel:(UserInfosReleaseModel *)model indexPath:(NSIndexPath *)indexPath {
    _indexPath = indexPath;
    [self.imagevGoods sd_setImageWithURL:[NSURL URLWithString:model.imageList]];
    self.laName.text = model.title;
    self.laSubTitle.text = [NSString stringWithFormat:@"详细内容:%@",model.detail];
    self.laAddress.text = model.cityName;
    self.laTime.text = model.releaseTime;
    self.laStatus.text = [NSString stringWithFormat:@"浏览%@次",model.browse];
    if ([model.releaseTypeId isEqualToString:@"1"]) {
        self.laSubTitle.text = [NSString stringWithFormat:@"经营范围:%@",model.information];
    }

    NSString *temp = model.price;
    double price = [temp doubleValue];
    if (price >= 10000.0) {
        self.laPrice.text = [NSString stringWithFormat:@"¥%.0f万",price/10000.0];
        
    }else {
        float price =[temp floatValue];
        self.laPrice.text = [NSString stringWithFormat:@"¥%.2f",price];
    }
    self.laPrice.text =[self.laPrice.text stringByReplacingOccurrencesOfString:@".00" withString:@""];

}

- (void)onClickType:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(onCLickETMineListViewCellButtonType:WithIndexPath:)]) {
        [_delegate onCLickETMineListViewCellButtonType:sender WithIndexPath:_indexPath];
    }
}

#pragma mark -
- (UIImageView *)imagevGoods {
    if (!_imagevGoods) {
        _imagevGoods = [[UIImageView alloc]init];
        [_imagevGoods addCornerRadiusWithRadius:4.0f];
        
    }
    return _imagevGoods;
}

- (UILabel *)laName {
    if (!_laName) {
        _laName = [[UILabel alloc]init];
        _laName.font = kFontSize(15);
        _laName.textColor = kACColorRGB(51, 51, 51);
        _laName.text = @"奥术大师多撒大多所";
    }
    return _laName;
}

- (UILabel *)laSubTitle {
    if (!_laSubTitle) {
        _laSubTitle = [[UILabel alloc]init];
        _laSubTitle.font = kFontSize(13);
        _laSubTitle.textColor = kACColorRGB(153, 153, 153);
        _laSubTitle.text = @"奥术大师多撒大多所asdasdaa奥术大师大所多";
    }
    return _laSubTitle;
}

- (UIImageView *)imagevLocation {
    if (!_imagevLocation) {
        _imagevLocation = [[UIImageView alloc]init];
        _imagevLocation.image = [UIImage imageNamed:@"动态列表_定位"];
        
    }
    return _imagevLocation;
}

- (UILabel *)laAddress {
    if (!_laAddress) {
        _laAddress = [[UILabel alloc]init];
        _laAddress.font = kFontSize(11);
        _laAddress.textColor = kACColorRGB(102, 102, 102);
        _laAddress.text = @"北京 朝阳";
    }
    return _laAddress;
}

- (UILabel *)laTime {
    if (!_laTime) {
        _laTime = [[UILabel alloc]init];
        _laTime.font = kFontSize(11);
        _laTime.textColor = kACColorRGB(102, 102, 102);
        _laTime.text = @"2019-09-05";
    }
    return _laTime;
}

- (UILabel *)laPrice{
    if (!_laPrice) {
        _laPrice = [[UILabel alloc]init];
        _laPrice.font = kFontSize(14);
        _laPrice.textColor = kACColorRGB(248, 124, 43);
        _laPrice.text = @"3000";
    }
    return _laPrice;
}

- (UILabel *)laStatus{
    if (!_laStatus) {
        _laStatus = [[UILabel alloc]init];
        _laStatus.font = kFontSize(14);
        _laStatus.textColor = kACColorRGB(102, 102, 102);
        _laStatus.text = @"浏览 303次";
    }
    return _laStatus;
}

- (UIButton *)btnShare {
    if (!_btnShare) {
        _btnShare = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnShare.tag = 1000;
        _btnShare.layer.borderColor = kACColorRGB(102, 102, 102).CGColor;
        _btnShare.layer.borderWidth = 1;
        [_btnShare addCornerRadiusWithRadius:4.0f];
        [_btnShare setTitle:@"分享" forState:UIControlStateNormal];
        [_btnShare setTitleColor:kACColorRGB(102, 102, 102) forState:UIControlStateNormal];
        _btnShare.titleLabel.font = kFontSize(13);
        [_btnShare addTarget:self action:@selector(onClickType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnShare;
}

- (UIButton *)btnRefresh {
    if (!_btnRefresh) {
        _btnRefresh = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnRefresh.tag = 1001;
        _btnRefresh.layer.borderColor = kACColorRGB(102, 102, 102).CGColor;
        _btnRefresh.layer.borderWidth = 1;
        [_btnRefresh addCornerRadiusWithRadius:4.0f];
        [_btnRefresh setTitle:@"刷新" forState:UIControlStateNormal];
        [_btnRefresh setTitleColor:kACColorRGB(102, 102, 102) forState:UIControlStateNormal];
        _btnRefresh.titleLabel.font = kFontSize(13);
        [_btnRefresh addTarget:self action:@selector(onClickType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnRefresh;
}

- (UIButton *)btnDelete {
    if (!_btnDelete) {
        _btnDelete = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnDelete.tag = 1002;
        _btnDelete.layer.borderColor = kACColorRGB(102, 102, 102).CGColor;
        _btnDelete.layer.borderWidth = 1;
        [_btnDelete addCornerRadiusWithRadius:4.0f];
        [_btnDelete setTitle:@"删除" forState:UIControlStateNormal];
        [_btnDelete setTitleColor:kACColorRGB(102, 102, 102) forState:UIControlStateNormal];
        _btnDelete.titleLabel.font = kFontSize(13);
        [_btnDelete addTarget:self action:@selector(onClickType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDelete;
}

- (UIButton *)btnLook {
    if (!_btnLook) {
        _btnLook = [UIButton buttonWithType:UIButtonTypeCustom];
        _btnLook.tag = 1003;
        _btnLook.layer.borderColor = kACColorRGB(102, 102, 102).CGColor;
        _btnLook.layer.borderWidth = 1;
        [_btnLook addCornerRadiusWithRadius:4.0f];
        [_btnLook setTitle:@"查看" forState:UIControlStateNormal];
        [_btnLook setTitleColor:kACColorWhite forState:UIControlStateNormal];
        _btnLook.backgroundColor = kACColorRGB(20, 138, 236);
        _btnLook.titleLabel.font = kFontSize(13);
        [_btnLook addTarget:self action:@selector(onClickType:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLook;
}

@end
