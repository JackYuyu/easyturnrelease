//
//  ETMineVIew.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/19.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import "ETMineVIew.h"
#import "Masonry.h"
#import "WrongSpeakBtn.h"
#import "ETPutViewController.h"
#import "UserMegViewController.h"
#import "UserInfoModel.h"
#import "FSBaseModel.h"
#define kItemHeight 80


@interface FSItemButton : UIButton
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *coloe;

@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIImageView *logoView;

@end

@implementation  FSItemButton

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        self.logoView = [[UIImageView alloc] init];
        [self addSubview:self.logoView];
        
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.font = [UIFont systemFontOfSize:14];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.textLabel.textColor = [UIColor blackColor];
        [self addSubview:self.textLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat space = 10;
    
    CGFloat h1 = self.width * 0.4;
    CGFloat w1 = h1;
    CGFloat x1 = (self.width - w1) / 2;
    self.logoView.frame = CGRectMake(x1, space, w1, h1);
    
    CGFloat h2 = 20;
    CGFloat y2 = self.logoView.maxY + 5;
    self.textLabel.frame = CGRectMake(0, y2, self.width, h2);
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
    self.textLabel.text = title;
}

- (void)setUrl:(NSString *)url {
    _url = url;
    
    if ([url containsString:@"http"]) {
        [self.logoView sd_setImageWithURL:[NSURL URLWithString:url]];
    }else {
        self.logoView.image = [UIImage imageNamed:url];
    }
}


@end
@implementation ETMineVIew

- (void)handleCellTapAction:(UITapGestureRecognizer *)selfTap{
    
    
    
    CGPoint selectPoint = [selfTap locationInView:self];
    
    NSLog(@"%@",[NSValue valueWithCGPoint:selectPoint]);
    
    //CGRectContainsPoint(CGRect rect, <#CGPoint point#>)判断某个点是否包含在某个CGRect区域内
    CGFloat height = kItemHeight;
    CGFloat width = Screen_Width / 4;
    for (UIButton* b in self.buttons) {
        CGRect a=CGRectMake(b.origin.x, 197-40, width, height);
        
        if (CGRectContainsPoint(a, selectPoint)) {
            NSLog(@"%i",b.tag);
            int a = b.tag;
            if(a==0)
                [self agreementBtnClick1:b ];
            else if (a==1)
                [self agreementBtnClick2:b ];
            else if (a==2)
                [self agreementBtnClick3:b ];
            else
                [self qiyetishi:b];
        }
    }
}
-(void)subClassDidEvent:(UIButton*)sender
{
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        NSArray* customImages = @[[FSBaseModel initImage:@"我的_分组5" title:@"身份认证"],
                          [FSBaseModel initImage:@"我的_分组6" title:@"我的收藏"],
                          [FSBaseModel initImage:@"我的_分组7" title:@"账户余额"],
                          [FSBaseModel initImage:@"我的 copy 3_分组 2" title:@"我的企业"]];
        
        CGFloat height = self.frame.size.height;
        CGFloat width = Screen_Width / 4;
        UIView* uv=[[UIView alloc] initWithFrame:CGRectMake(0, 163, Screen_Width, 80)];
        UITapGestureRecognizer* rec=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleCellTapAction:)];
        [uv addGestureRecognizer:rec];
        self.buttons=[[NSMutableArray alloc] init];
        [customImages enumerateObjectsUsingBlock:^(FSBaseModel * _Nonnull object, NSUInteger idx, BOOL * _Nonnull stop) {
            FSBaseModel *mode = customImages[idx];
            FSItemButton *button = [FSItemButton new];
            button.url = mode.image;
            button.title = mode.title;
            button.frame = CGRectMake(width * idx, 0, width, height);
            [uv addSubview:button];
            button.tag = idx;
            [self.buttons addObject: button];
//            button.userInteractionEnabled=YES;
            [button addTarget:self action:@selector(subClassDidEvent:) forControlEvents:UIControlEventTouchUpInside];
        }];
        [self addSubview:uv];
        
        [self addSubview:self.img];
        [self.img addSubview:self.photoImg];
        [self.photoImg addSubview:self.bianjiImg];
        [self.img addSubview:self.nameLab];
        [self.img addSubview:self.companyLab];
        [self.img addSubview:self.cImg];
        [self.img addSubview:self.timeLab];
        [self.img addSubview:self.signBtn];
        [self.img addSubview:self.putBtn];
        [self.img addSubview:self.qifuheImg];
