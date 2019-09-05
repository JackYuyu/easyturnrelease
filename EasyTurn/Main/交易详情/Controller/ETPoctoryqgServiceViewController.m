//
//  ETPoctoryqgViewController.m
//  布局
//
//  Created by 王翔 on 2019/8/29.
//  Copyright © 2019 王翔. All rights reserved.
//

#import "ETPoctoryqgServiceViewController.h"
#import "Masonry.h"
#import "ETPhreasTableViewCell.h"
#import "ETProductModel.h"
#import "ETBuyPushViewController.h"
#import "UserMegViewController.h"
#import "EaseMessageViewController.h"
#import "IANshowLoading.h"
#import "PublicFunc.h"
#import "WXApiManagerShare.h"
#import "ETViphuiyuanViewController.h"
#import "ETSaleDetailHeaderView.h"
#import "ETIssueViewController.h"
#import "ETPublishPurchaseViewController.h"
#import "ETPersuadersViewController.h"
//
@interface ETSaleCollectBtn2 : UIButton

@end

@implementation ETSaleCollectBtn2

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat left = (contentRect.size.width-19)/2;
    CGFloat top = 6;
    return CGRectMake(left, top, 19, 19);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat height = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium].lineHeight;
    return CGRectMake(0, contentRect.size.height-5-height, contentRect.size.width, height);
}

@end

@interface ETSaleTelBtn2 : UIButton

@end

@implementation ETSaleTelBtn2

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    NSString *title = [self titleForState:UIControlStateNormal];
    CGFloat left = 0;
    CGFloat top = (50-20)/2;
    UIFont *font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    if (title) {
        CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        left = (contentRect.size.width-size.width-6-20)/2;
    }
    return CGRectMake(left, top, 20, 18);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    NSString *title = [self titleForState:UIControlStateNormal];
    CGFloat left = 0;
    UIFont *font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    CGFloat top = (50-font.lineHeight)/2;
    CGSize size = CGSizeZero;
    if (title) {
        size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
        left = (contentRect.size.width-size.width-6-20)/2;
        left = contentRect.size.width-size.width-left;
    }
    return CGRectMake(left, top, size.width, size.height);
}

@end

//
static NSString* const kShareButtonText = @"分享";
static NSString* const kShareDescText = @"分享一个链接";
static NSString* const kShareFailedText = @"分享失败";
@interface ETPoctoryqgServiceViewController ()
@property (nonatomic,strong)UIImageView *topImg;
@property (nonatomic,strong)UIButton *retBtn;
@property (nonatomic,strong)UILabel *subLab;
@property (nonatomic,strong)UIButton *moreBtn;
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UILabel *biaotiLab;
@property (nonatomic,strong)UILabel *negotiableLab;
@property (nonatomic,strong)UILabel *pointLab;

@property (nonatomic,strong)UILabel *jibenLab;
@property (nonatomic,strong)UIView *centerView;
@property (nonatomic,strong)UILabel *contentLab;
@property (nonatomic,strong)UILabel *conLab;
@property (nonatomic,strong)UIView *cenView;
@property (nonatomic,strong)UILabel *addressLab;
@property (nonatomic,strong)UILabel *addLab;
@property (nonatomic,strong)UIView *serviceView;
@property (nonatomic,strong)UILabel *serviceLab;
@property (nonatomic,strong)UILabel *serviceTypeLab;

//@property (nonatomic,strong)
@property (nonatomic,strong)UILabel *qitaLab;
@property (nonatomic,strong)UIView *bottomView;
@property (nonatomic,strong)UILabel *cellnameLab;
@property (nonatomic,strong)UILabel *nameLab;
@property (nonatomic,strong)UIImageView * tiaoView;

@property (nonatomic,strong)UIView *fundusView;
@property (nonatomic,strong)UIButton *collectBtn;
@property (nonatomic,strong)UIButton *chatBtn;
@property (nonatomic,strong)UIImageView *chatImg;
@property (nonatomic,strong)UIButton *callBtn;
@property (nonatomic,strong)UIImageView *callImg;

@property (nonatomic, strong) UserInfoModel *toUser;
@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic,strong) NSMutableDictionary *detailInfo;
@property (nonatomic,strong) UIView * maskEditView;

@property (nonatomic,strong) UIView * maskTheView;
@property (nonatomic,strong) UIView * shareView;
@property (nonatomic,strong) NSString *share;

@property (nonatomic,assign)int select;

//编辑分享
@property (nonatomic, strong) UIButton* edit;
@property (nonatomic, strong) UIButton* moreshare;
//
@property (nonatomic,strong) ETSaleCollectBtn2 *btnCollect;
@property (nonatomic,strong) ETSaleTelBtn2 *btnChat;
@property (nonatomic,strong) ETSaleTelBtn2 *btnTel;

@end

@implementation ETPoctoryqgServiceViewController
- (void)viewWillAppear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:YES animated:TRUE];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:NO animated:TRUE];
    
}
- (UIImageView *)topImg {
    if (!_topImg) {
        _topImg=[[UIImageView alloc]init];
        _topImg.userInteractionEnabled=YES;
        _topImg.image=[UIImage imageNamed:@"求购详情 copy_分组 2"];
    }
    return _topImg;
}

