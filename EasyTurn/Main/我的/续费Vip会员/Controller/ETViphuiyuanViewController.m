//
//  ETViphuiyuanViewController.m
//  等比例布局
//
//  Created by 王翔 on 2019/8/21.
//  Copyright © 2019 王翔. All rights reserved.
//

#import "ETViphuiyuanViewController.h"
#import "Masonry.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"
#import "WechatAuthSDK.h"
#import "WXApiObject.h"
#import <AlipaySDK/AlipaySDK.h>
#import "APOrderInfo.h"
#import "APAuthInfo.h"
#import "APRSASigner.h"
#import "ETProductModel.h"
#import "ETMineModel.h"
#import "ETViphuiyuanModel.h"
#import "SSPayUtils.h"
#define kOrderId @"OrderId"
@interface ETViphuiyuanViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollvBackground;
@property (nonatomic,strong) UIImageView *topImg;
@property (nonatomic,strong) UIButton *retBtn;
@property (nonatomic,strong) UILabel *navLab;
@property (nonatomic,strong) UIImageView *userImg;
@property (nonatomic,strong) UILabel *nameLab;
@property (nonatomic,strong) UIImageView *vipImg;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *kexuanLab;
@property (nonatomic,strong) UIScrollView *scroller;
@property (nonatomic,strong) UILabel *zifuLab;
@property (nonatomic,strong) UIView *scrollerView;
@property (nonatomic,strong) UIButton *janBtn;
@property (nonatomic,strong) UILabel *topLab;
@property (nonatomic,strong) UILabel *centerLab;
@property (nonatomic,strong) UILabel *bottomLab;

@property (nonatomic,strong) UIButton *marBtn;
@property (nonatomic,strong) UILabel *topLab1;
@property (nonatomic,strong) UILabel *centerLab1;
@property (nonatomic,strong) UILabel *bottomLab1;

@property (nonatomic,strong) UIButton *JunBtn;
@property (nonatomic,strong) UILabel *topLab2;
@property (nonatomic,strong) UILabel *centerLab2;
@property (nonatomic,strong) UILabel *bottomLab2;

@property (nonatomic,strong) UIButton *decBtn;
@property (nonatomic,strong) UILabel *topLab3;
@property (nonatomic,strong) UILabel *centerLab3;
@property (nonatomic,strong) UILabel *bottomLab3;

@property (nonatomic,strong) UIButton * wxBtn;
@property (nonatomic,strong) UIButton * zfbBtn;
@property (nonatomic,strong) UIView * shareView;
@property (nonatomic,strong) UILabel *shuominglab;
@property (nonatomic,assign) int tag;
@property (nonatomic,assign) int paytype;
@property (nonatomic,strong) NSMutableArray* products;

@property (nonatomic,strong) NSString* vipid;

@property (nonatomic,strong) NSString* aliprice;
@property (nonatomic,assign) NSInteger selectIndex;

@property (nonatomic,strong) UIView * maskTheView1;
@property (nonatomic,strong) UIView * shareView1;
@property (nonatomic,strong) UILabel *lab1;

@end

@implementation ETViphuiyuanViewController

-(void)viewWillAppear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [_scrollvBackground setContentSize:CGSizeMake(Screen_Width, 790)];
}


- (UIView *)maskTheView1 {
    if (!_maskTheView1) {
        _maskTheView1 = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _maskTheView1.backgroundColor = [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:0.5];
        //添加一个点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskClickGesture1)];
        [_maskTheView1 addGestureRecognizer:tap];//让header去检测点击手势
    }
    return _maskTheView1;
}

- (void)maskClickGesture1 {
    [self.maskTheView1 removeFromSuperview];
    [self.shareView1 removeFromSuperview];
    
}

