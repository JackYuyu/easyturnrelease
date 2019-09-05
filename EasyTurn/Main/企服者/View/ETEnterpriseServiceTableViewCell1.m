//
//  ETEnterpriseServiceTableViewCell1.m
//  EasyTurn
//
//  Created by 程立 on 2019/7/28.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETEnterpriseServiceTableViewCell1.h"

@interface ETEnterpriseServiceTableViewCell1 ()

@end

@implementation ETEnterpriseServiceTableViewCell1
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
        _comImg.contentMode=UIViewContentModeScaleAspectFit;
        _comImg.layer.cornerRadius=10;
        _comImg.clipsToBounds = YES;
    }
    return _comImg;
}

- (UILabel *)giveserviceLab {
    if (!_giveserviceLab) {
        _giveserviceLab=[[UILabel alloc]init];
        _giveserviceLab.font=[UIFont systemFontOfSize:15];
        _giveserviceLab.textColor=[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        //        _giveserviceLab.backgroundColor=[UIColor blackColor];
    }
    return _giveserviceLab;
}

- (UILabel *)serviceLab {
    if (!_serviceLab) {
        _serviceLab=[[UILabel alloc]init];
        _serviceLab.font=[UIFont systemFontOfSize:13];
        _serviceLab.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        //        _serviceLab.backgroundColor=[UIColor blueColor];
    }
    return _serviceLab;
}

- (UILabel *)moneyLab {
    if (!_moneyLab) {
        _moneyLab=[[UILabel alloc]init];
        _moneyLab.font=[UIFont systemFontOfSize:14];
        _moneyLab.textColor=[UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0];
        //        _moneyLab.backgroundColor=[UIColor blueColor];
    }
    return _moneyLab;
}

- (UILabel *)addressLab {
    if (!_addressLab) {
        _addressLab=[[UILabel alloc]init];
        [_addressLab setFont:[UIFont systemFontOfSize:12]];
        _addressLab.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    }
    return _addressLab;
}

- (UILabel *)detailsLab {
    if (!_detailsLab) {
        _detailsLab=[[UILabel alloc]init];
        [_detailsLab setFont:[UIFont systemFontOfSize:12]];
        _detailsLab.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
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
