//
//  HomeBaseCell.m
//  Fireball
//
//  Created by 任长平 on 2017/12/4.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "HomeBaseCell.h"
//#import "HomeSouceView.h"
//#import "NewsDetailViewController.h"

@interface HomeBaseCell ()
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UIImageView *iconView;
/// 时间 来源  标识
//@property(nonatomic, strong)HomeSouceView *souceView;
@end

@implementation HomeBaseCell

+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString * identifier = @"HomeBaseCell";
    HomeBaseCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HomeBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor whiteColor];
        
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = [UIFont systemFontOfSize:18];
        self.titleLabel.numberOfLines = 2;
        self.titleLabel.textColor = [UIColor xm_colorFromRGB:0x212832];
        [self addSubview:self.titleLabel];
        
        self.iconView = [[UIImageView alloc]init];
        [self addSubview:self.iconView];
        
        
//        self.souceView = [[HomeSouceView alloc]init];
//        [self addSubview:self.souceView];

        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureRecognizer)];
        [self addGestureRecognizer:tapGesture];
        
    }
    return self;
}
-(void)tapGestureRecognizer{
//    NewsDetailViewController * detailVC = [[NewsDetailViewController alloc]init];
//    detailVC.model = self.model;
//    [self.viewController.rt_navigationController pushViewController:detailVC animated:YES];
}
//-(void)setModel:(AticleModel *)model{
//    _model = model;
//    self.titleLabel.text = _model.Title;
//    self.souceView.model = _model;
//    [self.iconView xm_setImageWithURL:_model.ImgUrl];
    
//}

//+ (CGFloat)heightWithModel:(AticleModel *)model{
//    HomeBaseCell *cell = [[HomeBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"HomeBaseCell"];
//    cell.model = model;
//    [cell layoutIfNeeded];
//
//    return CGRectGetMaxY(cell.souceView.frame) +20;
//}


-(void)layoutSubviews{
    [super layoutSubviews];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
    }];
    
//    [self.souceView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(20);
//        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(20);
//        make.right.equalTo(self).offset(-20);
//        make.height.mas_equalTo(@20);
//    }];
}


@end