- (UIButton *)retBtn {
    if (!_retBtn) {
        _retBtn =[[UIButton alloc]init];
        [_retBtn setImage:[UIImage imageNamed:@"求购详情 copy_分组"] forState:UIControlStateNormal];
        [_retBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _retBtn;
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UILabel *)subLab {
    if (!_subLab) {
        _subLab = [[UILabel alloc]init];
        _subLab.text=@"求购详情";
        _subLab.font=[UIFont systemFontOfSize:18];
    }
    return _subLab;
}

- (UIButton *)moreBtn {
    if (!_moreBtn) {
        _moreBtn=[[UIButton alloc]init];
        [_moreBtn setImage:[UIImage imageNamed:@"求购详情 copy_更多"] forState:UIControlStateNormal];
        
    }
    return _moreBtn;
}

- (UIView *)topView {
    if (!_topView) {
        _topView =[[UIView alloc]init];
        _topView.backgroundColor=[UIColor whiteColor];
        _topView.layer.cornerRadius = 5;
    }
    return _topView;
}

- (UILabel *)biaotiLab {
    if (!_biaotiLab) {
        _biaotiLab=[[UILabel alloc]init];
        _biaotiLab.text=@"求购一家空壳建筑公司";
        _biaotiLab.textColor=[UIColor blackColor];
        _biaotiLab.font=[UIFont systemFontOfSize:15];
        _biaotiLab.numberOfLines=0;
    }
    return _biaotiLab;
}

- (UILabel *)negotiableLab {
    if (!_negotiableLab) {
        _negotiableLab=[[UILabel alloc]init];
        _negotiableLab.text=@"企业流转";
        //        _negotiableLab.layer.borderWidth=1;
        _negotiableLab.layer.cornerRadius = 8;
        _negotiableLab.layer.masksToBounds = YES;
        _negotiableLab.textColor=[UIColor whiteColor];
        _negotiableLab.backgroundColor=[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
        _negotiableLab.font=[UIFont systemFontOfSize:14];
        _negotiableLab.textAlignment=UITextAlignmentCenter;
        
    }
    return _negotiableLab;
}

- (UILabel *)pointLab {
    if (!_pointLab) {
        _pointLab=[[UILabel alloc]init];
        _pointLab.text=@"提示：易转只作为商品信息发布平台，建议交易双方私下签订转让协议或服务协议，易转不承担任何交易风险。";
        _pointLab.textColor=[UIColor redColor];
        _pointLab.font=[UIFont systemFontOfSize:13];
        _pointLab.numberOfLines=0;
    }
    return _pointLab;
}

-(UILabel *)jibenLab {
    if (!_jibenLab) {
        _jibenLab=[[UILabel alloc]init];
        _jibenLab.text=@"求购基本信息";
        _jibenLab.font=[UIFont systemFontOfSize:13];
        _jibenLab.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    }
    return _jibenLab;
}

- (UIView *)centerView {
    if (!_centerView) {
        _centerView=[[UIView alloc]init];
        _centerView.backgroundColor=[UIColor whiteColor];
        _centerView.layer.cornerRadius = 5;
    }
    return _centerView;
}

- (UILabel *)contentLab {
    if (!_contentLab) {
        _contentLab=[[UILabel alloc]init];
        _contentLab.text=@"详细内容";
        _contentLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _contentLab.font=[UIFont systemFontOfSize:14];
    }
    return _contentLab;
}

- (UILabel *)conLab {
    if (!_conLab) {
        _conLab=[[UILabel alloc]init];
        _conLab.text=@"求购北京现成资质14项房建总包三级，市政总包三机电总包三 建筑机电安装三级 消防二级和";
        _conLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _conLab.font=[UIFont systemFontOfSize:16];
        _conLab.numberOfLines=0;
    }
    return _conLab;
}
- (UIView *)serviceView {
    if (!_serviceView) {
        _serviceView=[[UIView alloc]init];
        _serviceView.backgroundColor=[UIColor whiteColor];
        _serviceView.layer.cornerRadius = 5;
    }
    return _serviceView;
}

- (UILabel *)serviceLab {
    if (!_serviceLab) {
        _serviceLab=[[UILabel alloc]init];
        _serviceLab.text=@"服务类型";
        _serviceLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _serviceLab.font=[UIFont systemFontOfSize:14];
    }
    return _serviceLab;
}

- (UILabel *)serviceTypeLab {
    if (!_serviceTypeLab) {
        _serviceTypeLab=[[UILabel alloc]init];
        _serviceTypeLab.text=@"工商服务";
        _serviceTypeLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _serviceTypeLab.font=[UIFont systemFontOfSize:16];
        _serviceTypeLab.numberOfLines=0;
    }
    return _serviceTypeLab;
}
- (UIView *)cenView {
    if (!_cenView) {
        _cenView=[[UIView alloc]init];
        _cenView.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    }
    return _cenView;
}
- (UILabel *)addressLab {
    if (!_addressLab) {
        _addressLab=[[UILabel alloc]init];
        _addressLab.text=@"所在区域";
        _addressLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _addressLab.font=[UIFont systemFontOfSize:14];
    }
    return _addressLab;
}

- (UILabel *)addLab {
    if (!_addLab) {
        _addLab =[[UILabel alloc]init];
        _addLab.text=@"北京市-朝阳区";
        _addLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _addLab.font=[UIFont systemFontOfSize:16];
    }
    return _addLab;
}

- (UILabel *)qitaLab {
    if (!_qitaLab) {
        _qitaLab=[[UILabel alloc]init];
        _qitaLab.text=@"其他信息";
        _qitaLab.font=[UIFont systemFontOfSize:13];
        _qitaLab.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    }
    return _qitaLab;
}


- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView=[[UIView alloc]init];
        _bottomView.backgroundColor=[UIColor whiteColor];
        _bottomView.layer.cornerRadius = 5;
        _bottomView.userInteractionEnabled = YES;
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
        //将手势添加到需要相应的view中去
        [_bottomView addGestureRecognizer:tapGesture];
        //选择触发事件的方式（默认单机触发）
        
        [tapGesture setNumberOfTapsRequired:1];
    }
    return _bottomView;
}

- (void)event:(UIView*)view {
    UserMegViewController *megVC=[[UserMegViewController alloc]init];
    megVC.name=_toUser.name;
    megVC.photoImg=_toUser.portrait;
    [MySingleton sharedMySingleton].toUserid=_toUser.uid;
    [self presentViewController:megVC animated:YES completion:nil];
}

- (UILabel *)cellnameLab {
    if (!_cellnameLab) {
        _cellnameLab=[[UILabel alloc]init];
        _cellnameLab.text=@"联系人:";
        _cellnameLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _cellnameLab.font=[UIFont systemFontOfSize:14];
    }
    return _cellnameLab;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab=[[UILabel alloc]init];
        _nameLab.text=@"赵先生";
        _nameLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _nameLab.font=[UIFont systemFontOfSize:16];
    }
    return _nameLab;
}

