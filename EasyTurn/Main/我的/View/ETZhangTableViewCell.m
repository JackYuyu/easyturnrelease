//
//  ETZhangTableViewCell.m
//  EasyTurn
//
//  Created by 王翔 on 2019/8/2.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETZhangTableViewCell.h"

@interface ETZhangTableViewCell()

@end

@implementation ETZhangTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.phoneImg];
        [_phoneImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(12);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(39, 39));
        }];
        
        [self addSubview:self.comLab];
        [_comLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(12);
            make.left.mas_equalTo(68);
            make.size.mas_equalTo(CGSizeMake(190, 21));
        }];
        
        [self addSubview:self.orderformLab];
        [_orderformLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(39);
            make.left.mas_equalTo(68);
            make.size.mas_equalTo(CGSizeMake(230, 18));
        }];
        
        [self addSubview:self.timeLab];
        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(61);
            make.left.mas_equalTo(68);
            make.size.mas_equalTo(CGSizeMake(168, 18));
        }];
        
        [self addSubview:self.numberLab];
        [_numberLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(32);
            make.right.mas_equalTo(-14);
            make.size.mas_equalTo(CGSizeMake(55, 25));
        }];
        
    }
    return self;
}

- (UIImageView *)phoneImg {
    if (!_phoneImg) {
        _phoneImg=[[UIImageView alloc]init];
        _phoneImg.image=[UIImage imageNamed:@"我的_Bitmap"];
    }
    return _phoneImg;
}

- (UILabel *)comLab {
    if (!_comLab) {
        _comLab=[[UILabel alloc]init];
        _comLab.numberOfLines = 0;
        _comLab.text=@"北京建筑公司 带14项资质";
        _comLab.font=[UIFont systemFontOfSize:16];
        _comLab.textAlignment = NSTextAlignmentLeft;
        _comLab.alpha = 1.0;
        _comLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    }
    return _comLab;
}

- (UILabel *)orderformLab {
    if (!_orderformLab) {
        _orderformLab=[[UILabel alloc]init];
        _orderformLab.numberOfLines = 0;
        _orderformLab.text=@"订单编号：5035843878781629";
        _orderformLab.font=[UIFont systemFontOfSize:13];
        _orderformLab.textAlignment = NSTextAlignmentLeft;
        _orderformLab.alpha = 1.0;
        _orderformLab.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    }
    return _orderformLab;
}

- (UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab=[[UILabel alloc]init];
        _timeLab.numberOfLines = 0;
        _timeLab.text=@"今天  15:33";
        _timeLab.font=[UIFont systemFontOfSize:13];
        _timeLab.textAlignment = NSTextAlignmentLeft;
        _timeLab.alpha = 1.0;
        _timeLab.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    }
    return _timeLab;
}

- (UILabel *)numberLab {
    if (!_numberLab) {
        _numberLab=[[UILabel alloc]init];
        _numberLab.numberOfLines = 0;
        _numberLab.text=@"+1500";
        _numberLab.font=[UIFont systemFontOfSize:18];
        _numberLab.textAlignment = NSTextAlignmentLeft;
        _numberLab.alpha = 1.0;
        _numberLab.textColor=[UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0];
    }
    return _numberLab;
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
