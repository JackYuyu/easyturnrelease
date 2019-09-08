//
//  ETEnterpriseServicesCheckTableViewCell.m
//  EasyTurn
//
//  Created by 程立 on 2019/9/8.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETEnterpriseServicesCheckTableViewCell.h"
#import "ETEnterpriseServicesViewModel.h"

@interface ETEnterpriseServicesCheckTableViewCell ()
@property (nonatomic, strong) UILabel *labTitle;
//@property (nonatomic, strong) OTButton *btnFirst;
@property (nonatomic, strong) UIImageView *imgvSelected;
@property (nonatomic, strong) ETEnterpriseServicesViewItemModel *mItem;
@end

@implementation ETEnterpriseServicesCheckTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubViewsAndConstraints];
    }
    return self;
}

- (void)makeETEnterpriseServicesCheckTableViewCellWithModel:(ETEnterpriseServicesViewItemModel *)mItem {
    _mItem = mItem;
    _labTitle.text = mItem.title;
    [self updateImgvSelectedSelected:_mItem.isSelected];
    _mItem.cellheight = 50;
}

#pragma mark - createSubViewsAndConstraints
- (void)createSubViewsAndConstraints {
    
    _imgvSelected = [[UIImageView alloc] init];
    [self.contentView addSubview:_imgvSelected];
    UIImage *imgSelect = [UIImage imageNamed:@"circle_select"];
    _imgvSelected.image = imgSelect;
    [_imgvSelected mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.width.mas_equalTo(imgSelect.size.width);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(imgSelect.size.width);
    }];
    
    _labTitle = [[UILabel alloc] init];
    _labTitle.textColor = kACColorRGB(51, 51, 51);
    _labTitle.font = kFontSize(12);
    [self.contentView addSubview:_labTitle];
    [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.imgvSelected.mas_trailing).offset(15);
        make.trailing.mas_equalTo(-15);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(15);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickBtnFirst:)];
    [self.contentView addGestureRecognizer:tap];
}

#pragma mark - onClickBtn
- (void)onClickBtnFirst:(UIGestureRecognizer *)gesture {
    if (![SSJewelryCore isValidClick]) {
        return;
    }
    _mItem.isSelected = !_mItem.isSelected;
    [self updateImgvSelectedSelected:_mItem.isSelected];
}

- (void)updateImgvSelectedSelected:(BOOL)selected {
    if (selected) {
        _imgvSelected.image = [UIImage imageNamed:@"circle_selected"];
    } else {
        _imgvSelected.image = [UIImage imageNamed:@"circle_select"];
    }
}

@end