- (UIView *)shareView1{
    if (!_shareView1) {
        _shareView1 = [[UIView alloc]initWithFrame:CGRectMake(30, Screen_Height/2-100, Screen_Width-60,200)];
        _shareView1.layer.cornerRadius=20;
        _shareView1.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
    }
    return _shareView1;
}
//添加提示框
- (void)shareViewController1 {
    UIImageView *returnImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, 23, 50, 50)];
    returnImage.image=[UIImage imageNamed:@"WechatIMG222"];
    returnImage.userInteractionEnabled = YES;
    [_shareView1 addSubview:returnImage];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(80, 25, Screen_Width, 45)];
    lab.text=@"确认退出";
    lab.textColor=[UIColor blackColor];
    lab.font =[UIFont systemFontOfSize:20];
    [_shareView1 addSubview:lab];
    
    _lab1=[[UILabel alloc]initWithFrame:CGRectMake(20, 75, Screen_Width-90, 50)];
    
    _lab1.numberOfLines=0;
    _lab1.text=@"加入易转大家庭，享受VIP待遇，优惠不等人";
    _lab1.textColor=[UIColor blackColor];
    _lab1.font =[UIFont systemFontOfSize:14];
    [_shareView1 addSubview:_lab1];
    
    UIButton *returnbtn =[[UIButton alloc]initWithFrame:CGRectMake(_shareView1.size.width-150, 155, 50, 21)];
    [returnbtn setTitle:@"关闭" forState:UIControlStateNormal];
    returnbtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [returnbtn addTarget:self action:@selector(clickImage1) forControlEvents:UIControlEventTouchUpInside];
    [returnbtn setTitleColor:[UIColor colorWithRed:243/255.0 green:22/255.0 blue:22/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_shareView1 addSubview:returnbtn];
    
    UIButton *surebtn =[[UIButton alloc]initWithFrame:CGRectMake(_shareView1.size.width-100, 155, 50, 21)];
    [surebtn setTitle:@"确定" forState:UIControlStateNormal];
    surebtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [surebtn setTitleColor:[UIColor colorWithRed:243/255.0 green:22/255.0 blue:22/255.0 alpha:1.0] forState:UIControlStateNormal];
    [surebtn addTarget:self action:@selector(PostUI1) forControlEvents:UIControlEventTouchUpInside];
    
    [_shareView1 addSubview:surebtn];
    
}

- (void)clickImage1 {
    [self.maskTheView1 removeFromSuperview];
    [self.shareView1 removeFromSuperview];
}

- (void)PostUI1 {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createSubViewsAndConstraints];
    [self requestUserInfo];
    [self requestGetVipList];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestPayResult) name:Request_PayResult object:nil];
   
}

