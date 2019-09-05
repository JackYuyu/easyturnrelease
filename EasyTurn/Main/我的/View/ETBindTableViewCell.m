//
//  ETBindTableViewCell.m
//  EasyTurn
//
//  Created by 王翔 on 2019/8/9.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETBindTableViewCell.h"

@interface ETBindTableViewCell()
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UITextField *nameText;
@property (nonatomic,strong) UILabel *alipayLab;
@property (nonatomic,strong) UITextField *alipayText;
@end

@implementation ETBindTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.nameLab];
        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(40, 21));
        }];
        [self addSubview:self.nameText];
        [self.nameText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(21);
            make.left.mas_equalTo(113);
            make.size.mas_equalTo(CGSizeMake(120, 21));
        }];
        
//        [self addSubview:self.alipayLab];
//        [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(20);
//            make.left.mas_equalTo(15);
//            make.size.mas_equalTo(CGSizeMake(78, 21));
//        }];
//        
//        [self addSubview:self.alipayText];
//        [self.nameText mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(21);
//            make.left.mas_equalTo(113);
//            make.size.mas_equalTo(CGSizeMake(160, 21));
//        }];
        }
    return self;
}





- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab=[[UILabel alloc]init];
        _nameLab.text=@"姓名";
        _nameLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _nameLab.font=[UIFont systemFontOfSize:15];
    }
    return _nameLab;
}    
- (UITextField *)nameText {
    if (!_nameText) {
        _nameText=[[UITextField alloc]init];
        _nameText.placeholder=@"请输入您的真实姓名";
        _nameText.font=[UIFont systemFontOfSize:13];
    }
    return _nameText;
}

//- (UILabel *)alipayLab {
//    if (!_alipayLab) {
//        _alipayLab=[[UILabel alloc]init];
//        _alipayLab.text=@"支付宝账号";
//        _alipayLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//        _alipayLab.font=[UIFont systemFontOfSize:15];
//    }
//    return _alipayLab;
//}
//
//- (UITextField *)alipayText {
//    if (!_alipayText) {
//        _alipayText=[[UITextField alloc]init];
//        _alipayText.placeholder=@"请输入您本人的支付宝账号";
//        _alipayText.font=[UIFont systemFontOfSize:13];
//    }
//    return _nameText;
//}
@end
