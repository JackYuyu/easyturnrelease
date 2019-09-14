//
//  ETEnterpriseServicesScopeBusinessItemTableViewCell.m
//  EasyTurn
//
//  Created by 程立 on 2019/9/8.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETEnterpriseServicesScopeBusinessItemTableViewCell.h"
#import "ETEnterpriseServicesBusinessScopeModel.h"

@interface ETEnterpriseServicesScopeBusinessItemTableViewCell ()
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UIImageView *imgvSelected;
@property (nonatomic, strong) ETEnterpriseServicesBusinessScopeModel *mItem;
@end

@implementation ETEnterpriseServicesScopeBusinessItemTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubViewsAndConstraints];
    }
    return self;
}

- (void)makeETEnterpriseServicesScopeBusinessItemTableViewCellWithModel:(ETEnterpriseServicesBusinessScopeModel *)mItem {
    _mItem = mItem;
    _labTitle.text = mItem.name;
    [self updateImgvSelectedSelected:_mItem.isSelected];
    [self.contentView layoutIfNeeded];
    CGFloat labWidth = _labTitle.width;
    CGFloat height = [SSJewelryCore sizeOfString:mItem.name fittingSize:CGSizeMake(labWidth, CGFLOAT_MAX) font:_labTitle.font].height;
    height = height < 44 ? 44 : height;
    _mItem.cellheight = height;
}

#pragma mark - createSubViewsAndConstraints
- (void)createSubViewsAndConstraints {
    self.contentView.backgroundColor = kACColorRGBA(242, 242, 242, 1);
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
    _labTitle.numberOfLines = 0;
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
    if (_mItem.isSelected) {
        [[MySingleton sharedMySingleton].scopes addObject:_mItem.name];
    }else if([[MySingleton sharedMySingleton].scopes containsObject:_mItem.name]){
        [[MySingleton sharedMySingleton].scopes removeObject:_mItem.name];
    }
    [self updateImgvSelectedSelected:_mItem.isSelected];
    if ([_delegate respondsToSelector:@selector(enterpriseServicesScopeBusinessItemTableViewCell:model:)]) {
        [_delegate enterpriseServicesScopeBusinessItemTableViewCell:self model:_mItem];
    }
}

- (void)updateImgvSelectedSelected:(BOOL)selected {
    if (selected) {
        _imgvSelected.image = [UIImage imageNamed:@"circle_selected"];
    } else {
        _imgvSelected.image = [UIImage imageNamed:@"circle_select"];
    }
}

@end
