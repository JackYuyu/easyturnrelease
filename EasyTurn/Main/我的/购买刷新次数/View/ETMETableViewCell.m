//
//  ETMETableViewCell.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/20.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import "ETMETableViewCell.h"
#import "Masonry.h"
@implementation ETMETableViewCell
-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated

{
    
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addSubview:self.comImg];
        [self addSubview:self.comLab];
        [self addSubview:self.sellLab];
        [self addSubview:self.locaImg];
        [self addSubview:self.addressLab];
        [self addSubview:self.priceLab];
        [self addSubview:self.frishBtn];
        [self addSubview:self.deleteBtn];
        [_comImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(17);
            make.left.mas_equalTo(16);
            make.size.mas_equalTo(CGSizeMake(148 ,98 ));
        }];
        
        [_comLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(17);
            make.right.mas_equalTo(-24);
            make.size.mas_equalTo(CGSizeMake(178 ,21 ));
        }];
        
        [_sellLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(42);
            make.right.mas_equalTo(-164);
            make.size.mas_equalTo(CGSizeMake(38 ,18));
        }];
        
        [_locaImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(69);
            make.right.mas_equalTo(-193);
            make.size.mas_equalTo(CGSizeMake(7 ,9 ));
        }];
    }
    return self;
}

- (UIImageView *)comImg {
    if (!_comImg) {
        _comImg=[[UIImageView alloc]init];
        _comImg.backgroundColor=[UIColor blackColor];
    }
    return _comImg;
}

- (UILabel *)comLab {
    if (!_comLab) {
        _comLab=[[UILabel alloc]init];
        _comLab.backgroundColor=[UIColor redColor];
    }
    return _comLab;
}

- (UILabel *)sellLab {
    if (!_sellLab) {
        _sellLab=[[UILabel alloc]init];
        _sellLab.backgroundColor=[UIColor blueColor];
    }
    return _sellLab;
}

- (UIImageView *)locaImg {
    if (!_locaImg) {
        _locaImg=[[UIImageView alloc]init];
        _locaImg.backgroundColor=[UIColor blueColor];
    }
    return _locaImg;
}

- (UILabel *)addressLab {
    if (!_addressLab) {
        _addressLab=[[UILabel alloc]init];
    }
    return _addressLab;
}

- (UILabel *)priceLab {
    if (!_priceLab) {
        _priceLab=[[UILabel alloc]init];
    }
    return _priceLab;
}

- (UIButton *)frishBtn {
    if (!_frishBtn) {
        _frishBtn=[[UIButton alloc]init];
    }
    return _frishBtn;
}

- (UIButton *)deleteBtn {
    if (!_deleteBtn) {
        if (!_deleteBtn) {
            _deleteBtn=[[UIButton alloc]init];
        }
    }
    return _deleteBtn;
}


@end
