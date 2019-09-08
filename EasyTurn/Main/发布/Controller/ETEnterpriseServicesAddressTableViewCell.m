//
//  ETEnterpriseServicesAddressTableViewCell.m
//  EasyTurn
//
//  Created by 程立 on 2019/9/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETEnterpriseServicesAddressTableViewCell.h"
#import "ETEnterpriseServicesViewModel.h"

@interface ETEnterpriseServicesAddressTableViewCell ()
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UITextField *tfContent;
@property (nonatomic, strong) UIImageView *imgvArrow;
@end

@implementation ETEnterpriseServicesAddressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubViewsAndConstraints];
    }
    return self;
}


- (void)makeETEnterpriseServicesAddressTableViewCellWithModel:(ETEnterpriseServicesViewItemModel *)mItem {
    _labTitle.text = mItem.title;
    if (mItem.content.length > 0) {
        _tfContent.text = mItem.content;
    } else {
        _tfContent.placeholder = mItem.placeholder;
    }
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
        make.width.mas_equalTo(75);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(15);
    }];
    
    _imgvArrow = [[UIImageView alloc] init];
    UIImage *imgArrow = [UIImage imageNamed:@"arrow_right"];
    _imgvArrow.image = imgArrow;
    [self.contentView addSubview:_imgvArrow];
    [_imgvArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-15);
        make.centerY.equalTo(self.contentView);
        make.size.mas_equalTo(imgArrow.size);
    }];
    
    _tfContent = [[UITextField alloc] init];
    [_tfContent setEnabled:NO];
    _tfContent.textColor = kACColorRGB(51, 51, 51);
    _tfContent.font = kFontSize(15);
    [self.contentView addSubview:_tfContent];
    [_tfContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.labTitle.mas_trailing).offset(10);
        make.trailing.equalTo(self.imgvArrow.mas_leading).offset(-10);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(15);
    }];
}

@end
