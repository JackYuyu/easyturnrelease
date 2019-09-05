//
//  ETMineGridCollectionCell.m
//  EasyTurn
//
//  Created by 王翔 on 2019/9/3.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETMineGridCollectionCell.h"

@interface ETMineGridCollectionCell ()

@end

@implementation ETMineGridCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self createSubViewsAndConstraints];
        
    }
    return self;
}

#pragma mark - Create Subviews
- (void)createSubViewsAndConstraints {
    
    _imagevGrid = [[UIImageView alloc]init];
    [self.contentView addSubview:_imagevGrid];
    [_imagevGrid mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.centerX.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    _laGirdTitle = [[UILabel alloc]init];
    _laGirdTitle.font = kFontSize(13);
    _laGirdTitle.textColor = kACColorRGB(51, 51, 51);
    _laGirdTitle.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_laGirdTitle];
    [_laGirdTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imagevGrid.mas_bottom).offset(7);
        make.centerX.equalTo(self.contentView);
    }];
    
}
@end