- (UIImageView *)tiaoView {
    if (!_tiaoView) {
        _tiaoView=[[UIImageView alloc]init];
        _tiaoView.image=[UIImage imageNamed:@"进入"];
    }
    return _tiaoView;
}

- (UIView *)fundusView {
    if (!_fundusView) {
        _fundusView=[[UIView alloc]init];
        _fundusView.backgroundColor=[UIColor whiteColor];
    }
    return _fundusView;
}

- (UIButton *)collectBtn {
    if (!_collectBtn) {
        _collectBtn=[[UIButton alloc]init];
        [_collectBtn setImage:[UIImage imageNamed:@"求购详情 copy_分组 4"] forState:UIControlStateNormal];
         [_collectBtn setImage:[UIImage imageNamed:@"sale_已收藏"] forState:UIControlStateSelected];
        [_collectBtn addTarget:self action:@selector(staill) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectBtn;
}
- (void)staill {
    
}
- (UIButton *)chatBtn {
    if (!_chatBtn) {
        _chatBtn=[[UIButton alloc]init];
        [_chatBtn setTitle:@"在线聊天" forState:UIControlStateNormal];
        _chatBtn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        _chatBtn.backgroundColor=[UIColor colorWithRed:164/255.0 green:199/255.0 blue:245/255.0 alpha:1.0];
        [_chatBtn addTarget:self action:@selector(aaa) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chatBtn;
}

-(void)aaa {
//    UserInfoModel* m=[UserInfoModel loadUserInfoModel];
//    ETProductModel* p=[ETProductModel mj_objectWithKeyValues:self.detailInfo];
//    if ([m.uid isEqualToString:p.userId]) {
//        return;
//    }
//    NSDictionary *params = @{
//                             @"userId" : self.detailInfo[@"userId"]
//                             };
//    [IANshowLoading showLoadingForView:self.view];
//    [HttpTool get:[NSString stringWithFormat:@"user/getJimAuroraName"] params:params success:^(id responseObj) {
//        NSLog(@"");
//        [IANshowLoading hideLoadingForView:self.view];
//        NSDictionary* a=responseObj[@"data"];
//        EaseUserModel* model=[EaseUserModel new];
//        model.nickname=[a objectForKey:@"username"];
//        model.avatarURLPath=[a objectForKey:@"img"];
//        model.buddy=[a objectForKey:@"auroraName"];
//        [model bg_saveOrUpdate];
//        EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:[a objectForKey:@"auroraName"] conversationType:EMConversationTypeChat];
//        chatController.title=[a objectForKey:@"auroraName"];
//        [self.navigationController pushViewController:chatController animated:YES];
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//        [IANshowLoading hideLoadingForView:self.view];
//    }];
}
- (UIImageView *)chatImg {
    if (!_chatImg) {
        _chatImg=[[UIImageView alloc]init];
        _chatImg.image=[UIImage imageNamed:@"求购详情 copy_聊天"];
    }
    return _chatImg;
}



- (UIButton *)callBtn {
    if (!_callBtn) {
        _callBtn=[[UIButton alloc]init];
        [_callBtn setTitle:@"拨打电话" forState:UIControlStateNormal];
        _callBtn.titleLabel.font = [UIFont systemFontOfSize: 15.0];
        _callBtn.backgroundColor=[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
    }
    return _callBtn;
}

- (UIImageView *)callImg {
    if (!_callImg) {
        _callImg=[[UIImageView alloc]init];
        _callImg.image=[UIImage imageNamed:@"求购详情 copy_电话"];
    }
    return _callImg;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self PostUI];
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor= [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    
    UIScrollView* scroll=[[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen]bounds]];
    
    [scroll addSubview:self.topImg];
    [_topImg mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.view).with.offset(0);
        //        make.left.mas_equalTo(0);
        //        make.right.mas_equalTo(0);
        //        make.height.mas_equalTo(200);
        make.top.equalTo(self.view).offset(0);
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.height.mas_equalTo(235);

    }];
    
    UIImageView* imv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sale_矩形"]];
    imv.contentMode = UIViewContentModeScaleAspectFill;
    imv.clipsToBounds = YES;
    imv.frame = CGRectMake(0, kScaleX*15, kScaleX*9, kScaleX*20);
    [self.topView addSubview:imv];
    
    [self.topImg addSubview:self.retBtn];
    [_retBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    [self.topImg addSubview:self.subLab];
    [_subLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(75, 20));
    }];
    
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(Screen_Width-44-7, StatusBarHeight+7, 25, 25);
    [btn setImage:[UIImage imageNamed:@"WechatIMG23"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"WechatIMG23"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:@"WechatIMG23"] forState:UIControlStateSelected];
    //    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    btn.userInteractionEnabled=YES;
    [btn addTarget:self action:@selector(shareBtn) forControlEvents:UIControlEventTouchUpInside];
    self.moreBtn=btn;
    [self.topImg addSubview:self.moreBtn];
    [_moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(50);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    
    [scroll addSubview:self.topView];
    [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(170);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(170);
    }];
    
    [self.topView addSubview:self.biaotiLab];
    [_biaotiLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_top).offset(20);
        make.centerX.mas_equalTo(0);
        make.leading.mas_greaterThanOrEqualTo(18);
        make.trailing.mas_lessThanOrEqualTo(-18);
    }];
    
    [self.topView addSubview:self.negotiableLab];
    [_negotiableLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.centerX.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(85, 35));
    }];
    
    [self.topView addSubview:self.pointLab];
    [_pointLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topView.mas_top).offset(112);
        make.centerX.mas_equalTo(0);
        make.leading.mas_greaterThanOrEqualTo(5);
        make.trailing.mas_lessThanOrEqualTo(-5);
    }];
    
    
    [scroll addSubview:self.jibenLab];
    [_jibenLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).with.offset(10);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(97, 17));
    }];
    
    [scroll addSubview:self.centerView];
    [_centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.jibenLab.mas_bottom).with.offset(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(219);
    }];
    //    @property (nonatomic,strong)UILabel *contentLab;
    //    @property (nonatomic,strong)UILabel *conLab;
    //    @property (nonatomic,strong)UIView *cenView;
    //    @property (nonatomic,strong)UILabel *addressLab;
    //    @property (nonatomic,strong)UILabel *addLab;
    [self.centerView addSubview:self.contentLab];
    [_contentLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(14);
        make.size.mas_equalTo(CGSizeMake(75, 19));
    }];
    
    [self.centerView addSubview:self.conLab];
    [_conLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentLab.mas_bottom).with.offset(10);
        make.left.mas_equalTo(14);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(42);
    }];
    
