//
//  ETEnterpriseServiceController.m
//  EasyTurn
//
//  Created by 程立 on 2019/7/18.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETEnterpriseServiceController.h"
#import "ETBusinessViewController.h"
#import "ETTaxationViewController.h"
#import "ETAdministrationViewController.h"
#import "ETFinancialViewController.h"
#import "ETIntelligenceViewController.h"
#import "ETPuzzleViewController.h"
#import "ETLawViewController.h"
#import "ETSynViewController.h"
#import "ETStillViewController.h"
@interface ETEnterpriseServiceController ()

@property (nonatomic,strong)UIImageView *topImg;
@property (nonatomic,strong)UILabel *topLab;
@property(nonatomic,strong) UIImageView *businessImg;
@property(nonatomic,strong) UIButton *businessBtn;
@property(nonatomic,strong) UIImageView *taxationImg;
@property(nonatomic,strong) UIButton *taxationBtn;
@property(nonatomic,strong) UIImageView *administrationImg;
@property(nonatomic,strong) UIButton *administrationBtn;
@property(nonatomic,strong) UIImageView *financialImg;
@property(nonatomic,strong) UIButton *financialBtn;
@property(nonatomic,strong) UIImageView *intelligenceImg;
@property(nonatomic,strong) UIButton *intelligenceBtn;
@property(nonatomic,strong) UIImageView *puzzleImg;
@property(nonatomic,strong) UIButton *puzzleBtn;
@property(nonatomic,strong) UIButton *lawBtn;
@property(nonatomic,strong) UIButton *synthesizeBtn;
@property(nonatomic,strong) UIButton *moreBtn;
@end

