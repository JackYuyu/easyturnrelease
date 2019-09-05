//
//  ACMyBenchToolCollectionViewCell.m
//  AutoTraderCloud
//
//  Created by OUT MAN on 2017/10/20.
//  Copyright © 2017年 AutoHome. All rights reserved.
//

#import "ACMyBenchToolCollectionViewCell.h"
#import "OTDynamicGridModel.h"

@interface ACMyBenchToolCollectionViewCell ()
@property (nonatomic, strong) UIImageView *ivIcon;
@property (nonatomic, strong) UILabel *labTitle;

@end

@implementation ACMyBenchToolCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = kACColorWhite;
        [self createSubViewsAndConstraints];
    }
    return self;
}

- (void)createSubViewsAndConstraints {
    _ivIcon = [[UIImageView alloc] init];
    [self.contentView addSubview:_ivIcon];
    [_ivIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(50);
        make.top.mas_equalTo(8);
        make.centerX.equalTo(self.contentView);
        make.width.mas_equalTo(70);
    }];
    
    _labTitle = [[UILabel alloc] init];
    _labTitle.font = kFontSize(12);
    _labTitle.textColor = kACColorGray1_R25_G25_B25_A1;
    _labTitle.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_labTitle];
    WEAKSELF
    [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.mas_equalTo(0);
        make.height.mas_equalTo(weakSelf.labTitle.font.lineHeight);
        make.top.equalTo(weakSelf.ivIcon.mas_bottom).offset(10);
    }];
}

- (void)makeCallWithMyBenchToolModuleItemModel:(OTDynamicGridModel *)mItem indexPath:(NSIndexPath *)indexPath {
    _labTitle.text = mItem.title;
    _ivIcon.image = [UIImage imageNamed:mItem.imgName];
}

@end