//    [scroll addSubview:self.serviceView];
//    [_serviceView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.conLab.mas_bottom).with.offset(10);
//        make.left.mas_equalTo(15);
//        make.right.mas_equalTo(-15);
//        make.height.mas_equalTo(155);
//    }];
//    //    @property (nonatomic,strong)UILabel *contentLab;
//    //    @property (nonatomic,strong)UILabel *conLab;
//    //    @property (nonatomic,strong)UIView *cenView;
//    //    @property (nonatomic,strong)UILabel *addressLab;
//    //    @property (nonatomic,strong)UILabel *addLab;
//    [self.serviceView addSubview:self.serviceLab];
//    [_serviceLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(10);
//        make.left.mas_equalTo(14);
//        make.size.mas_equalTo(CGSizeMake(75, 19));
//    }];
//    
//    [self.serviceView addSubview:self.serviceTypeLab];
//    [_serviceTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.serviceLab.mas_bottom).with.offset(10);
//        make.left.mas_equalTo(14);
//        make.right.mas_equalTo(-16);
//        make.height.mas_equalTo(42);
//    }];
    
    [self.centerView addSubview:self.cenView];
    [_cenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.serviceTypeLab.mas_bottom).with.offset(10);
        make.left.mas_equalTo(16);
        make.right.mas_equalTo(-16);
        make.height.mas_equalTo(1);
    }];
    
    [self.centerView addSubview:self.addressLab];
    [_addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.cenView.mas_bottom).with.offset(10);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(275, 19));
    }];
    
    [self.centerView addSubview:self.addLab];
    [_addLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.addressLab.mas_bottom).with.offset(10);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(200, 19));
    }];
    
    
    [scroll addSubview:self.qitaLab];
    [_qitaLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.centerView.mas_bottom).with.offset(10);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(77, 17));
    }];
    
    [scroll addSubview:self.bottomView];
    //    if (IPHONE_X) {
    //        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.top.equalTo(self.qitaLab.mas_bottom).with.offset(10);
    //            make.left.mas_equalTo(15);
    //            make.right.mas_equalTo(-15);
    //            make.height.mas_equalTo(65);
    //        }];
    //        return;
    //    }
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.qitaLab.mas_bottom).with.offset(10);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(65);
    }];
    
    [self.bottomView addSubview:self.cellnameLab];
    [_cellnameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(11);
        make.left.mas_equalTo(14);
        make.size.mas_equalTo(CGSizeMake(68, 19));
    }];
    
    [self.bottomView addSubview:self.nameLab];
    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cellnameLab.mas_bottom).with.offset(10);
        make.left.mas_equalTo(14);
        make.size.mas_equalTo(CGSizeMake(100, 21));
    }];
    
    [self.bottomView addSubview:self.tiaoView];
    [_tiaoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(0);
        make.right.mas_equalTo(-11);
        make.size.mas_equalTo(CGSizeMake(9, 16));
    }];
    
    
    [scroll addSubview:self.fundusView];
    [_fundusView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (IPHONE_X) {
            make.bottom.mas_equalTo(-20);
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.height.mas_equalTo(50);
        }
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(50);
    }];
    
    UserInfoModel* info=[UserInfoModel loadUserInfoModel];
    if (!info.vip) {
        UIView* view=[[UIView alloc] init];
        view.backgroundColor=[UIColor redColor];
        UILabel* lab=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, Screen_Width-20, 30)];
        lab.font=[UIFont systemFontOfSize:18];
        lab.textAlignment=UITextAlignmentCenter;
        lab.text=@"开通平台VIP,享受会员待遇";
        [lab setTextColor:[UIColor whiteColor]];
        [view addSubview:lab];
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        
            [view addGestureRecognizer:tapGesturRecognizer];
        [_fundusView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_fundusView);
            make.width.height.mas_equalTo(_fundusView);
        }];
        
    }
    else
    {
        //
        
        self.btnCollect = [ETSaleCollectBtn2 buttonWithType:UIButtonTypeCustom];
        [self.btnCollect setImage:[UIImage imageNamed:@"sale_已收藏"] forState:UIControlStateSelected];
        [self.btnCollect setImage:[UIImage imageNamed:@"sale_收藏"] forState:UIControlStateNormal];
        self.btnCollect.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        [self.btnCollect setTitleColor:RGBCOLOR(195, 195, 195) forState:UIControlStateNormal];
        [self.btnCollect setTitleColor:RGBCOLOR(248, 124, 43) forState:UIControlStateSelected];
        [self.btnCollect setTitle:@"收藏" forState:UIControlStateNormal];
        [self.btnCollect setTitle:@"收藏" forState:UIControlStateSelected];
        self.btnCollect.frame = CGRectMake(Screen_Width/6-30, 0, 59*kScaleX, 50);
        [self.btnCollect addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.fundusView addSubview:self.btnCollect];
        self.btnCollect.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.btnCollect.tag = 1;
        
        //
        self.btnChat = [ETSaleCollectBtn2 buttonWithType:UIButtonTypeCustom];
        //        [self.btnChat setImage:[UIImage imageNamed:@"sale_聊天 copy"] forState:UIControlStateSelected];
        [self.btnChat setImage:[UIImage imageNamed:@"sale_聊天 copy"] forState:UIControlStateNormal];
        self.btnChat.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        [self.btnChat setTitleColor:RGBCOLOR(195, 195, 195) forState:UIControlStateNormal];
        [self.btnChat setTitleColor:RGBCOLOR(248, 124, 43) forState:UIControlStateSelected];
        [self.btnChat setTitle:@"在线聊天" forState:UIControlStateNormal];
        [self.btnChat setTitle:@"收藏" forState:UIControlStateSelected];
        self.btnChat.frame = CGRectMake( Screen_Width/3+Screen_Width/6-79,0, 159*kScaleX, 50);
        [self.btnChat addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.fundusView addSubview:self.btnChat];
        self.btnChat.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.btnChat.tag = 2;
        //
        
        //        self.btnChat = [ETSaleTelBtn buttonWithType:UIButtonTypeCustom];
        //        [self.btnChat setImage:[UIImage imageNamed:@"sale_聊天"] forState:UIControlStateNormal];
        //        self.btnChat.titleLabel.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
        //        self.btnChat.backgroundColor = RGBCOLOR(164, 199, 245);
        //        [self.btnChat setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //        [self.btnChat setTitle:@"在线聊天" forState:UIControlStateNormal];
        //        self.btnChat.frame = CGRectMake(CGRectGetMaxX(self.btnCollect.frame), 0, 158*kScaleX, 50);
        //        [self.btnChat addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        //        [self addSubview:self.btnChat];
        //        self.btnChat.tag = 2;
        
        self.btnTel = [ETSaleCollectBtn2 buttonWithType:UIButtonTypeCustom];
        //        [self.btnTel setImage:[UIImage imageNamed:@"sale_已收藏"] forState:UIControlStateSelected];
        [self.btnTel setImage:[UIImage imageNamed:@"sale_电话 copy"] forState:UIControlStateNormal];
        self.btnTel.titleLabel.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
        [self.btnTel setTitleColor:RGBCOLOR(195, 195, 195) forState:UIControlStateNormal];
        [self.btnTel setTitleColor:RGBCOLOR(248, 124, 43) forState:UIControlStateSelected];
        [self.btnTel setTitle:@"拨打电话" forState:UIControlStateNormal];
        [self.btnTel setTitle:@"收藏" forState:UIControlStateSelected];
        self.btnTel.frame = CGRectMake(Screen_Width-Screen_Width/6-79,0, 159*kScaleX, 50);
        [self.btnTel addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.fundusView addSubview:self.btnTel];
        self.btnTel.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.btnTel.tag = 3;
        
        
        //
//    [self.fundusView addSubview:self.collectBtn];
//    [_collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(5);
//        make.left.mas_equalTo(18);
//        make.size.mas_equalTo(CGSizeMake(24, 41));
//    }];
//    
//    [self.fundusView addSubview:self.chatBtn];
//    [_chatBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.right.mas_equalTo(-150);
//        make.size.mas_equalTo(CGSizeMake(150, 50));
//    }];
//    
//    [self.chatBtn addSubview:self.chatImg];
//    [_chatImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(14);
//        make.left.mas_equalTo(15);
//        make.size.mas_equalTo(CGSizeMake(25, 20));
//    }];
//    
//    [self.fundusView addSubview:self.callBtn];
//    [_callBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//        make.width.mas_equalTo(150);
//        make.height.mas_equalTo(50);
//    }];
//    
//    [self.callBtn addSubview:self.callImg];
//    [_callImg mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(14);
//        make.left.mas_equalTo(15);
//        make.size.mas_equalTo(CGSizeMake(25, 20));
//    }];
    }
    [self.view addSubview:scroll];
    [self shareView];
    [self shareViewController];
    [self maskEditView];
    [self getEditController];
}