//        [self addSubview:self.entpriseImg];
        [self addSubview:self.renzhengLab];
        [self addSubview:self.huiyuanBtn];
        [self addSubview:self.memberv];
        [self.memberv addSubview:self.memberi];
        [self.memberv  addSubview:self.memberLab];
        [self addSubview:self.statusv];
        [self.statusv addSubview:self.statusi];
        [self.statusv addSubview:self.statusLab];
        
        [self addSubview:self.meinv];
        [self.meinv addSubview:self.meini];
        [self.meinv addSubview:self.meinLab];
        
        [self addSubview:self.accountv];
        self.memberv.hidden=YES;
        self.statusv.hidden=YES;
        self.meinv.hidden=YES;
        self.accountv.hidden=YES;

        [self.accountv addSubview:self.accounti];
        [self.accountv addSubview:self.accountLab];
        [self addSubview:self.grayView1];
        [self addSubview:self.orangeView];
        [self addSubview:self.surLab];
        [self addSubview:self.numLab];
        [self addSubview:self.speedLab];
        [self addSubview:self.buyBtn];
        [self addSubview:self.grayView2];
        [self addSubview:self.sellBtn];
        [self addSubview:self.xiaobiaoView];
        [self addSubview:self.giveBtn];
        [self addSubview:self.wantBtn];
        [self addSubview:self.wholeBtn];
        [self addSubview:self.sellBtn];
        [self addSubview:self.giveBtn];
        [self addSubview:self.wantBtn];
        [self addSubview:self.wholeBtn];
        [_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(33);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(-0);
            make.height.mas_equalTo(164);
        }];
        
        [_entpriseImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(89);
            make.left.mas_equalTo(240);
            make.size.mas_equalTo(CGSizeMake(20, 20));
        }];
        
        [_renzhengLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(110);
            make.left.mas_equalTo(110);
            make.size.mas_equalTo(CGSizeMake(100,16));
        }];
        
        [_huiyuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(100);
            make.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(89,33));
        }];
        
        [_photoImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(24);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(80, 80));
        }];
        
        [_bianjiImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(65);
            make.right.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(15, 15));
        }];
        
        [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(34);
            make.left.equalTo(self.photoImg.mas_right).offset(15);
            make.right.mas_equalTo(-100);
            make.height.mas_equalTo(21);
        }];
        
        [_qifuheImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLab);
            make.left.equalTo(self.nameLab.mas_right).offset(8);
            make.size.mas_equalTo(CGSizeMake(27, 12));
        }];
        
        [_companyLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLab.mas_bottom).offset(3);
            make.left.equalTo(self.nameLab);
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(16);
        }];
        
