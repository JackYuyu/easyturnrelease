//
//  ETAboutViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/23.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import "ETAboutViewController.h"

@interface ETAboutViewController ()
@property(nonatomic,strong)UIImageView *yizhuanImg;
@property(nonatomic,strong)UILabel *editionLab;
@property(nonatomic,strong)UIButton *editionButton;
@property(nonatomic,strong)UIButton *agreementBtn;
@property(nonatomic,strong)UILabel *comLab;
@property(nonatomic,strong)UILabel *rightLab;
@property(nonatomic,strong)UILabel *renewLab;
@property(nonatomic,strong)UIImageView *triangleImg;
@end

@implementation ETAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"关于易转";
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.view addSubview:self.yizhuanImg];
    [self.view addSubview:self.editionLab];
    [self.view addSubview:self.editionButton];
    [self.view addSubview:self.agreementBtn];
    [self.view addSubview:self.comLab];
    [self.view addSubview:self.rightLab];
    [self.editionButton addSubview:self.renewLab];
    [self.editionButton addSubview:self.triangleImg];
    [self.yizhuanImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(86);
        make.left.mas_equalTo(105);
        make.right.mas_equalTo(-105);
        make.height.mas_equalTo(59);
    }];
    
    [self.editionLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(161);
        make.left.mas_equalTo(146);
        make.right.mas_equalTo(-146);
        make.height.mas_equalTo(24);
    }];
    
    [self.editionButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(224);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(49);
    }];
    
    [self.agreementBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(356);
        make.left.mas_equalTo(52);
        make.right.mas_equalTo(-53);
        make.height.mas_equalTo(18);
    }];
    
    [self.comLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(386);
        make.left.mas_equalTo(129);
        make.right.mas_equalTo(-130);
        make.height.mas_equalTo(18);
    }];
    
    [self.rightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(402);
        make.left.mas_equalTo(39);
        make.right.mas_equalTo(-40);
        make.height.mas_equalTo(18);
    }];
    
    [self.renewLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.left.mas_equalTo(14);
        make.size.mas_equalTo(CGSizeMake(65, 21));
    }];
    
    [self.triangleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.right.mas_equalTo(-12);
        make.size.mas_equalTo(CGSizeMake(10, 20));
    }];
    
}

- (UIImageView *)yizhuanImg {
    if (!_yizhuanImg) {
        _yizhuanImg=[[UIImageView alloc]init];
        _yizhuanImg.image=[UIImage imageNamed:@"易转logo-1"];
    }
    return _yizhuanImg;
}

- (UILabel *)editionLab {
    if (!_editionLab) {
        _editionLab=[[UILabel alloc]init];
        _editionLab.text=@"易转2.0.0";
        _editionLab.textColor=[UIColor blackColor];
    }
    return _editionLab;
}

- (UIButton *)editionButton {
    if (!_editionButton) {
        _editionButton=[[UIButton alloc]init];
        _editionButton.backgroundColor=[UIColor whiteColor];
        
    }
    return _editionButton;
}

- (UIButton *)agreementBtn {
    if (!_agreementBtn) {
        _agreementBtn=[[UIButton alloc]init];
//        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"《软件许可及服务协议》 和 《隐私保护指引》"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0]}];
        NSString*str=[[NSString alloc]initWithFormat:@"《软件许可及服务协议》 和 《隐私保护指引》"];
        [_agreementBtn setTitle:[NSString stringWithFormat:@"%@", str] forState:UIControlStateNormal];
        _agreementBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        [_agreementBtn setTitleColor:[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0] forState:UIControlStateNormal];
        _agreementBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _agreementBtn.alpha = 1.0;
    }
    return _agreementBtn;
}

- (UILabel *)comLab {
    if (!_comLab) {
        _comLab=[[UILabel alloc]init];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"易转公司  版权所有"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
        
        _comLab.attributedText = string;
        _comLab.textAlignment = NSTextAlignmentLeft;
        _comLab.alpha = 1.0;
    }
    return _comLab;
}

- (UILabel *)rightLab {
    if (!_rightLab) {
        _rightLab=[[UILabel alloc]init];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"Copyright 2019 Copyright 2019 Copyright 2019 .."attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
        
        _rightLab.attributedText = string;
        _rightLab.textAlignment = NSTextAlignmentLeft;
        _rightLab.alpha = 1.0;
    }
    return _rightLab;
}

- (UILabel *)renewLab {
    if (!_renewLab) {
        _renewLab=[[UILabel alloc]init];
        _renewLab.text=@"版本更新";
        _renewLab.textColor=[UIColor blackColor];
        _renewLab.font=[UIFont systemFontOfSize:15];
    }
    return _renewLab;
}

- (UIImageView *)triangleImg {
    if (!_triangleImg) {
        _triangleImg=[[UIImageView alloc]init];
        _triangleImg.image=[UIImage imageNamed:@"进入"];
    }
    return _triangleImg;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