#pragma mark - createSubViewsAndConstraints
- (void)createSubViewsAndConstraints {
    
    _scrollvBackground = [[UIScrollView alloc] init];
    _scrollvBackground.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_scrollvBackground];
    [_scrollvBackground mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    _topImg=[[UIImageView alloc]init];
    _topImg.userInteractionEnabled=YES;
    _topImg.image=[UIImage imageNamed:@"VIP会员_分组 3"];
    [self.scrollvBackground addSubview:_topImg];
    [_topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (kStatusBarHeight);
        make.width.mas_equalTo(Screen_Width);
        make.height.mas_equalTo(140);
    }];
    
    UIView* v=[UIView new];
    v.backgroundColor=[UIColor clearColor];
    
    _retBtn=[[UIButton alloc]init];
    [_retBtn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateNormal];
    [_retBtn addTarget:self action:@selector(returnClick) forControlEvents:UIControlEventTouchUpInside];
    [v addSubview:_retBtn];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(returnClick)];
    [v addGestureRecognizer:tap];
    [_topImg addSubview:v];
    
    [v mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [_retBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (15);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(8, 15));
    }];
    
    _navLab=[[UILabel alloc]init];
    _navLab.text=@"VIP会员";
    _navLab.font=[UIFont systemFontOfSize:18];
    _navLab.textColor=[UIColor whiteColor];
    [_topImg addSubview:_navLab];
    [_navLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.equalTo(self.topImg);
    }];
    
    _userImg = [[UIImageView alloc]init];
    [_userImg addCornerRadiusWithRadius:4.0f];
    [self.topImg addSubview:_userImg];
    [_userImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (58);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(59, 59));
    }];
    
    _nameLab=[[UILabel alloc]init];
    _nameLab.font=[UIFont systemFontOfSize:15];
    _nameLab.textColor=[UIColor whiteColor];
    [_topImg addSubview:_nameLab];
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (67);
        make.left.mas_equalTo(91);
        make.right.mas_equalTo(-150);
        make.height.mas_equalTo(21);
    }];
    
    _vipImg=[[UIImageView alloc]init];
    _vipImg.image=[UIImage imageNamed:@"81566452926_.pic"];
    [_topImg addSubview:_vipImg];
    [_vipImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (72);
        make.left.equalTo(self.nameLab.mas_right).offset(5);
        make.size.mas_equalTo(CGSizeMake(14, 11));
    }];
    
    _timeLab=[[UILabel alloc]init];
    _timeLab.font=[UIFont systemFontOfSize:13];
    _timeLab.textColor=[UIColor whiteColor];
    [_topImg addSubview:_timeLab];
    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (94);
        make.left.mas_equalTo(91);
        make.size.mas_equalTo(CGSizeMake(200, 21));
    }];
    
    //可选套餐
    _kexuanLab=[[UILabel alloc]init];
    _kexuanLab.text=@"可选套餐";
    _kexuanLab.font=[UIFont systemFontOfSize:15];
    [self.scrollvBackground addSubview:_kexuanLab];
    [_kexuanLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo (self.topImg.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(62, 21));
    }];
    
    _scroller=[[UIScrollView alloc]init];
    _scroller.delegate = self;
    _scroller.pagingEnabled = YES;
    _scroller.scrollEnabled = YES;
    _scroller.showsHorizontalScrollIndicator = NO;
    _scroller.bounces = NO;
    _scroller.contentSize = CGSizeMake(160*3, 110);
    [self.scrollvBackground addSubview:_scroller];
    [_scroller mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.kexuanLab.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(Screen_Width, 110));
    }];
    
    _janBtn =[[UIButton alloc]init];
    _janBtn.layer.borderWidth=2;
    _janBtn.layer.borderColor=[UIColor colorWithRed:252/255.0 green:221/255.0 blue:189/255.0 alpha:1.0].CGColor;
    _janBtn.tag=1;
    [_janBtn addTarget:self action:@selector(zhuanhuan:) forControlEvents:UIControlEventTouchUpInside];
    [_scroller addSubview:_janBtn];
    [_janBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (0);
        make.left.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(100, 110));
    }];
    
    _topLab=[[UILabel alloc]init];
    _topLab.text=@"1个月";
    _topLab.font=[UIFont systemFontOfSize:14];
    _topLab.textColor=[UIColor blackColor];
    [_janBtn addSubview:_topLab];
    [_topLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (29);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(20);
    }];
    
    _centerLab=[[UILabel alloc]init];
    _centerLab.text=@"¥ 98";
    _centerLab.textColor=[UIColor colorWithRed:202/255.0 green:126/255.0 blue:50/255.0 alpha:1.0];
    [_janBtn addSubview: _centerLab];
    [ _centerLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (48);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(34);
    }];
    
    _marBtn =[[UIButton alloc]init];
    _marBtn.layer.borderWidth=2;
    _marBtn.layer.borderColor=[UIColor colorWithRed:252/255.0 green:221/255.0 blue:189/255.0 alpha:1.0].CGColor;
    _marBtn.tag=2;
    [_marBtn addTarget:self action:@selector(zhuanhuan:) forControlEvents:UIControlEventTouchUpInside];
    [_scroller addSubview:_marBtn];
    [_marBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (0);
        make.left.mas_equalTo(self.janBtn.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 110));
    }];
    
    _topLab1=[[UILabel alloc]init];
    _topLab1.text=@"3个月";
    _topLab1.font=[UIFont systemFontOfSize:14];
    _topLab1.textColor=[UIColor blackColor];
    [_marBtn addSubview:_topLab1];
    [_topLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (29);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(20);
    }];
    
    _centerLab1=[[UILabel alloc]init];
    _centerLab1.text=@"¥ 188";
    _centerLab1.font=[UIFont systemFontOfSize:20];
    _centerLab1.textColor=[UIColor colorWithRed:202/255.0 green:126/255.0 blue:50/255.0 alpha:1.0];
    [_marBtn addSubview: _centerLab1];
    [ _centerLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (48);
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-22);
        make.height.mas_equalTo(34);
    }];
    
    _bottomLab1=[[UILabel alloc]init];
    NSDictionary * centerAttribtDic = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]};
    NSMutableAttributedString * centerAttr = [[NSMutableAttributedString alloc] initWithString:@"¥ 274" attributes:centerAttribtDic];
    _bottomLab1.attributedText = centerAttr;
    _bottomLab1.font=[UIFont systemFontOfSize:13];
    [_marBtn addSubview: _bottomLab1];
    [ _bottomLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (70);
        make.left.mas_equalTo(28);
        make.right.mas_equalTo(-28);
        make.height.mas_equalTo(20);
    }];
    
    _JunBtn =[[UIButton alloc]init];
    _JunBtn.layer.borderWidth=2;
    _JunBtn.layer.borderColor=[UIColor colorWithRed:252/255.0 green:221/255.0 blue:189/255.0 alpha:1.0].CGColor;
    _JunBtn.tag=3;
    [_JunBtn addTarget:self action:@selector(zhuanhuan:) forControlEvents:UIControlEventTouchUpInside];
    [_scroller addSubview:_JunBtn];
    [_JunBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (0);
        make.left.mas_equalTo(_marBtn.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 110));
    }];
    
    _topLab2=[[UILabel alloc]init];
    _topLab2.text=@"6个月";
    _topLab2.font=[UIFont systemFontOfSize:14];
    _topLab2.textColor=[UIColor blackColor];
    [_JunBtn addSubview:_topLab2];
    [_topLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (29);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(20);
    }];
    
    _centerLab2=[[UILabel alloc]init];
    _centerLab2.text=@"¥ 388";
    _centerLab2.font=[UIFont systemFontOfSize:20];
    _centerLab2.textColor=[UIColor colorWithRed:202/255.0 green:126/255.0 blue:50/255.0 alpha:1.0];
    [_JunBtn addSubview: _centerLab2];
    [ _centerLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (48);
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-22);
        make.height.mas_equalTo(34);
    }];
    
    _bottomLab2=[[UILabel alloc]init];
    NSDictionary * centerAttribtDic2 = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]};
    NSMutableAttributedString * centerAttr2 = [[NSMutableAttributedString alloc] initWithString:@"¥ 588" attributes:centerAttribtDic2];
    _bottomLab2.attributedText = centerAttr2;
    _bottomLab2.font=[UIFont systemFontOfSize:13];
    [_JunBtn addSubview: _bottomLab2];
    [ _bottomLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (70);
        make.left.mas_equalTo(28);
        make.right.mas_equalTo(-28);
        make.height.mas_equalTo(20);
    }];
    
    _decBtn =[[UIButton alloc]init];
    _decBtn.layer.borderWidth=2;
    _decBtn.tag=4;
    _decBtn.layer.borderColor=[UIColor colorWithRed:252/255.0 green:221/255.0 blue:189/255.0 alpha:1.0].CGColor;
    [_decBtn addTarget:self action:@selector(zhuanhuan:) forControlEvents:UIControlEventTouchUpInside];
    [_scroller addSubview:_decBtn];
    [_decBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (0);
        make.left.mas_equalTo(_JunBtn.mas_right).offset(20);
        make.size.mas_equalTo(CGSizeMake(100, 110));
    }];
    
    _topLab3=[[UILabel alloc]init];
    _topLab3.text=@"12个月";
    _topLab3.font=[UIFont systemFontOfSize:14];
    _topLab3.textColor=[UIColor blackColor];
    [_decBtn addSubview:_topLab3];
    [_topLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (29);
        make.left.mas_equalTo(28);
        make.right.mas_equalTo(-28);
        make.height.mas_equalTo(20);
    }];
    
    _centerLab3=[[UILabel alloc]init];
    _centerLab3.text=@"¥ 618";
    _centerLab3.font=[UIFont systemFontOfSize:20];
    _centerLab3.textColor=[UIColor colorWithRed:202/255.0 green:126/255.0 blue:50/255.0 alpha:1.0];
    [_decBtn addSubview: _centerLab3];
    [ _centerLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (48);
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-22);
        make.height.mas_equalTo(34);
    }];
    
    _bottomLab3=[[UILabel alloc]init];
    //    _bottomLab3.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    _bottomLab3.font=[UIFont systemFontOfSize:13];
    NSDictionary * centerAttribtDic3 = @{NSStrikethroughStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle],NSForegroundColorAttributeName:[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]};
    NSMutableAttributedString * centerAttr3 = [[NSMutableAttributedString alloc] initWithString:@"¥ 1176" attributes:centerAttribtDic3];
    _bottomLab3.attributedText = centerAttr3;
    [_decBtn addSubview: _bottomLab3];
    [ _bottomLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo (70);
        make.left.mas_equalTo(28);
        make.right.mas_equalTo(-28);
        make.height.mas_equalTo(20);
    }];
    
    UIView*scrollerbotomView=[[UIView alloc]init];
    scrollerbotomView.backgroundColor= [UIColor colorWithRed:242/255.f green:242/255.f blue:242/255.f alpha:0.5];
    [self.scrollvBackground addSubview:scrollerbotomView];
    [scrollerbotomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.scroller.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    
    _zifuLab=[[UILabel alloc]init];
    _zifuLab.text=@"支付方式";
    _zifuLab.font=[UIFont systemFontOfSize:15];
    [self.scrollvBackground addSubview:_zifuLab];
    [_zifuLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollerbotomView.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(62, 21));
    }];
    
    _shareView = [[UIView alloc]init];
    [self.scrollvBackground addSubview:self.shareView];
    [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.zifuLab.mas_bottom);
        make.width.mas_equalTo(375);
        make.height.mas_equalTo(170);
    }];
    
    
    UIImageView *wxImg=[[UIImageView alloc]init];
    wxImg.image=[UIImage imageNamed:@"提现_微信"];
    [_shareView addSubview:wxImg];
    [wxImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(25);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel *wxLab=[[UILabel alloc]init];
    wxLab.text=@"微信";
    wxLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [_shareView addSubview:wxLab];
    [wxLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(29);
        make.left.mas_equalTo(57);
        make.size.mas_equalTo(CGSizeMake(119, 21));
    }];
    
    _wxBtn=[[UIButton alloc]init];
    _wxBtn.selected = YES;
    _paytype = 2;
    [_wxBtn setImage:[UIImage imageNamed:@"注册_未选中"] forState:UIControlStateNormal];
    [_wxBtn setImage:[UIImage imageNamed:@"注册_选中"] forState:UIControlStateSelected];
    _wxBtn.tag=0;
    [_shareView addSubview:_wxBtn];
    [_wxBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(29);
        make.right.mas_equalTo(-13);
        make.size.mas_equalTo(CGSizeMake(19, 19));
    }];
    
    UIView*centerView=[[UIView alloc]init];
    centerView.backgroundColor= [UIColor colorWithRed:242/255.f green:242/255.f blue:242/255.f alpha:0.5];
    [_shareView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(69);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(kLinePixel);
    }];
    
    UIImageView *zfbImg=[[UIImageView alloc]init];
    zfbImg.image=[UIImage imageNamed:@"提现_支付宝"];
    [_shareView addSubview:zfbImg];
    [zfbImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(85);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    
    UILabel *zfbLab=[[UILabel alloc]init];
    zfbLab.text=@"支付宝";
    zfbLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [_shareView addSubview:zfbLab];
    [zfbLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(89);
        make.left.mas_equalTo(57);
        make.size.mas_equalTo(CGSizeMake(134, 21));
    }];
    
    _zfbBtn=[[UIButton alloc]init];
    [_zfbBtn setImage:[UIImage imageNamed:@"注册_未选中"] forState:UIControlStateNormal];
    [_zfbBtn setImage:[UIImage imageNamed:@"注册_选中"] forState:UIControlStateSelected];
    _zfbBtn.tag=1;
    [_shareView addSubview:_zfbBtn];
    [_zfbBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_zfbBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(89);
        make.right.mas_equalTo(-13);
        make.size.mas_equalTo(CGSizeMake(19, 19));
    }];
    
    UIView*botomView=[[UIView alloc]init];
    botomView.backgroundColor= [UIColor colorWithRed:242/255.f green:242/255.f blue:242/255.f alpha:0.5];
    [_shareView addSubview:botomView];
    [botomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(129);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(kLinePixel);
    }];
    
    UIButton *goPayBtn = [[UIButton alloc]init];
    [goPayBtn setBackgroundImage:[UIImage imageNamed:@"VIP会员_分组"] forState:UIControlStateNormal];
    goPayBtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [goPayBtn addTarget:self action:@selector(stagepay) forControlEvents:UIControlEventTouchUpInside];
    [_shareView addSubview:goPayBtn];
    [goPayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(botomView.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(345);
        make.height.mas_equalTo(40);
    }];
    
    UIView*sharebotomView=[[UIView alloc]init];
    sharebotomView.backgroundColor= [UIColor colorWithRed:242/255.f green:242/255.f blue:242/255.f alpha:0.5];
    [self.scrollvBackground addSubview:sharebotomView];
    [sharebotomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shareView.mas_bottom).offset(10);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(10);
    }];
    
    _shuominglab=[[UILabel alloc]init];
    _shuominglab.text=@"易转会员说明";
    _shuominglab.font=[UIFont systemFontOfSize:15];
    [self.scrollvBackground addSubview:_shuominglab];
    [_shuominglab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sharebotomView.mas_bottom).offset(10);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(100, 30));
    }];
    
    UILabel*tisiV=[[UILabel alloc]init];
    tisiV.text = @"1.用户首次注册登录送7天会员，免费享受会员资格；\n2.用户在平台发布出售及服务内容，满60条送3个月会员，累计满200条，送半年会员；\n3.会员免费享受每天无限次查看商品详情，非会员每天免费查看3条商品详情（会员可享受平台所有优惠活动）；\n4.完成支付后可在我的-账户余额-账单记录中查看购买记录；\n5.VIP会员自支付完成之时起5分钟内生效；\n6.易转官方对此活动持有最终解释权。";
    tisiV.numberOfLines=0;
    tisiV.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    tisiV.font=[UIFont systemFontOfSize:13];
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 8 - (tisiV.font.lineHeight - tisiV.font.pointSize);
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    tisiV.attributedText = [[NSAttributedString alloc] initWithString:tisiV.text attributes:attributes];
    
    [self.scrollvBackground addSubview:tisiV];
    [tisiV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.shuominglab.mas_bottom).offset(4);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(345);
        make.bottom.equalTo(self.scrollvBackground.mas_bottom);
    }];
    
    [self shareView1];
    [self shareViewController1];
    [_janBtn setBackgroundColor:[UIColor colorWithRed:250/255.f green:207/255.f blue:150/255.f alpha:0.5]];
    [self memberClick:_janBtn];
}



