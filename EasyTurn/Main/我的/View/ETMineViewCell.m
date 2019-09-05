//
//  ETMineViewCell.m
//  EasyTurn
//
//  Created by 王翔 on 2019/9/2.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETMineViewCell.h"


@interface ETMineViewCell ()
@property (nonatomic, strong) UIImageView *imagevIcon;
@property (nonatomic, strong) UILabel *laTitle;
@end

@implementation ETMineViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self createSubViewsAndConstraints];
        
    }
    return self;
}

-(void)createSubViewsAndConstraints {
    
    [self.contentView addSubview:self.imagevIcon];
    [self.contentView addSubview:self.laTitle];
    
    [self.imagevIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    [self.laTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.imagevIcon.mas_right).offset(11);
        make.height.mas_equalTo(15);
        make.right.mas_equalTo(-15);
    }];
}

- (UIImageView *)imagevIcon {
    if (!_imagevIcon) {
        _imagevIcon = [[UIImageView alloc]init];
        _imagevIcon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imagevIcon;
}

- (UILabel *)laTitle {
    if (!_laTitle) {
        _laTitle = [[UILabel alloc]init];
        _laTitle.textColor = kACColorRGB(51, 51, 51);
        _laTitle.font = kFontSize(15);
    }
    return _laTitle;
}

@end
