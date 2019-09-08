//
//  ETEnterpriseServicesScopeBusinessSectionHeaderView.m
//  EasyTurn
//
//  Created by 程立 on 2019/9/8.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETEnterpriseServicesScopeBusinessSectionHeaderView.h"
#import "ETEnterpriseServicesBusinessScopeModel.h"

@interface ETEnterpriseServicesScopeBusinessSectionHeaderView ()
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UIImageView *imgvArrow;
@property (nonatomic, strong) ETEnterpriseServicesBusinessScopeModel *mItem;
@property (nonatomic, assign) NSInteger section;
@end

@implementation ETEnterpriseServicesScopeBusinessSectionHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self createSubViewsAndConstraints];
    }
    return self;
}

- (void)makeETEnterpriseServicesScopeBusinessSectionHeaderViewWithModel:(ETEnterpriseServicesBusinessScopeModel *)mItem section:(NSInteger)section{
    _section = section;
    _mItem = mItem;
    _labTitle.text = mItem.name;
    [self updateImgvSelectedIsOpen:_mItem.isOpen];
    _mItem.cellheight = 45;
}

#pragma mark - createSubViewsAndConstraints
- (void)createSubViewsAndConstraints {
    _imgvArrow = [[UIImageView alloc] init];
    UIImage *imgArrow = [UIImage imageNamed:@"arrow_right"];
    _imgvArrow.image = imgArrow;
    [self.contentView addSubview:_imgvArrow];
    [_imgvArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-15);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(imgArrow.size);
    }];
    
    _labTitle = [[UILabel alloc] init];
    _labTitle.textColor = kACColorRGB(51, 51, 51);
    _labTitle.font = kFontSize(15);
    [self.contentView addSubview:_labTitle];
    [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.trailing.equalTo(self.imgvArrow.mas_leading).offset(-15);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(15);
    }];
    
    UIView *vLine = [[UIView alloc] init];
    vLine.backgroundColor = kACColorLine_R211_G211_B211_A1;
    [self.contentView addSubview:vLine];
    [vLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(-15);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(kLinePixel);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickSectionView:)];
    [self addGestureRecognizer:tap];
}

- (void)onClickSectionView:(UIGestureRecognizer *)gesture {
    _mItem.isOpen = !_mItem.isOpen;
    [self updateImgvSelectedIsOpen:_mItem.isOpen];
    if ([_delegate respondsToSelector:@selector(enterpriseServicesScopeBusinessSectionHeaderView:model:section:)]) {
        [_delegate enterpriseServicesScopeBusinessSectionHeaderView:self model:_mItem section:_section];
    }
}

- (void)updateImgvSelectedIsOpen:(BOOL)isOpen {
    UIImage *imgArrow = nil;
    if (isOpen) {
        imgArrow = [UIImage imageNamed:@"arrow_top"];
    } else {
        imgArrow = [UIImage imageNamed:@"arrow_right"];
    }
    _imgvArrow.image = imgArrow;
    [_imgvArrow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(imgArrow.size);
    }];
}


@end