- (void)titleBtnClick:(UIButton *)btn {
    if (btn!= _wxBtn) {
        self.wxBtn.selected = NO;
        btn.selected = YES;
        self.wxBtn = btn;
    }else{
        self.wxBtn.selected = YES;
        _paytype=2;
        
    }
    if (btn!= _zfbBtn) {
        self.zfbBtn.selected = NO;
        btn.selected = YES;
        self.zfbBtn = btn;
    }else{
        self.zfbBtn.selected = YES;
        _paytype=1;
        
    }
    if (btn.tag==0) {
        _paytype=2;
    }
    if (btn.tag==1) {
        _paytype=1;
    }
    
}
- (void)zhuanhuan:(UIButton *)sender {
    if (sender.tag==1) {
        self.janBtn.selected = YES;
        self.marBtn.selected = NO;
        self.JunBtn.selected= NO;
        self.decBtn.selected= NO;
        [_janBtn setBackgroundColor:[UIColor colorWithRed:250/255.f green:207/255.f blue:150/255.f alpha:0.5]];
        [_marBtn setBackgroundColor:[UIColor whiteColor]];
        [_JunBtn setBackgroundColor:[UIColor whiteColor]];
        [_decBtn setBackgroundColor:[UIColor whiteColor]];
    }else if (sender.tag==2) {
        self.janBtn.selected = NO;
        self.marBtn.selected = YES;
        self.JunBtn.selected= NO;
        self.decBtn.selected= NO;
        self.marBtn.selected = !self.marBtn.selected;
        [_marBtn setBackgroundColor:[UIColor colorWithRed:250/255.f green:207/255.f blue:150/255.f alpha:0.5]];
        [_janBtn setBackgroundColor:[UIColor whiteColor]];
        [_JunBtn setBackgroundColor:[UIColor whiteColor]];
        [_decBtn setBackgroundColor:[UIColor whiteColor]];
    }else if (sender.tag==3) {
        self.janBtn.selected = NO;
        self.marBtn.selected = NO;
        self.JunBtn.selected= YES;
        self.decBtn.selected= NO;
        self.JunBtn.selected= !self.JunBtn.selected;
        [_JunBtn setBackgroundColor:[UIColor colorWithRed:250/255.f green:207/255.f blue:150/255.f alpha:0.5]];
        [_janBtn setBackgroundColor:[UIColor whiteColor]];
        [_marBtn setBackgroundColor:[UIColor whiteColor]];
        [_decBtn setBackgroundColor:[UIColor whiteColor]];
    }else if (sender.tag==4) {
        self.janBtn.selected = NO;
        self.marBtn.selected = NO;
        self.JunBtn.selected= NO;
        self.decBtn.selected= YES;
        self.decBtn.selected= !self.decBtn.selected;
        [_decBtn setBackgroundColor:[UIColor colorWithRed:250/255.f green:207/255.f blue:150/255.f alpha:0.5]];
        [_janBtn setBackgroundColor:[UIColor whiteColor]];
        [_marBtn setBackgroundColor:[UIColor whiteColor]];
        [_JunBtn setBackgroundColor:[UIColor whiteColor]];
    }
    [self memberClick:sender];
}

