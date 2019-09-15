//
//  ETEnterpriseServicesTitleTableViewCell.m
//  EasyTurn
//
//  Created by 程立 on 2019/9/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETEnterpriseServicesTitleTableViewCell.h"
#import "ETEnterpriseServicesViewModel.h"


@interface ETEnterpriseServicesTitleTableViewCell ()
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UITextField *tfContent;
@property (nonatomic, strong) ETEnterpriseServicesViewItemModel *mItem;
@end

@implementation ETEnterpriseServicesTitleTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubviews];
    }
    return self;
}

- (void)makeETEnterpriseServicesTitleTableViewCellWithModel:(ETEnterpriseServicesViewItemModel *)mItem {
    _mItem = mItem;
    _labTitle.text = mItem.title;
    CGFloat titlewWidth = [_labTitle.text ak_sizeWithFontEX:_labTitle.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 15)].width;
    titlewWidth = titlewWidth > 100 ? 100 : titlewWidth;
    [_labTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(titlewWidth);
    }];
    _tfContent.placeholder = mItem.placeholder;
    if (mItem.content.length > 0) {
        _tfContent.text = mItem.content;
    } else {
        _tfContent.text = nil;
    }
    mItem.cellheight = 50;
    if ([mItem.title isEqualToString:@"联系人"] ||
        [mItem.title isEqualToString:@"联系电话"]) {
        self.tfContent.textAlignment = NSTextAlignmentRight;
    }else{
        self.tfContent.textAlignment = NSTextAlignmentLeft;
    }
}

- (void)createSubviews {
    _labTitle = [[UILabel alloc] init];
    _labTitle.textColor = kACColorRGB(51, 51, 51);
    _labTitle.font = kFontSize(15);
    [self.contentView addSubview:_labTitle];
    [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.width.mas_equalTo(0);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(15);
    }];
    
    _tfContent = [[UITextField alloc] init];
    _tfContent.textColor = kACColorRGB(51, 51, 51);
    _tfContent.font = kFontSize(15);
    [_tfContent addTarget:self action:@selector(tfContentValueChange:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:_tfContent];
    [_tfContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.labTitle.mas_trailing).offset(10);
        make.trailing.mas_equalTo(-15);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(15);
    }];
}

#pragma mark - UITextFieldDelegate
- (void)tfContentValueChange:(UITextField *)textField {
    _mItem.content = textField.text;
    _mItem.value = textField.text;
}

@end
