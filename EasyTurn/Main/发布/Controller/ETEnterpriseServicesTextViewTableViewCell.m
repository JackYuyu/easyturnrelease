//
//  ETEnterpriseServicesTextViewTableViewCell.m
//  EasyTurn
//
//  Created by 程立 on 2019/9/8.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETEnterpriseServicesTextViewTableViewCell.h"
#import "ETEnterpriseServicesViewModel.h"

@interface ETEnterpriseServicesTextViewTableViewCell ()
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UITextView *tvContent;
@end

@implementation ETEnterpriseServicesTextViewTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubViewsAndConstraints];
    }
    return self;
}

- (void)makeETEnterpriseServicesTextViewTableViewCellWithModel:(ETEnterpriseServicesViewItemModel *)mItem {
    _labTitle.text = mItem.title;
    mItem.cellheight = 50;
}

#pragma mark - createSubViewsAndConstraints
- (void)createSubViewsAndConstraints {

    
    _labTitle = [[UILabel alloc] init];
    _labTitle.textColor = kACColorRGB(51, 51, 51);
    _labTitle.font = kFontSize(12);
    [self.contentView addSubview:_labTitle];
    [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.trailing.mas_equalTo(-15);
        make.centerY.equalTo(self.contentView);
        make.height.mas_equalTo(15);
    }];
    
    _tvContent = [[UITextView alloc] init];
    _tvContent.textColor = kACColorRGB(51, 51, 51);
    _tvContent.font = kFontSize(12);
    [self.contentView addSubview:_tvContent];
    [_tvContent mas_makeConstraints:^(MASConstraintMaker *make) {
        
    }];
    
}

@end