@implementation ETEnterpriseServiceController
- (void)viewWillAppear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:YES animated:TRUE];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:NO animated:TRUE];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title=@"企服者";
    //    self.navigationController.navigationBarHidden=YES;
    self.navigationController.navigationBar.barTintColor=[UIColor clearColor];
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    [self.view addSubview:self.topImg];
    
    [self.view addSubview:self.topLab];
    //    [self.businessBtn addSubview:self.businessImg];
    [self.view addSubview:self.businessBtn];
    //    [self.taxationBtn addSubview:self.taxationImg];
    [self.view addSubview:self.taxationBtn];
    //    [self.administrationBtn addSubview:self.administrationImg];
    [self.view addSubview:self.administrationBtn];
    //    [self.financialBtn addSubview:self.financialImg];
    [self.view addSubview:self.financialBtn];
    //    [self.intelligenceBtn addSubview:self.intelligenceImg];
    [self.view addSubview:self.intelligenceBtn];
    //    [self.puzzleBtn addSubview:self.puzzleImg];
    [self.view addSubview:self.puzzleBtn];
    [self.view addSubview:self.lawBtn];
    [self.view addSubview:self.synthesizeBtn];
    [self.view addSubview:self.moreBtn];
    
    //    [self.view addSubview:self.topLab];
    //    [self.view addSubview:self.topImg];
    if (IS_IPHONE_Xs_Max) {
        [_topImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(TopHeight-31);
            make.left.mas_equalTo(21);
            make.size.mas_equalTo(CGSizeMake(80, 25));
        }];
        
        [_topLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.topImg.mas_bottom).with.offset(20);
            make.left.mas_equalTo(21);
            make.size.mas_equalTo(CGSizeMake(300, 17));
        }];

        [_businessBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kStatusBarHeight+20+80);
            make.left.mas_equalTo(16);
            make.size.mas_equalTo(CGSizeMake(200, 112));
        }];
        
        [_taxationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kStatusBarHeight+20+80);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(200, 112));
        }];
        
        [_administrationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kStatusBarHeight+20+180);
            make.left.mas_equalTo(16);
            make.size.mas_equalTo(CGSizeMake(200, 112));
        }];
        
        [_financialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kStatusBarHeight+20+180);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(200, 112));
        }];
        
        [_intelligenceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kStatusBarHeight+20+280);
            make.left.mas_equalTo(16);
            make.size.mas_equalTo(CGSizeMake(200, 112));
        }];

        [_puzzleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kStatusBarHeight+20+280);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(200, 112));
        }];
        
        [_lawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kStatusBarHeight+20+380);
            make.left.mas_equalTo(16);
            make.size.mas_equalTo(CGSizeMake(200, 112));
        }];
        
        [_synthesizeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kStatusBarHeight+20+380);
            make.right.mas_equalTo(-15);
            make.size.mas_equalTo(CGSizeMake(200, 112));
        }];
        
        [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kStatusBarHeight+20+480);
            make.left.mas_equalTo(16);
            make.size.mas_equalTo(CGSizeMake(200, 112));
        }];
    }
    else {
    [_topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(TopHeight-31);
        make.left.mas_equalTo(21);
        make.size.mas_equalTo(CGSizeMake(70, 20));
    }];
    
    [_topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImg.mas_bottom).with.offset(10);
        make.left.mas_equalTo(21);
        make.size.mas_equalTo(CGSizeMake(260, 17));
    }];
    
    
    
    //    [_businessImg mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.mas_equalTo(26);
    //        make.left.mas_equalTo(35);
    //        make.right.mas_equalTo(-35);
    //        make.height.mas_equalTo(70);
    //    }];
    
    [_businessBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kStatusBarHeight+20+50);
        make.left.mas_equalTo(36);
        make.size.mas_equalTo(CGSizeMake(150, 72));
    }];
    //    [_taxationImg mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.mas_equalTo(26);
    //        make.left.mas_equalTo(35);
    //        make.right.mas_equalTo(-35);
    //        make.height.mas_equalTo(70);
    //    }];
    
    [_taxationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kStatusBarHeight+20+50);
        make.right.mas_equalTo(-35);
        make.size.mas_equalTo(CGSizeMake(150, 72));
    }];
    
    //    [_administrationImg mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.mas_equalTo(32);
    //        make.left.mas_equalTo(20);
    //        make.right.mas_equalTo(-20);
    //        make.height.mas_equalTo(70);
    //    }];
    
    [_administrationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kStatusBarHeight+20+150);
        make.left.mas_equalTo(36);
        make.size.mas_equalTo(CGSizeMake(150, 72));
    }];
    
    //    [_financialImg mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.mas_equalTo(32);
    //        make.left.mas_equalTo(35);
    //        make.right.mas_equalTo(-35);
    //        make.height.mas_equalTo(70);
    //    }];
    
    [_financialBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kStatusBarHeight+20+150);
        make.right.mas_equalTo(-35);
        make.size.mas_equalTo(CGSizeMake(150, 72));
    }];
    
    
    //    [_intelligenceImg mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.mas_equalTo(26);
    //        make.left.mas_equalTo(35);
    //        make.right.mas_equalTo(-35);
    //        make.height.mas_equalTo(70);
    //    }];
    
    [_intelligenceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kStatusBarHeight+20+250);
        make.left.mas_equalTo(36);
        make.size.mas_equalTo(CGSizeMake(150, 72));
    }];
    
    //    [_puzzleImg mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.mas_equalTo(26);
    //        make.left.mas_equalTo(35);
    //        make.right.mas_equalTo(-35);
    //        make.height.mas_equalTo(70);
    //    }];
    
    [_puzzleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kStatusBarHeight+20+250);
        make.right.mas_equalTo(-35);
        make.size.mas_equalTo(CGSizeMake(150, 72));
    }];
    
    [_lawBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kStatusBarHeight+20+350);
        make.left.mas_equalTo(36);
        make.size.mas_equalTo(CGSizeMake(150, 72));
    }];
    
    [_synthesizeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kStatusBarHeight+20+350);
        make.right.mas_equalTo(-35);
        make.size.mas_equalTo(CGSizeMake(150, 72));
    }];
    
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kStatusBarHeight+20+450);
        make.left.mas_equalTo(36);
        make.size.mas_equalTo(CGSizeMake(150, 72));
    }];
    }
    
}

-(UIImageView *)topImg {
    if (!_topImg) {
        _topImg=[[UIImageView alloc]init];
        _topImg.image=[UIImage imageNamed:@"企服者-修改_分组"];
    }
    return _topImg;
}