- (void)clickAction:(UIButton *)btn{
    WeakSelf(self)
    switch (btn.tag) {
        case 1:
            [weakself collectAcion];
            break;
        case 2:
            [weakself chatAction];
            break;
        default:
            [weakself telAction];
            break;
    }
}

- (void)telAction{
    NSString *moblile = [MySingleton filterNull:self.detailInfo[@"linkmanMobil"]];
    if (moblile) {
        NSString *openUrl = [NSString stringWithFormat:@"tel://%@", moblile];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl] options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
            
        }
    }
}

#pragma mark 聊天
- (void)chatAction{
    UserInfoModel* m=[UserInfoModel loadUserInfoModel];
    ETProductModel* p=[ETProductModel mj_objectWithKeyValues:self.detailInfo];
    if ([m.uid isEqualToString:p.userId]) {
        return;
    }
    NSDictionary *params = @{
                             @"userId" : self.detailInfo[@"userId"]
                             };
    [IANshowLoading showLoadingForView:self.view];
    [HttpTool get:[NSString stringWithFormat:@"user/getJimAuroraName"] params:params success:^(id responseObj) {
        NSLog(@"");
        [IANshowLoading hideLoadingForView:self.view];
        NSDictionary* a=responseObj[@"data"];
        EaseUserModel* model=[EaseUserModel new];
        model.nickname=[a objectForKey:@"username"];
        model.avatarURLPath=[a objectForKey:@"img"];
        model.buddy=[a objectForKey:@"auroraName"];
        [model bg_saveOrUpdate];
        EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:[a objectForKey:@"auroraName"] conversationType:EMConversationTypeChat];
        chatController.title=[a objectForKey:@"auroraName"];
        [self.navigationController pushViewController:chatController animated:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [IANshowLoading hideLoadingForView:self.view];
    }];
}

