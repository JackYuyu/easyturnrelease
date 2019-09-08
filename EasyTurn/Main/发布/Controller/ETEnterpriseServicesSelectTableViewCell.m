//
//  ETEnterpriseServicesSelectTableViewCell.m
//  EasyTurn
//
//  Created by 程立 on 2019/9/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETEnterpriseServicesSelectTableViewCell.h"
#import "ETEnterpriseServicesViewModel.h"
#import "OTButton.h"

@interface ETEnterpriseServicesSelectTableViewCell ()
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) OTButton *btnFirst;
@property (nonatomic, strong) OTButton *btnSecond;
@property (nonatomic, strong) ETEnterpriseServicesViewItemModel *mItem;
@end

@implementation ETEnterpriseServicesSelectTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubViewsAndConstraints];
    }
    return self;
}

- (void)makeETEnterpriseServicesSelectTableViewCellWithModel:(ETEnterpriseServicesViewItemModel *)mItem {
    _mItem = mItem;
    _labTitle.text = mItem.title;
    [_btnFirst setTitle:mItem.selectFirst forState:UIControlStateNormal];
    [_btnSecond setTitle:mItem.selectSecond forState:UIControlStateNormal];
    CGFloat titlewWidth = [_labTitle.text ak_sizeWithFontEX:_labTitle.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 15)].width;
    titlewWidth = titlewWidth > 100 ? 100 : titlewWidth;
    [_labTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(titlewWidth);
    }];
    CGFloat btnFirstWidth = [_btnFirst.titleLabel.text ak_sizeWithFontEX:_btnFirst.titleLabel.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 15)].width + 3 + 12; // 3是间距 12 是图片宽度大小
    btnFirstWidth = btnFirstWidth > 100 ? 100 : btnFirstWidth;
    [_btnFirst mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(btnFirstWidth);
    }];
    CGFloat btnSecondWidth = [_btnSecond.titleLabel.text ak_sizeWithFontEX:_btnSecond.titleLabel.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 15)].width + 3 + 12;
    btnSecondWidth = btnSecondWidth > 100 ? 100 : btnSecondWidth;
    [_btnSecond mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(btnSecondWidth);
    }];
    mItem.cellheight = 50;
}

#pragma mark - createSubViewsAndConstraints
- (void)createSubViewsAndConstraints {
    _labTitle = [[UILabel alloc] init];
    _labTitle.textColor = kACColorRGB(51, 51, 51);
    _labTitle.font = kFontSize(15);
    [self.contentView addSubview:_labTitle];
    [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.width.mas_equalTo(60);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(15);
    }];
    
    _btnFirst = [[OTButton alloc] init];
    _btnFirst.ot_styleWithImageViewAndLabelAlignment = OTButtonImageViewAndLabelAlignmentStyleImageViewRightAndLabelLeft;
    _btnFirst.ot_marginWithImageViewAndLabel = 3;
    _btnFirst.titleLabel.font = kFontSize(13);
    [_btnFirst setTitleColor:kACColorRGB(51, 51, 51) forState:UIControlStateNormal];
    [self.contentView addSubview:_btnFirst];
    [_btnFirst mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.labTitle.mas_trailing).offset(10);
        make.width.mas_equalTo(50);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(15);
    }];
    [_btnFirst addTarget:self action:@selector(onClickBtnFirst:) forControlEvents:UIControlEventTouchUpInside];
    [_btnFirst setImage:[UIImage imageNamed:@"circle_select"] forState:UIControlStateNormal];
    [_btnFirst setImage:[UIImage imageNamed:@"circle_selected"] forState:UIControlStateSelected];
    
    
    _btnSecond = [[OTButton alloc] init];
    _btnSecond.ot_styleWithImageViewAndLabelAlignment = OTButtonImageViewAndLabelAlignmentStyleImageViewRightAndLabelLeft;
    _btnSecond.ot_marginWithImageViewAndLabel = 3;
    _btnSecond.titleLabel.font = kFontSize(15);
    [_btnSecond setTitleColor:kACColorRGB(51, 51, 51) forState:UIControlStateNormal];
    [self.contentView addSubview:_btnSecond];
    [_btnSecond mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.btnFirst.mas_trailing).offset(30);
        make.width.mas_equalTo(50);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(15);
    }];
    [_btnSecond addTarget:self action:@selector(onClickBtnSecond:) forControlEvents:UIControlEventTouchUpInside];
    [_btnSecond setImage:[UIImage imageNamed:@"circle_select"] forState:UIControlStateNormal];
    [_btnSecond setImage:[UIImage imageNamed:@"circle_selected"] forState:UIControlStateSelected];
}

#pragma mark - onClickBtn
- (void)onClickBtnFirst:(UIButton *)sender {
    if (![SSJewelryCore isValidClick]) {
        return;
    }
    sender.selected = YES;
    _btnSecond.selected = !sender.selected;
    _mItem.value = sender.currentTitle;

}

#pragma mark - onClickBtn
- (void)onClickBtnSecond:(UIButton *)sender {
    if (![SSJewelryCore isValidClick]) {
        return;
    }
    sender.selected = YES;
    _btnFirst.selected = !sender.selected;
    _mItem.value = sender.currentTitle;
}

@end