- (UILabel *)topLab {
    if (!_topLab) {
        _topLab=[[UILabel alloc]init];
        _topLab.text=@"服务有专攻-向中小企业提供专项服务人员";
        _topLab.textColor=[self colorWithHexString:@"#6B4226" alpha:1.0];
        _topLab.font=[UIFont systemFontOfSize:13];
    }
    return _topLab;
}
- (UIColor *)colorWithHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    hexString = [hexString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    hexString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    hexString = [hexString stringByReplacingOccurrencesOfString:@"0x" withString:@""];
    NSRegularExpression *RegEx = [NSRegularExpression regularExpressionWithPattern:@"^[a-fA-F|0-9]{6}$" options:0 error:nil];
    NSUInteger match = [RegEx numberOfMatchesInString:hexString options:NSMatchingReportCompletion range:NSMakeRange(0, hexString.length)];
    
    if (match == 0) {return [UIColor clearColor];}
    
    NSString *rString = [hexString substringWithRange:NSMakeRange(0, 2)];
    NSString *gString = [hexString substringWithRange:NSMakeRange(2, 2)];
    NSString *bString = [hexString substringWithRange:NSMakeRange(4, 2)];
    unsigned int r, g, b;
    BOOL rValue = [[NSScanner scannerWithString:rString] scanHexInt:&r];
    BOOL gValue = [[NSScanner scannerWithString:gString] scanHexInt:&g];
    BOOL bValue = [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    if (rValue && gValue && bValue) {
        return [UIColor colorWithRed:((float)r/255.0f) green:((float)g/255.0f) blue:((float)b/255.0f) alpha:alpha];
    } else {
        return [UIColor clearColor];
    }
}
//- (UIImageView *)businessImg {
//    if (!_businessImg) {
//        _businessImg=[[UIImageView alloc]init];
//        _businessImg.image=[UIImage imageNamed:@"企服者_分组 2"];
//    }
//    return _businessImg;
//}

- (UIButton *)businessBtn {
    if (!_businessBtn) {
        _businessBtn=[[UIButton alloc]init];
        [_businessBtn setImage:[UIImage imageNamed:@"企服者-修改_分组 2"] forState:UIControlStateNormal];
        //        _businessBtn.layer.cornerRadius=10;
        //        _businessBtn.backgroundColor=[UIColor whiteColor];
        [_businessBtn addTarget:self action:@selector(financialTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _businessBtn;
}

- (void)businessTouch {
    [self.navigationController pushViewController:[[ETBusinessViewController alloc]init] animated:YES];
}
//- (UIImageView *)taxationImg {
//    if (!_taxationImg) {
//        _taxationImg=[[UIImageView alloc]init];
//        _taxationImg.image=[UIImage imageNamed:@"企服者_分组 3"];
//    }
//    return _taxationImg;
//}

- (UIButton *)taxationBtn {
    if (!_taxationBtn) {
        _taxationBtn=[[UIButton alloc]init];
        [_taxationBtn setImage:[UIImage imageNamed:@"企服者-修改_分组 3"] forState:UIControlStateNormal];
        //        _taxationBtn.layer.cornerRadius=10;
        //        _taxationBtn.backgroundColor=[UIColor whiteColor];
        [_taxationBtn addTarget:self action:@selector(taxationTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _taxationBtn;
}

- (void)taxationTouch {
    ETTaxationViewController*taxVC=[[ETTaxationViewController alloc]init];
    [self.navigationController pushViewController:taxVC animated:YES];
}

//- (UIImageView *)administrationImg {
//    if (!_administrationImg) {
//        _administrationImg=[[UIImageView alloc]init];
//        _administrationImg.image=[UIImage imageNamed:@"企服者_分组 4"];
//    }
//    return _administrationImg;
//}

- (UIButton *)administrationBtn {
    if (!_administrationBtn) {
        _administrationBtn=[[UIButton alloc]init];
        [_administrationBtn setImage:[UIImage imageNamed:@"企服者-修改_分组 4"] forState:UIControlStateNormal];
        //        _administrationBtn.layer.cornerRadius=10;
        //        _administrationBtn.backgroundColor=[UIColor whiteColor];
        [_administrationBtn addTarget:self action:@selector(administrationTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _administrationBtn;
}

- (void)administrationTouch {
    ETAdministrationViewController*admVC=[[ETAdministrationViewController alloc]init];
    [self.navigationController pushViewController:admVC animated:YES];
}
//- (UIImageView *)financialImg {
//    if (!_financialImg) {
//        _financialImg=[[UIImageView alloc]init];
//        _financialImg.image=[UIImage imageNamed:@"企服者_分组 5"];
//    }
//    return _financialImg;
//}

- (UIButton *)financialBtn {
    if (!_financialBtn) {
        _financialBtn=[[UIButton alloc]init];
        [_financialBtn setImage:[UIImage imageNamed:@"企服者-修改_分组 5"] forState:UIControlStateNormal];
        //        _financialBtn.layer.cornerRadius=10;
        //        _financialBtn.backgroundColor=[UIColor whiteColor];
        [_financialBtn addTarget:self action:@selector(businessTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _financialBtn;
}

- (void)financialTouch {
    ETFinancialViewController*finVC=[[ETFinancialViewController alloc]init];
    [self.navigationController pushViewController:finVC animated:YES];
}
//- (UIImageView *)intelligenceImg {
//    if (!_intelligenceImg) {
//        _intelligenceImg=[[UIImageView alloc]init];
//        _intelligenceImg.image=[UIImage imageNamed:@"企服者_分组 7"];
//    }
//    return _intelligenceImg;
//}

- (UIButton *)intelligenceBtn {
    if (!_intelligenceBtn) {
        _intelligenceBtn=[[UIButton alloc]init];
        [_intelligenceBtn setImage:[UIImage imageNamed:@"企服者-修改_分组 6"] forState:UIControlStateNormal];
        //        _intelligenceBtn.layer.cornerRadius=10;
        //        _intelligenceBtn.backgroundColor=[UIColor whiteColor];
        [_intelligenceBtn addTarget:self action:@selector(intelligenceTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _intelligenceBtn;
}

- (void)intelligenceTouch {
    ETIntelligenceViewController*intVC=[[ETIntelligenceViewController alloc]init];
    [self.navigationController pushViewController:intVC animated:YES];
}

//- (UIImageView *)puzzleImg {
//    if (!_puzzleImg) {
//        _puzzleImg=[[UIImageView alloc]init];
//        _puzzleImg.image=[UIImage imageNamed:@"企服者_分组 6"];
//    }
//    return _puzzleImg;
//}

- (UIButton *)puzzleBtn {
    if (!_puzzleBtn) {
        _puzzleBtn=[[UIButton alloc]init];
        [_puzzleBtn setImage:[UIImage imageNamed:@"企服者-修改_分组 7"] forState:UIControlStateNormal];
        //        _puzzleBtn.layer.cornerRadius=10;
        //        _puzzleBtn.backgroundColor=[UIColor whiteColor];
        [_puzzleBtn addTarget:self action:@selector(puzzleTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _puzzleBtn;
}

- (void)puzzleTouch {
    ETPuzzleViewController*puzVC=[[ETPuzzleViewController alloc]init];
    [self.navigationController pushViewController:puzVC animated:YES];
}

//@property(nonatomic,strong) UIButton *lawBtn;
//@property(nonatomic,strong) UIButton *synthesizeBtn;
//@property(nonatomic,strong) UIButton *moreBtn;

-(UIButton *)lawBtn {
    if (!_lawBtn) {
        _lawBtn=[[UIButton alloc]init];
        [_lawBtn setImage:[UIImage imageNamed:@"企服者-修改_分组 13"] forState:UIControlStateNormal];
        [_lawBtn addTarget:self action:@selector(lawTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _lawBtn;
}
- (void)lawTouch {
    ETLawViewController *lawVC=[[ETLawViewController alloc]init];
    [self.navigationController pushViewController:lawVC animated:YES];
}

//#import "ETLawViewController.h"
//#import "ETSynViewController.h"
//#import "ETStillViewController.h"
- (UIButton *)synthesizeBtn {
    if (!_synthesizeBtn) {
        _synthesizeBtn=[[UIButton alloc]init];
        [_synthesizeBtn setImage:[UIImage imageNamed:@"企服者-修改_分组 14"] forState:UIControlStateNormal];
        [_synthesizeBtn addTarget:self action:@selector(synTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _synthesizeBtn;
}
- (void)synTouch {
    ETSynViewController *synVC=[[ETSynViewController alloc]init];
    [self.navigationController pushViewController:synVC animated:YES];
}
-(UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn=[[UIButton alloc]init];
        [_moreBtn setImage:[UIImage imageNamed:@"企服者-修改_分组 15"] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(stillTouch) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}

- (void)stillTouch {
    [MBProgressHUD showMBProgressHud:self.view withText:@"敬请期待更多精彩内容!" withTime:1];
    return;
    ETStillViewController *stillVC=[[ETStillViewController alloc]init];
    [self.navigationController pushViewController:stillVC animated:YES];
}
@end
