//
//  ETEnterpriseServicesSwitchTableViewCell.m
//  EasyTurn
//
//  Created by 程立 on 2019/9/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETEnterpriseServicesSwitchTableViewCell.h"
#import "ETEnterpriseServicesViewModel.h"

@interface ETEnterpriseServicesSwitchTableViewCell ()
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UISwitch *swiServices;
@property (nonatomic, strong) ETEnterpriseServicesViewItemModel *mItem;
@end

@implementation ETEnterpriseServicesSwitchTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubViewsAndConstraints];
        NSMutableAttributedString *stringTitle = [[NSMutableAttributedString alloc] initWithString:@"精准推送平台企服者"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
         NSMutableAttributedString *stringSubTitle = [[NSMutableAttributedString alloc] initWithString:@"\n(平台精准推送一次消耗10次刷新次数)" attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12],NSForegroundColorAttributeName: kACColorRGBA(248, 124, 43, 1)}];
        [stringTitle appendAttributedString:stringSubTitle];
        _labTitle.attributedText = stringTitle;
    }
    return self;
}

- (void)makeETEnterpriseServicesSwitchTableViewCellWithModel:(ETEnterpriseServicesViewItemModel *)mItem {
    _mItem = mItem;
}

#pragma mark - createSubViewsAndConstraints
- (void)createSubViewsAndConstraints {
    
    _swiServices = [[UISwitch alloc] init];
    _swiServices.onTintColor = RGBCOLOR(0.21*255, 0.54*255, 0.97*255);
    _swiServices.on = NO;
    [_swiServices addTarget:self action:@selector(swiServicesValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:_swiServices];
    [_swiServices mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-30);
        make.width.mas_equalTo(35);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(18);
    }];
    
    _labTitle = [[UILabel alloc] init];
    _labTitle.textColor = kACColorRGB(51, 51, 51);
    _labTitle.font = kFontSize(15);
    _labTitle.numberOfLines = 0;
    [self.contentView addSubview:_labTitle];
    [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.trailing.equalTo(self.swiServices.mas_leading).offset(-15);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(50);
    }];
}

- (void)swiServicesValueChanged:(UISwitch *)sender {
    _mItem.isOpen = sender.isOn;
}


@end