//        [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.companyLab.mas_bottom).offset(3);
//            make.left.equalTo(self.companyLab.mas_right).offset(10);
//            make.size.mas_equalTo(CGSizeMake(100, 19));
//        }];
        
        [_memberv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(163);
            make.left.mas_equalTo(25);
             make.right.mas_equalTo(_statusv.mas_left).offset(-23);
            make.size.mas_equalTo(CGSizeMake(61, 70));
        }];
        
        [_memberi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(40);
        }];
        
        [_memberLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(21);
        }];
        

        [_statusv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(163);
            make.left.mas_equalTo(_memberv.mas_right).offset(30);
            make.right.mas_equalTo(_meinv.mas_left).offset(-23);
            make.size.mas_equalTo(CGSizeMake(61, 70));
        }];
        
        [_statusi mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(40);
        }];
        
        [_statusLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(21);
        }];
        
        [_meinv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(163);
            make.right.mas_equalTo(_accountv.mas_left).offset(-23);
            make.size.mas_equalTo(CGSizeMake(61, 70));
        }];
        
        [_meini mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(40);
            make.size.mas_equalTo(_memberi);
        }];
        
        [_meinLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(21);
        }];
        
        if (IS_IPHONE_Xs_Max) {
            [_accountv mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(163);
                make.left.mas_equalTo(292);
                make.size.mas_equalTo(CGSizeMake(59, 70));
            }];
        }
        else{
        [_accountv mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(163);
            make.left.mas_equalTo(282);
            make.size.mas_equalTo(CGSizeMake(59, 70));
        }];
        }
        
        [_accounti mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(40);
        }];
        
        if (IS_IPHONE_Xs_Max) {
            [_accountLab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(50);
                make.left.mas_equalTo(0);
                make.right.mas_equalTo(60);
                make.height.mas_equalTo(21);
            }];
        }
        else{
        [_accountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(50);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(50);
            make.height.mas_equalTo(21);
        }];
        }
        
        [_grayView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(253);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(Screen_Width, 10));
        }];
        
        [_orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(278);
            make.left.mas_equalTo(40);
            make.size.mas_equalTo(CGSizeMake(82,82));
        }];
        
        [_surLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(304);
            make.left.mas_equalTo(45);
            make.size.mas_equalTo(CGSizeMake(72, 17));
        }];
        
        [_numLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(316);
            make.centerX.mas_equalTo(_orangeView).offset(10);
            make.size.mas_equalTo(CGSizeMake(50, 33));
        }];
        
        [_speedLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(278);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(195, 38));
        }];
        
        [_buyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(335);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(195, 35));
        }];
        
        [_grayView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(385);
            make.left.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(Screen_Width, 10));
        }];
        
        [_sellBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(410);
            make.left.mas_equalTo(45);
            make.size.mas_equalTo(CGSizeMake(32, 22));
        }];
        
        [_giveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(410);
            make.left.mas_equalTo(130);
            make.size.mas_equalTo(CGSizeMake(32, 22));
        }];
        
        
        [_wantBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(410);
            make.right.mas_equalTo(-157);
            make.size.mas_equalTo(CGSizeMake(32, 22));
        }];
        
        [_wholeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(410);
            make.right.mas_equalTo(-44);
            make.size.mas_equalTo(CGSizeMake(65, 22));
        }];
        
        [self postUI];

    }
    return self;
}
#pragma mark - 用户信息
- (void)postUI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    if (![user objectForKey:@"uid"]) {
        return;
    }
    NSDictionary *params = @{
                             @"uid" : [user objectForKey:@"uid"]
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"user/info"] params:params success:^(id responseObj) {
        if ([MySingleton filterNull:responseObj[@"data"]]) {
            
        
        //        _products=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        UserInfoModel* info=[UserInfoModel mj_objectWithKeyValues:responseObj[@"data"][@"userInfo"]];
        _nameLab.text = info.name;
        [UserInfoModel saveUserInfoModel:info];
        
        
        if (info.refreshCount) {
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:info.refreshCount attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 23],NSForegroundColorAttributeName: [UIColor colorWithRed:82/255.0 green:74/255.0 blue:3/255.0 alpha:1.0]}];
            _numLab.attributedText = string;
            
            
        }
        id num=info.vip;
        if ([num isKindOfClass:[NSNull class]]||num==nil) {
            info.vip=@"您还不是易转会员";
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:info.vip attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0]}];
            _companyLab.attributedText=string;
              [_huiyuanBtn setImage:[UIImage imageNamed:@"我的 copy 3_分组 12"] forState:UIControlStateNormal];
            _timeLab.text=@"";
        }else{
            info.vip=@"VIP到期时间";
          
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[info.vipExpiryDate longLongValue]/1000];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateStr = [formatter stringFromDate:date];
            _companyLab.text=[NSString stringWithFormat:@"%@ %@",info.vip,dateStr];
              [_huiyuanBtn setImage:[UIImage imageNamed:@"WechatIMG2"] forState:UIControlStateNormal];
        }
        if ([info.isChecked isEqualToString:@"5"]) {
            _renzhengLab.text=@"企业认证";
        }else if ([info.isChecked isEqualToString:@"4"]) {
            _renzhengLab.text=@"企业认证";
        }else if ([info.isChecked isEqualToString:@"1"]) {
            _renzhengLab.text=@"个人认证";
        }
        
        //        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString: "attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:218/255.0 green:218/255.0 blue:218/255.0 alpha:1.0]}];
        //        _companyLab.attributedText = string;
        for (NSDictionary* prod in responseObj[@"data"]) {
            //            ETProductModel* p=[ETProductModel mj_objectWithKeyValues:prod];
            //            [_products addObject:p];
        }
        NSLog(@"");
            //头像
            NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:@"port"];
            if(info.portrait)
            {
                [_photoImg sd_setImageWithURL:info.portrait];
                NSURL *url = [NSURL URLWithString:info.portrait];
                
                [MySingleton sharedMySingleton].port = [UIImage imageWithData:[NSData dataWithContentsOfURL:url]];
            }

            else
                _photoImg.image=[UIImage imageNamed:@"我的_Bitmap"];
        
        }
        
        
        
        //        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (UIImageView *)img {
    if (!_img) {
        _img=[[UIImageView alloc]init];
        _img.image=[UIImage imageNamed:@""];
        _img.userInteractionEnabled=YES;
        
    }
    return _img;
}