#pragma mark 收藏
- (void)collectAcion{
    [IANshowLoading showLoadingForView:self.view];
    BOOL isCollect = [[MySingleton filterNull:self.detailInfo[@"isCollect"]] boolValue];
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             @"releaseId" : self.detailInfo[@"releaseId"]
                             };
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    WeakSelf(self);
    if (isCollect) {
        
        
        [HttpTool put:[NSString stringWithFormat:@"collect/myDel"] params:params success:^(NSDictionary *response) {
            [IANshowLoading hideLoadingForView:self.view];
            [MBProgressHUD showMBProgressHud:self.view withText:@"已取消" withTime:1];
            [weakself.detailInfo setObject:@(0) forKey:@"isCollect"];
//            [weakself.toolView refreshIsCollected:[[MySingleton filterNull:weakself.detailInfo[@"isCollect"]] boolValue]];
            NSLog(@"");
        } failure:^(NSError *error) {
            NSLog(@"");
            [IANshowLoading hideLoadingForView:self.view];
        }];
    }
    else{
        [HttpTool put:[NSString stringWithFormat:@"collect/myAdd"] params:params success:^(NSDictionary *response) {
            [IANshowLoading hideLoadingForView:self.view];
            [MBProgressHUD showMBProgressHud:self.view withText:@"已收藏" withTime:1];
            [weakself.detailInfo setObject:@(1) forKey:@"isCollect"];
//            [weakself.toolView refreshIsCollected:[[MySingleton filterNull:weakself.detailInfo[@"isCollect"]] boolValue]];
            NSLog(@"");
        } failure:^(NSError *error) {
            NSLog(@"");
            [IANshowLoading hideLoadingForView:self.view];
        }];
    }
}