- (void) memberClick:(UIButton*)sender {
    NSInteger a = sender.tag - 1;
    _selectIndex = a;
    ETMineModel* m=[_products objectAtIndex:a];
    _vipid=m.vipid;
    _aliprice=[m.money substringFromIndex:1];
}
- (void)returnClick {
    [self.view addSubview:self.maskTheView1];
    [self.view addSubview:self.shareView1];
   
}

#pragma mark - 请求网络用户信息
- (void)requestUserInfo {
    WEAKSELF
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    if (![user objectForKey:@"uid"]) {
        return;
    }
    NSDictionary *params = @{
                             @"uid" : [user objectForKey:@"uid"]
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"user/info"] params:params success:^(id responseObj) {
        UserInfoModel* info = [UserInfoModel mj_objectWithKeyValues:responseObj[@"data"][@"userInfo"]];
        
        if (info.portrait == nil) {
            weakSelf.userImg.image = [UIImage imageNamed:@"我的_默认头像"];
        }else {
             [weakSelf.userImg sd_setImageWithURL:[NSURL URLWithString:info.portrait]];
        }
        
        if (info.vipExpiryDate == nil) {
            weakSelf.timeLab.text = @"您还不是易转会员";
        }else {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[info.vipExpiryDate longLongValue]/1000];
            NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd"];
            NSString *dateStr = [formatter stringFromDate:date];
            weakSelf.timeLab.text = [NSString stringWithFormat:@"会员到期时间:%@",dateStr];
        }
        
        weakSelf.nameLab.text = info.name;
       
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 请求网络用户信息
- (void)requestGetVipList {
    WEAKSELF
    [HttpTool get:[NSString stringWithFormat:@"buy/getVipList"] params:nil success:^(NSDictionary *response) {
        weakSelf.products = [NSMutableArray new];
        for (NSDictionary* prod in response[@"data"][@"list"]) {
            ETMineModel *m = [ETMineModel mj_objectWithKeyValues:prod];
            [weakSelf.products addObject:m];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)stagepay {
    //调用第三方支付前,保存支付状态值
    [SSPayUtils shareUser].State = @"begin";
    if (_paytype == 1) {
        [self alipay];
        
    }else {
        [self wxPay];
    }
}

- (void)wxPay {
    if (!_vipid) {
        ETMineModel* m = [_products objectAtIndex:0];
        _vipid = m.vipid;
    }
    NSMutableDictionary* dic=[NSMutableDictionary new];

    NSDictionary *params = @{
                             @"id" : @([_vipid intValue]),
                             @"type" : @(_paytype)
                             
                             };
    [HttpTool get:[NSString stringWithFormat:@"pay/prePay"] params:params success:^(id responseObj) {
        //存储订单ID
        NSString* orderId = responseObj[@"data"][@"id"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:orderId forKey:kOrderId];
        [userDefaults synchronize];
        
        NSString* a=responseObj[@"data"][@"result"];
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[a dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        NSDictionary* d=[jsonDict copy];
        [self wechatPay:d];
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)alipay {
    if (!_vipid) {
        ETMineModel* m = [_products objectAtIndex:0];
        _vipid = m.vipid;
    }
    NSDictionary *params = @{
                             @"id" : @([_vipid intValue]),
                             @"type" : @(_paytype)
                             
                             };
    [HttpTool get:[NSString stringWithFormat:@"pay/prePay"] params:params success:^(id responseObj) {
        //存储订单ID
        NSString* orderId = responseObj[@"data"][@"id"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:orderId forKey:kOrderId];
        [userDefaults synchronize];
        
        NSString* payOrder = responseObj[@"data"][@"result"];
        [[AlipaySDK defaultService] payOrder:payOrder fromScheme:kAppScheme callback:^(NSDictionary *resultDic) {
            
        }];
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    

}

- (void)wechatPay:(NSDictionary*)d {

    NSString *res = [WXApiRequestHandler jumpToBizPay:d];
    if( ![@"" isEqual:res] ){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alter show];
    }
}


#pragma mark - 请求网络查询支付结果
- (void)requestPayResult {
    WEAKSELF
    [[ACToastView toastView]showLoadingCircleViewWithStatus:@"正在加载中"];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *orderId = [userDefaults objectForKey:kOrderId];
    [ETViphuiyuanModel requestPayResultWithOrderId:orderId WithSuccess:^(id request, STResponseModel *response, id resultObject) {
        if (response.code == 0) {
            ETViphuiyuanModel *model = response.data;
            if ([model.result isEqualToString:@"1"]) {
                //支付成功
                [[ACToastView toastView]showSuccessWithStatus:@"支付成功" completion:^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                    //通知我的页面刷新数据
                    [[NSNotificationCenter defaultCenter]postNotificationName:Refresh_Mine object:nil];
                }];
            }else {
                [[ACToastView toastView]showInfoWithStatus:@"支付失败"];
            }
        }else{
            if (response.msg.length > 0) {
                [[ACToastView toastView] showErrorWithStatus:response.msg];
            } else {
                [[ACToastView toastView] showErrorWithStatus:kToastErrorServerNoErrorMessage];
            }
        }
    } failure:^(id request, NSError *error) {

    }];

}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