- (UIImageView *)photoImg {
    if (!_photoImg) {
        _photoImg=[[UIImageView alloc]init];
//        _photoImg.image=[UIImage imageNamed:@"我的_Bitmap"];
        _photoImg.userInteractionEnabled=YES;
//        _photoImg.layer.borderWidth=1;
        _photoImg.layer.cornerRadius = 6;
        _photoImg.layer.masksToBounds=YES;
        UITapGestureRecognizer *gr = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(putAgreementBtnC:)];
        gr.numberOfTapsRequired = 1;
        gr.numberOfTouchesRequired = 1;
        [_photoImg addGestureRecognizer:gr ];
    }
    return _photoImg;
}

-(UIImageView *)bianjiImg {
    if (!_bianjiImg) {
        _bianjiImg=[[UIImageView alloc]init];
        _bianjiImg.image=[UIImage imageNamed:@"我的 copy 3_编辑"];
    }
    return _bianjiImg;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab=[[UILabel alloc]init];
        _nameLab.numberOfLines = 0;
        _nameLab.textColor= [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
//        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"易转用户007"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size:18],NSForegroundColorAttributeName: [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]}];
        
//        _nameLab.attributedText = string;
        _nameLab.textAlignment = NSTextAlignmentLeft;
        _nameLab.alpha = 1.0;
    }
    return _nameLab;
}

- (UIImageView *)qifuheImg {
    if (!_qifuheImg) {
        _qifuheImg=[[UIImageView alloc]init];
        _qifuheImg.image=[UIImage imageNamed:@"我的_企服者"];
        
    }
    return _qifuheImg;
}