-(void)tapAction:(id)tap

{
    
    NSLog(@"点击了tapView");
    //    ETVIPViewController* v=[ETVIPViewController new];
    ETViphuiyuanViewController* v=[ETViphuiyuanViewController new];
    [self.navigationController pushViewController:v animated:YES];
    
}
-(void)goshare
{
    [self.view addSubview:self.maskTheView];
    [self.view addSubview:self.shareView];
}
-(void)share
{
    UIImage *image = [UIImage imageNamed:@"res2.png"];
    UIImage* imageData = UIImageJPEGRepresentation(image, 0.7);
    
    WXImageObject *imageObject = [WXImageObject object];
    imageObject.imageData = imageData;
    
    WXMediaMessage *message = [WXMediaMessage message];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"res5"
                                                         ofType:@"jpg"];
    message.thumbData = [NSData dataWithContentsOfFile:filePath];
    message.mediaObject = imageObject;
    
    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneTimeline;
    [WXApi sendReq:req];
}
//分享微信方法
-(void)shareBtn
{
    UserInfoModel* info=[UserInfoModel loadUserInfoModel];
        if ([info.uid isEqualToString:_product.userId]) {
            [self moreEdit];
        }
        else{
    [self.view addSubview:self.maskTheView];
    [self.view addSubview:self.shareView];
        }
}

-(void)moreEdit
{
    [self.view addSubview:_maskEditView];
}
-(void)goedit
{
    if ([_product.releaseTypeId isEqualToString:@"1"]) {
        ETIssueViewController* issue=[ETIssueViewController new];
        issue.product=_product;
        [self.navigationController pushViewController:issue animated:YES];
    }
    else if ([_product.releaseTypeId isEqualToString:@"2"])
    {
        ETPublishPurchaseViewController* purchase=[ETPublishPurchaseViewController new];
        purchase.product=_product;
        [self.navigationController pushViewController:purchase animated:YES];
    }
    else if ([_product.releaseTypeId isEqualToString:@"3"])
    {
        ETPersuadersViewController* persua=[ETPersuadersViewController new];
        persua.product=_product;
        [self.navigationController pushViewController:persua animated:YES];
    }
    
}
- (void)clickImage {
    [self.maskTheView removeFromSuperview];
    [self.shareView removeFromSuperview];
}

- (void)clickImage1 {
    [self delfav1];
    _select=0;
    [self clickImage];

}

- (void)clickImage2 {
    [self delfav1];
    _select=1;
    [self clickImage];

}
- (UIView *)maskTheView{
    if (!_maskTheView) {
        _maskTheView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _maskTheView.backgroundColor = [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:0.5];
        //添加一个点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskClickGesture)];
        [_maskTheView addGestureRecognizer:tap];//让header去检测点击手势
    }
    return _maskTheView;
}
- (UIView *)maskEditView{
    if (!_maskEditView) {
        _maskEditView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width,140)];
        _maskEditView.backgroundColor = [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:0.5];
        //添加一个点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskClickGesture)];
        [_maskEditView addGestureRecognizer:tap];//让header去检测点击手势
    }
    return _maskEditView;
}

- (void)maskClickGesture {
    [self.maskTheView removeFromSuperview];
    [self.shareView removeFromSuperview];
        [self.maskEditView removeFromSuperview];
}

- (UIView *)shareView{
    if (!_shareView) {
        _shareView = [[UIView alloc]initWithFrame:CGRectMake(30, Screen_Height/2-80, Screen_Width-60,160)];
        _shareView.layer.cornerRadius=10;
        //        _shareView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        _shareView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
    }
    return _shareView;
}
- (void)shareViewController {
    UIButton *returnImage=[[UIButton alloc]initWithFrame:CGRectMake(0, 100, _shareView.size.width, 60)];
    [returnImage setTitle:@"取消" forState:UIControlStateNormal];
    [returnImage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)];
    [returnImage addGestureRecognizer:tapGesture];
    [_shareView addSubview:returnImage];
    
    UIView*centerView=[[UIView alloc]init];
    centerView.backgroundColor= [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:0.5];
    [_shareView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(1);
    }];
    
    UIButton *wxPyShare=[[UIButton alloc]initWithFrame:CGRectMake((_shareView.size.width-200)/2, 20, 40, 60)];
    [wxPyShare setImage:[UIImage imageNamed:@"分享_分组 4"] forState:UIControlStateNormal];
    UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage1)];
    [wxPyShare addGestureRecognizer:tapGesture1];
    [_shareView addSubview:wxPyShare];
    
    UIButton *wxPyqShare=[[UIButton alloc]initWithFrame:CGRectMake((_shareView.size.width+100)/2, 20, 40, 60)];
    [wxPyqShare setImage:[UIImage imageNamed:@"分享_分组 7"] forState:UIControlStateNormal];
    UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage2)];
    [wxPyqShare addGestureRecognizer:tapGesture2];
    [_shareView addSubview:wxPyqShare];
    
    
}

