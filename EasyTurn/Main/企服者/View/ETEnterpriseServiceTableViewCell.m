//
//  ETEnterpriseServiceTableViewCell.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/24.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import "ETEnterpriseServiceTableViewCell.h"


@interface ETEnterpriseServiceTableViewCell ()

@end

@implementation ETEnterpriseServiceTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.comImg];
        [self addSubview:self.giveserviceLab];
        [self addSubview:self.serviceLab];
        [self addSubview:self.moneyLab];
        [self addSubview:self.addressLab];
        [self addSubview:self.detailsLab];
        [self.comImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(15);
            make.left.mas_equalTo(16);
            make.size.mas_equalTo(CGSizeMake(148, 98));
        }];
        
        [self.giveserviceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(18);
            make.left.mas_equalTo(168);
            make.size.mas_equalTo(CGSizeMake(166, 16));
        }];
        
        [self.serviceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(42);
            make.left.mas_equalTo(168);
            make.size.mas_equalTo(CGSizeMake(52, 17));
        }];
        
        [self.moneyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(42);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(84, 17));
        }];
        
        [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(70);
            make.right.mas_equalTo(-23);
            make.size.mas_equalTo(CGSizeMake(176, 16));
        }];
        
        [self.detailsLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(89);
            make.left.mas_equalTo(168);
            make.size.mas_equalTo(CGSizeMake(187, 16));
        }];
    }
    return self;
}

- (UIImageView *)comImg {
    if (!_comImg) {
        _comImg=[[UIImageView alloc]init];
        _comImg.image=[UIImage imageNamed:@"11566120515_.pic_hd"];
        _comImg.layer.cornerRadius=10;
    }
    return _comImg;
}

- (UILabel *)giveserviceLab {
    if (!_giveserviceLab) {
        _giveserviceLab=[[UILabel alloc]init];
//        _giveserviceLab.backgroundColor=[UIColor blackColor];
    }
    return _giveserviceLab;
}

- (UILabel *)serviceLab {
    if (!_serviceLab) {
        _serviceLab=[[UILabel alloc]init];
//        _serviceLab.backgroundColor=[UIColor blueColor];
    }
    return _serviceLab;
}

- (UILabel *)moneyLab {
    if (!_moneyLab) {
        _moneyLab=[[UILabel alloc]init];
//        _moneyLab.backgroundColor=[UIColor blueColor];
    }
    return _moneyLab;
}

- (UILabel *)addressLab {
    if (!_addressLab) {
        _addressLab=[[UILabel alloc]init];
//        _addressLab.backgroundColor=[UIColor blueColor];
    }
    return _addressLab;
}

- (UILabel *)detailsLab {
    if (!_detailsLab) {
        _detailsLab=[[UILabel alloc]init];
//         _detailsLab.backgroundColor=[UIColor blueColor];
    }
    return _detailsLab;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