- (UILabel *)renzhengLab {
    if (!_renzhengLab) {
        _renzhengLab=[[UILabel alloc]init];
        
        _renzhengLab.text=@"未认证";
        _renzhengLab.font=[UIFont systemFontOfSize:12];
        _renzhengLab.textColor=[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    }
    return _renzhengLab;
}

-(UIButton *)huiyuanBtn {
    if (!_huiyuanBtn) {
        _huiyuanBtn=[[UIButton alloc]init];
        [_huiyuanBtn addTarget:self action:@selector(agreementBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _huiyuanBtn;
}

- (UILabel *)companyLab {
    if (!_companyLab) {
        _companyLab=[[UILabel alloc]init];
        _companyLab.textColor = kACColorRGB(150, 150, 150);
        _companyLab.font = kFontSize(12);
        _companyLab.textAlignment = NSTextAlignmentLeft;
    }
    return _companyLab;
}

- (UIImageView *)cImg {
    if (!_cImg) {
        _cImg=[[UIImageView alloc]init];
//        _cImg.image=[UIImage imageNamed:@"我的_企业认证"];
        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
        [_cImg addGestureRecognizer:singleTap];
    }
    return _cImg;
}

-(UILabel *)timeLab {
    if (!_timeLab) {
        _timeLab=[[UILabel alloc]init];
        _timeLab.text=@"2019-09-18";
        _timeLab.font=[UIFont systemFontOfSize:12];
        _timeLab.textColor=[UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    }
    return _timeLab;
}

- (void)onClickImage:(UIImageView*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(imgjumpWeb:)]) {
        [self.delegate imgjumpWeb:sender];
    }
}
- (UIImageView *)entpriseImg {
    if (!_entpriseImg) {
        _entpriseImg=[[UIImageView alloc]init];
                _entpriseImg.image=[UIImage imageNamed:@"我的_企业认证"];
        _entpriseImg.hidden=YES;
//        UITapGestureRecognizer *singleTap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickImage:)];
//        [_entpriseImg addGestureRecognizer:singleTap];
    }
    return _entpriseImg;
}

- (UIButton *)signBtn {
    if (!_signBtn) {
        _signBtn=[[UIButton alloc]init];
        _signBtn.layer.borderWidth=2;
        _signBtn.layer.borderColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _signBtn.layer.cornerRadius = 12;
        _signBtn.titleLabel.font=[UIFont systemFontOfSize:13];
        [_signBtn setTitle:@"签到" forState:UIControlStateNormal];
        [_signBtn setTitle:@"已签到" forState:UIControlStateSelected];
        [_signBtn addTarget:self action:@selector(aaa:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _signBtn;
}

- (void)aaa:(UIButton*)sender {
//        [MBProgressHUD showMBProgressHud:self withText:@"您今天已签到！" withTime:1];
    if (sender.selected==YES) {
        sender.selected=NO;
    }else {
        [self PostUI:_signBtn];
        sender.selected=NO;
    }
 
  
   
//        [sender endEditing:NO];
}

- (void)PostUI:(UIButton*)head {
    NSDictionary *params = @{
                             
                             };
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    [HttpTool get:[NSString stringWithFormat:@"user/isSign"] params:params success:^(NSDictionary *response) {
      
        NSString* a=response[@"data"][@"status"];
        [self PostSignUI:_signBtn];
        if ([a isEqualToString:@"1"]) {
                 [MBProgressHUD showMBProgressHud:self withText:@"您今天已签到！" withTime:1];
                NSLog(@"1");
                [_signBtn endEditing:NO];
            [_signBtn setTitle:@"已签到" forState:UIControlStateNormal];

        }else if ([a isEqualToString:@"0"]) {
              NSLog(@"2");
        }
        
    } failure:^(NSError *error) {
         NSLog(@"0");
        NSLog(@"失败");
    }];

}


- (void)PostSignUI:(NSString*)head {
    NSDictionary *params = @{
                             };
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    [HttpTool put:[NSString stringWithFormat:@"user/sign"] params:params success:^(NSDictionary *response) {
        NSString* a=response[@"data"][@"status"];
        
         [MBProgressHUD showMBProgressHud:self withText:@"您今天已签到！" withTime:1];
        [_signBtn endEditing:NO];
    } failure:^(NSError *error) {
        NSLog(@"失败");
    }];
    
}
- (UIButton *)putBtn {
    if (!_putBtn) {
        _putBtn=[[UIButton alloc]init];
        [_putBtn setImage:[UIImage imageNamed:@"我的_设置"] forState:UIControlStateNormal];
        [_putBtn addTarget:self action:@selector(putAgreementBtnC:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _putBtn;
}

- (void)putAgreementBtnC:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(putjumpWeb:)]) {
        [self.delegate putjumpWeb:sender];
    }
}


- (UIButton *)memberv {
    if (!_memberv) {
        _memberv=[[UIButton alloc]init];
         [_memberv addTarget:self action:@selector(agreementBtnClick1:) forControlEvents:UIControlEventTouchUpInside];
       
    }
    return _memberv;
}

- (UIImageView *)memberi
{
    if (!_memberi) {
        _memberi=[[UIImageView alloc]init];
        _memberi.image=[UIImage imageNamed:@"我的_分组5"];
    }
    return _memberi;
}

- (UILabel *)memberLab
{
    if (!_memberLab) {
        _memberLab=[[UILabel alloc]init];
        _memberLab.text=@"身份认证";
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"身份认证"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
        
        _memberLab.attributedText = string;
        _memberLab.textAlignment = NSTextAlignmentLeft;
        _memberLab.alpha = 1.0;
    }
    return _memberLab;
}

- (UIButton *)statusv {
    if (!_statusv) {
        _statusv=[[UIButton alloc]init];
         [_statusv addTarget:self action:@selector(agreementBtnClick2:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _statusv;
}

- (UIImageView *)statusi
{
    if (!_statusi) {
        _statusi=[[UIImageView alloc]init];
        _statusi.image=[UIImage imageNamed:@"我的_分组6"];
    }
    return _statusi;
}

- (UILabel *)statusLab
{
    if (!_statusLab) {
        _statusLab=[[UILabel alloc]init];
        _statusLab.text=@"我的收藏";
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"我的收藏"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
        
        _statusLab.attributedText = string;
        _statusLab.textAlignment = NSTextAlignmentLeft;
        _statusLab.alpha = 1.0;
    }
    return _statusLab;
}

- (UIButton *)meinv {
    if (!_meinv) {
        _meinv=[[UIButton alloc]init];
         [_meinv addTarget:self action:@selector(agreementBtnClick3:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _meinv;
}

- (UIImageView *)meini
{
    if (!_meini) {
        _meini=[[UIImageView alloc]init];
        _meini.image=[UIImage imageNamed:@"我的_分组7"];
    }
    return _meini;
}

- (UILabel *)meinLab
{
    if (!_meinLab) {
        _meinLab=[[UILabel alloc]init];
        _meinLab.text=@"账户余额";
       NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"账户余额"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
        
        _meinLab.attributedText = string;
        _meinLab.textAlignment = NSTextAlignmentLeft;
        _meinLab.alpha = 1.0;
    }
    return _meinLab;
}

- (UIButton *)accountv {
    if (!_accountv) {
        _accountv=[[UIButton alloc]init];
        [_accountv addTarget:self action:@selector(qiyetishi:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _accountv;
}

- (UIImageView *)accounti
{
    if (!_accounti) {
        _accounti=[[UIImageView alloc]init];
        _accounti.image=[UIImage imageNamed:@"我的 copy 3_分组 2"];
    }
    return _accounti;
}

- (UILabel *)accountLab
{
    if (!_accountLab) {
        _accountLab=[[UILabel alloc]init];
        _accountLab.text=@"我的企业";
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"我的企业"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
        
        _accountLab.attributedText = string;
        _accountLab.textAlignment = NSTextAlignmentLeft;
        _accountLab.alpha = 1.0;
    }
    return _accountLab;
}

- (UIView *)grayView1
{
    if (!_grayView1) {
        _grayView1=[[UIView alloc]init];
        _grayView1.backgroundColor=[UIColor colorWithRed:230/242.0 green:230/242.0 blue:230/242.0 alpha:1.0];
        
    }
    return _grayView1;
}

- (UIView *)orangeView
{
    if (!_orangeView) {
        _orangeView=[[UIView alloc]init];
        _orangeView.layer.borderWidth = 4;
        _orangeView.layer.cornerRadius=41;
        _orangeView.layer.borderColor = [UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0].CGColor;
        
        _orangeView.layer.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0].CGColor;
    }
    return _orangeView;
}

- (UILabel *)surLab
{
    if (!_surLab) {
        _surLab=[[UILabel alloc]init];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"剩余刷新次数"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 12],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
        
        _surLab.attributedText = string;
        _surLab.textAlignment = NSTextAlignmentCenter;
        _surLab.alpha = 1.0;
    }
    return _surLab;
}

- (void)PostUI1:(NSString*)b {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"buy/getRefreshList"] params:params success:^(id responseObj) {
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (UILabel *)numLab
{
    if (!_numLab) {
        _numLab=[[UILabel alloc]init];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"10"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 23],NSForegroundColorAttributeName: [UIColor colorWithRed:82/255.0 green:74/255.0 blue:3/255.0 alpha:1.0]}];
        _numLab.attributedText = string;
        _numLab.textAlignment = NSTextAlignmentLeft;
        _numLab.alpha = 1.0;
        [self PostUI1:@"0"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.numLab reloadInputViews];
        });
    }
    return _numLab;
}

- (UILabel *)speedLab
{
    if (!_speedLab) {
        _speedLab=[[UILabel alloc]init];
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"每次刷新，您的商品都会更改排名提高曝光次数，提升卖出速度。"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13],NSForegroundColorAttributeName: [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0]}];
                                             
                                             _speedLab.attributedText = string;
                                             _speedLab.textAlignment = NSTextAlignmentLeft;
                                             _speedLab.alpha = 1.0;
        _speedLab.numberOfLines = 0;
    }
    return _speedLab;
}
-(UIButton *)buyBtn
{
    if (!_buyBtn) {
        _buyBtn=[[UIButton alloc]init];
        _buyBtn.layer.backgroundColor = [UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0].CGColor;
        _buyBtn.layer.cornerRadius = 18;
        [_buyBtn setTitle:@"购买刷新次数" forState:UIControlStateNormal];
        _buyBtn.titleLabel.font=[UIFont systemFontOfSize:15];
         [_buyBtn addTarget:self action:@selector(agreementBtnClick4:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _buyBtn;
}
//buy/getRefreshList
- (UIView *)grayView2 {
    if (!_grayView2) {
        _grayView2=[[UIView alloc]init];
        _grayView2.backgroundColor=[UIColor colorWithRed:230/242.0 green:230/242.0 blue:230/242.0 alpha:1.0];
        
        
    }
    return _grayView2;
}
- (UIButton *)sellBtn {
    if (!_sellBtn) {
        _sellBtn=[[UIButton alloc]init];
        _sellBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [_sellBtn setTitle:@"出售" forState:UIControlStateNormal];
        _sellBtn.selected=YES;
        _sellBtn.tag=1;
        [_sellBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sellBtn setTitleColor:[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0] forState:UIControlStateSelected];
        [_sellBtn addTarget:self action:@selector(a:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return _sellBtn;
}

- (UIButton *)giveBtn {
    if (!_giveBtn) {
        _giveBtn=[[UIButton alloc]init];
        _giveBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [_giveBtn setTitle:@"服务" forState:UIControlStateNormal];
        _giveBtn.tag=2;
        [_giveBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_giveBtn setTitleColor:[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0] forState:UIControlStateSelected];
        [_giveBtn addTarget:self action:@selector(a:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _giveBtn;
}

- (UIButton *)wantBtn {
    if (!_wantBtn) {
        _wantBtn=[[UIButton alloc]init];
        _wantBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [_wantBtn setTitle:@"求购" forState:UIControlStateNormal];
        _wantBtn.tag=3;
        [_wantBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_wantBtn setTitleColor:[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0] forState:UIControlStateSelected];
        [_wantBtn addTarget:self action:@selector(a:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wantBtn;
}

- (UIButton *)wholeBtn {
    if (!_wholeBtn) {
        _wholeBtn=[[UIButton alloc]init];
        _wholeBtn.titleLabel.font=[UIFont systemFontOfSize:15];
        [_wholeBtn setTitle:@"全部订单" forState:UIControlStateNormal];
        _wholeBtn.tag=4;
        [_wholeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_wholeBtn setTitleColor:[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0] forState:UIControlStateSelected];
        [_wholeBtn addTarget:self action:@selector(a:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _wholeBtn;
}

-(void)a:(UIButton*)sender {
    WrongSpeakBtn*btn=[[WrongSpeakBtn alloc]init];
    [btn setQJselected:NO];
    [btn layoutSubviews];
    if ([sender.titleLabel.text isEqualToString:@"出售"]) {
        if (self.block) {
            self.block(@"1");
            _sellBtn.selected=YES;
            _giveBtn.selected=NO;
            _wantBtn.selected=NO;
            _wholeBtn.selected=NO;
        }
    }
    if ([sender.titleLabel.text isEqualToString:@"服务"]) {
        if (self.block) {
            self.block(@"3");
            _sellBtn.selected=NO;
            _giveBtn.selected=YES;
            _wantBtn.selected=NO;
            _wholeBtn.selected=NO;
        }
    }
    if ([sender.titleLabel.text isEqualToString:@"求购"]) {
        if (self.block) {
            self.block(@"2");
            _sellBtn.selected=NO;
            _giveBtn.selected=NO;
            _wantBtn.selected=YES;
            _wholeBtn.selected=NO;
        }
    }
    if ([sender.titleLabel.text isEqualToString:@"全部订单"]) {
        if (self.block) {
            self.block(@"");
            _sellBtn.selected=NO;
            _giveBtn.selected=NO;
            _wantBtn.selected=NO;
            _wholeBtn.selected=YES;
        }
    }
    
    
}


- (void)qiyetishi:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(jumpWebVC5:)]) {
        [self.delegate jumpWebVC5:sender];
    }
}

- (void)agreementBtnClick:(UIButton*)sender
{
//    if ([MySingleton sharedMySingleton].review==1) {
//        UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"" message:@"该功能未开通" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
//        [alert show];
//        return;
//    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(jumpWebVC:)]) {
        [self.delegate jumpWebVC:sender];
    }
}

- (void)agreementBtnClick1:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(jumpWebVC1:)]) {
        [self.delegate jumpWebVC1:sender];
    }
}

- (void)agreementBtnClick2:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(jumpWebVC2:)]) {
        [self.delegate jumpWebVC2:sender];
    }
}

- (void)agreementBtnClick3:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(jumpWebVC3:)]) {
        [self.delegate jumpWebVC3:sender];
    }
}

- (void)agreementBtnClick4:(UIButton*)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(jumpWebVC4:)]) {
        [self.delegate jumpWebVC4:sender];
    }
}
@end