-(void)getEditController
{
    _edit=[UIButton new];
    [_edit setBackgroundImage:[UIImage imageNamed:@"edit_形状"] forState:UIControlStateNormal];
    [_edit setTitle:@"编辑" forState:UIControlStateNormal];
    [_edit.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_edit addTarget:self action:@selector(goedit) forControlEvents:UIControlEventTouchUpInside];
    [_maskEditView addSubview:_edit];
    
    [_edit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(30,30);
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(15);
    }];
    [_edit.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.size.mas_equalTo(30,60);
        make.bottom.mas_equalTo(_edit).offset(30);
        //        make.left.mas_equalTo(15);
    }];
    
    _moreshare=[UIButton new];
    [_moreshare setBackgroundImage:[UIImage imageNamed:@"商品_分组 14"] forState:UIControlStateNormal];
    [_moreshare setTitle:@"分享" forState:UIControlStateNormal];
    [_moreshare.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [_moreshare addTarget:self action:@selector(goshare) forControlEvents:UIControlEventTouchUpInside];
    
    [_maskEditView addSubview:_moreshare];
    [_moreshare mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(30,30);
        make.top.mas_equalTo(64);
        make.left.mas_equalTo(_edit.mas_right).offset(15);
    }];
    [_moreshare.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.size.mas_equalTo(30,60);
        make.bottom.mas_equalTo(_moreshare).offset(30);
        //        make.left.mas_equalTo(15);
    }];
}
-(void)delfav1
{
    //    NSMutableDictionary* dic=[NSMutableDictionary new];
    ETProductModel* p=[_products objectAtIndex:0];
    long long a=[p.releaseId longLongValue];
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* token=[user objectForKey:@"token"];
    NSDictionary *params = @{
                             @"id" : @(a)
                             };
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    
    [HttpTool get:[NSString stringWithFormat:@"user/shareReleaseById"] params:params success:^(NSDictionary *response) {
        _share=response[@"data"];
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        NSLog(@"");
//        [_tableView reloadData];
        if (_select==0) {
            
            [[WXApiManagerShare sharedManager] sendLinkContent:[[NSURL URLWithString:[NSString stringWithFormat:@"%@",_share]] absoluteString]
                                                         Title:self.title
                                                   Description:kShareDescText
                                                       AtScene:WXSceneSession];
        }
        if (_select==1) {
            
            [[WXApiManagerShare sharedManager] sendLinkContent:[[NSURL URLWithString:[NSString stringWithFormat:@"%@",_share]] absoluteString]
                                                         Title:self.title
                                                   Description:kShareDescText
                                                       AtScene:WXSceneTimeline];
        }
        [self clickImage];
    } failure:^(NSError *error) {
        NSLog(@"");
        
    }];
}

- (void)PostUI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             @"releaseId" : _releaseId
                             };
    [HttpTool get:[NSString stringWithFormat:@"release/releaseDetail"] params:params success:^(id responseObj) {
        if ([responseObj[@"msg"] containsString:@"次数已用尽"]) {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"免费查看次数已用尽！您可以选择充值会员来开启无限查看权限！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alter.delegate=self;
            [alter show];
            return;
        }
        _products=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        for (NSDictionary* prod in responseObj[@"data"]) {
            ETProductModel* p=[ETProductModel mj_objectWithKeyValues:prod];
            //            [_products addObject:p];
        }
        //        NSLog(@"");
        ETProductModel* p=[ETProductModel mj_objectWithKeyValues:a];
        _biaotiLab.text=p.title;
        
        CGFloat h= [PublicFunc textHeightFromString:p.detail width:Screen_Width-30 fontsize:18];
        _conLab.text=p.detail;
        [_conLab mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentLab.mas_bottom).with.offset(10);
            make.left.mas_equalTo(14);
            make.right.mas_equalTo(-16);
            make.height.mas_equalTo(h+10);
        }];
        float f=h-42+155;
        [_centerView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.jibenLab.mas_bottom).with.offset(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.height.mas_equalTo(f+10);
        }];
        _addLab.text=p.cityName;
        _nameLab.text=p.linkmanName;
        NSLog(@"");
        [_products addObject:p];
        
        [self PostInfoUI];
        self.detailInfo = [NSMutableDictionary dictionaryWithDictionary:responseObj[@"data"]];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)PostInfoUI
{
    ETProductModel* p=[_products objectAtIndex:0];
    
    NSDictionary *params = @{
                             @"uid" : p.userId
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"user/info"] params:params success:^(id responseObj) {
        if ([responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            return;
        }
        //        _products=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        UserInfoModel* info=[UserInfoModel mj_objectWithKeyValues:responseObj[@"data"][@"userInfo"]];
        _toUser=info;
        NSLog(@"");
        //        dispatch_async(dispatch_get_main_queue(), ^{
        //            //                [self showError:@"微信授权失败"];
        //            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:5];
        //            [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        //        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
