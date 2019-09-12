//
//  ETSaleDetailController.m
//  EasyTurn
//
//  Created by 程立 on 2019/7/29.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETProductDetailController.h"
#import "ProductInfoCell.h"
#import "SDCycleScrollView.h"
#import "ETProductModel.h"
#import "ETBuyPushViewController.h"
#import "WXApiManagerShare.h"
#import "DWTagList.h"
#import "UserMegViewController.h"
#import "ETVIPViewController.h"
#import "ETIssueViewController.h"
#import "ETPublishPurchaseViewController.h"
#import "ETPersuadersViewController.h"
#import "ETViphuiyuanViewController.h"
static NSString* const kShareButtonText = @"分享";
static NSString* const kShareDescText = @"分享一个链接";
static NSString* const kShareFailedText = @"分享失败";
@interface ETProductDetailController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) UIView *bigView;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic,strong) UIImageView *img;

//添加在头部视图的tempScrollView
@property (nonatomic, strong) UIScrollView *tempScrollView;
//记录底部空间所需的高度
@property (nonatomic, assign) CGFloat bottomHeight;
@property (nonatomic, strong) NSArray *detailTitles;
@property (nonatomic, strong) SDCycleScrollView *cycleScrollView;
///轮播图数组
@property (nonatomic, strong) NSArray *imageGroupArray;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic, assign) CGFloat labelHeight;
@property (nonatomic, strong) UserInfoModel *toUser;
//提示框
@property (nonatomic,strong) UIView * maskTheView;
@property (nonatomic,strong) UIView * shareView;
@property (nonatomic,strong) NSString *share;

@property (nonatomic,assign)int select;

@property (nonatomic, strong) UIButton* fav;

@property (nonatomic,strong) UIView * maskEditView;
//编辑分享
@property (nonatomic, strong) UIButton* edit;
@property (nonatomic, strong) UIButton* moreshare;

@end

@implementation ETProductDetailController

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
- (void)clickImage {
    [self.maskTheView removeFromSuperview];
    [self.shareView removeFromSuperview];
}

- (void)clickImage1 {
      [self delfav1];
    _select=0;
}

- (void)clickImage2 {
    [self delfav1];
    _select=1;
}

-(void)titleBtnClick:(UIButton *)btn
{
//    if (btn!= _wxBtn) {
//        self.wxBtn.selected = NO;
//        btn.selected = YES;
//        self.wxBtn = btn;
//    }else{
//        self.wxBtn.selected = YES;
//        _paytype=2;
//    }
//    if (btn!= _zfbBtn) {
//        self.zfbBtn.selected = NO;
//        btn.selected = YES;
//        self.zfbBtn = btn;
//    }else{
//        self.zfbBtn.selected = YES;
//        _paytype=1;
//    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self enableLeftBackButton];
    [self setBgUI];
    [self setHeaderAndFooterView];
    [self setBottomView];
    [self setUpLeftTwoButton];
    self.navigationController.navigationBarHidden=NO;
    _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width/2, TopHeight)];
    _navigationView.backgroundColor = kACColorClear;
    [self.view addSubview:_navigationView];
    _leftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _leftButton.frame = CGRectMake(15, StatusBarHeight+15, 30, 30);
    //    [_leftButton setBackgroundColor:[UIColor blueColor]];
    [_leftButton setImage:[UIImage imageNamed:@"商品_分组 7"] forState:(UIControlStateNormal)];
    [_leftButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_navigationView addSubview:_leftButton];
    // Do any additional setup after loading the view.
    
    CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
//    [tabbar.tabBar setBackgroundImage:img];
//    [tabbar.tabBar setShadowImage:img];
//    [tabbar.tabBar setBackgroundColor:[UIColor whiteColor]];
    
    [self PostUI];
    [self shareView];
    [self shareViewController];
    [self maskEditView];
    [self getEditController];
}
#pragma mark - 动态列表
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
        if ([responseObj[@"data"] isKindOfClass:[NSNull class]]) {
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
        //
        NSMutableArray* imgs=[NSMutableArray new];
        if (p.imageList) {
            [imgs addObject:p.imageList];
        }
        self.imageGroupArray=imgs;
        //
        NSString *str = [NSString string];
        _labelHeight = [p.business boundingRectWithSize:CGSizeMake(Screen_Width, MAXFLOAT)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}
                                        context:nil].size.height;
            NSLog(@"");
        [_products addObject:p];
        if ([p.isCollect isEqualToString:@"1"]) {
            _fav.selected=YES;
        }
        [self PostInfoUI];
        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)setBgUI
{
    _bottomHeight = 40;
    
    //存放tableView和webView，tableview在上面，webview在下面
    _bigView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    _bigView.backgroundColor = kACColorWhite;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,kStatusBarHeight, Screen_Width, Screen_Height-kStatusBarHeight)];
    if (IPHONE_X) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,kStatusBarHeight, Screen_Width, Screen_Height-60)];
    }
    _tableView.backgroundColor = kACColorWhite;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.bounces = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"ProductInfoCell" bundle:nil] forCellReuseIdentifier:@"productinfocell"];
    //去掉顶部偏移
    if (@available(iOS 11.0, *))
    {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self.view addSubview:_bigView];
    [_bigView addSubview:_tableView];
    
    
}

- (void)setHeaderAndFooterView{
    
    //添加头部和尾部视图
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 218)];
    headerView.backgroundColor = kACColorWhite;
    
    _tempScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 218)];
    [headerView addSubview:_tempScrollView];
    
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 218)];
    _headerImageView.contentMode = UIViewContentModeScaleAspectFit;
    _headerImageView.image = _image;
//    [_tempScrollView addSubview:_headerImageView];
    
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Screen_Width, 218) delegate:self placeholderImage:nil];
    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    _cycleScrollView.autoScrollTimeInterval = 5.0;
    [_tempScrollView addSubview:_cycleScrollView];
//    [_cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(218);
//    }];
    //
    
    UIButton* share=[UIButton new];
    [share setBackgroundImage:[UIImage imageNamed:@"详情_分组8"] forState:UIControlStateNormal];
    [_cycleScrollView addSubview:share];
    [share addTarget:self action:@selector(shareBtn) forControlEvents:UIControlEventTouchUpInside];
    [share mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12+10);
        make.right.mas_equalTo(-12);
        make.width.height.mas_equalTo(25);
    }];
    
    UIButton* fav=[UIButton new];
    [fav setBackgroundImage:[UIImage imageNamed:@"详情_分组13"] forState:UIControlStateNormal];
    [fav setBackgroundImage:[UIImage imageNamed:@"detilscollectiont"] forState:UIControlStateSelected];
    _fav=fav;
    [_cycleScrollView addSubview:fav];
    [fav addTarget:self action:@selector(fav:) forControlEvents:UIControlEventTouchUpInside];
    [fav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12+10);
        make.right.mas_equalTo(-12-25-9);
        make.width.height.mas_equalTo(25);
    }];
    
    _tableView.tableHeaderView = headerView;
    
    NSArray* imgs=@[@"https://yizhuanvip.oss-cn-beijing.aliyuncs.com/banner/a6c0631bb287b8a59a3264ec9e13258.jpg",@"https://yizhuanvip.oss-cn-beijing.aliyuncs.com/banner/b98137ff7fb5f6a2a23de55d9607d59.jpg"];
    self.imageGroupArray=imgs;
    
    UILabel *pullMsgView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    pullMsgView.textAlignment = NSTextAlignmentCenter;
    pullMsgView.text = @"上拉显示网页";
    pullMsgView.textColor = kACColorBlack;
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    [footView addSubview:pullMsgView];
    
//    _tableView.tableFooterView = footView;
    
    //设置下拉提示视图
    UILabel *downPullMsgView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    downPullMsgView.textAlignment = NSTextAlignmentCenter;
    downPullMsgView.text = @"下拉显示列表";
    downPullMsgView.textColor = kACColorBlack;
    
    UIView *downMsgView = [[UIView alloc] initWithFrame:CGRectMake(0, -40, Screen_Width, 40)];
    [downMsgView addSubview:downPullMsgView];
    [_webView.scrollView addSubview:downMsgView];
}

- (void)setBottomView
{
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height - _bottomHeight, Screen_Width, _bottomHeight)];
    _bottomView.backgroundColor = kACColorBackgroundGray;
    _tableView.tableFooterView=_bottomView;
    
    UIView* add=[UIView new];
    add.frame=CGRectMake(_bottomView.mj_w/2, 0, _bottomView.mj_w/4, _bottomHeight);
    add.backgroundColor= RGBCOLOR(60, 138, 239);
    
    UIButton *addButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    addButton.frame = CGRectMake(_bottomView.mj_w/4-_bottomHeight-10, 5, _bottomHeight-10, _bottomHeight-10);
    addButton.backgroundColor = RGBCOLOR(60, 138, 239);
//    addButton.titleLabel.font = SYSTEMFONT(16);
//    [addButton setTitle:@"联系人:张先生" forState:(UIControlStateNormal)];
//    [addButton setTitleColor:kACColorWhite forState:(UIControlStateNormal)];
    [addButton setBackgroundImage:[UIImage imageNamed:@"detail_分组_6"] forState:UIControlStateNormal];
    addButton.tag=0;
    [addButton addTarget:self action:@selector(addAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [add addSubview:addButton];
    
    //
    UIView* msg=[UIView new];
    msg.frame=CGRectMake(0, 0, _bottomHeight, _bottomHeight);;
    msg.backgroundColor=kACColorBackgroundGray;
    
    //
    UIButton *msgButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    msgButton.frame = CGRectMake(5, 5, _bottomHeight-10, _bottomHeight-10);
    msgButton.backgroundColor = kACColorBackgroundGray;
    [msgButton setBackgroundImage:[UIImage imageNamed:@"detail_icon_聊天"] forState:UIControlStateNormal];
    msgButton.tag=0;
    [msgButton addTarget:self action:@selector(addAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [msg addSubview:msgButton];
    
    [add addSubview:msg];
    [_bottomView addSubview:add];
    
    UIButton *addimButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    addimButton.frame = CGRectMake(_bottomView.mj_w*3/4, 0, _bottomView.mj_w/4, _bottomHeight);
    addimButton.backgroundColor = RGBCOLOR(60, 138, 239);
    addimButton.titleLabel.font = SYSTEMFONT(16);
    [addimButton setTitle:@"联系商家" forState:(UIControlStateNormal)];
    [addimButton setTitleColor:kACColorWhite forState:(UIControlStateNormal)];
    addimButton.tag=1;
    [addimButton addTarget:self action:@selector(addAction1) forControlEvents:(UIControlEventTouchUpInside)];
    [_bottomView addSubview:addimButton];
    
}
-(void)addAction1
{
    ETProductModel* p=[_products objectAtIndex:0];
    if (p.linkmanMobil) {
        NSString *openUrl = [NSString stringWithFormat:@"tel://%@", p.linkmanMobil];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl] options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];

    }
    }
}
-(void)addAction:(id)sender
{
    [self getJimName];
    ETProductModel* p=[_products objectAtIndex:0];
//    EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:p.userId conversationType:EMConversationTypeChat];
//    [self.navigationController pushViewController:chatController animated:YES];
}
-(void)getJimName
{
    ETProductModel* p=[_products objectAtIndex:0];
    long long uid=[p.userId longLongValue];
    NSDictionary *params = @{
                             @"userId" : @(uid)
                             };
    [HttpTool get:[NSString stringWithFormat:@"user/getJimAuroraName"] params:params success:^(id responseObj) {
        NSLog(@"");
            NSDictionary* a=responseObj[@"data"];
        EaseUserModel* model=[EaseUserModel new];
        model.nickname=[a objectForKey:@"username"];
        model.avatarURLPath=[a objectForKey:@"img"];
        model.buddy=[a objectForKey:@"auroraName"];
        [model bg_saveOrUpdate];

            EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:[a objectForKey:@"auroraName"] conversationType:EMConversationTypeChat];
        chatController.title=[a objectForKey:@"auroraName"];
            [self.navigationController pushViewController:chatController animated:YES];
//        NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
//        NSDictionary* a=responseObj[@"data"];
//        [user setObject:[a objectForKey:@"auroraName"] forKey:@"huanxin"];
//        [user synchronize];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - 收藏 购物车
- (void)setUpLeftTwoButton
{
    UserInfoModel* info=[UserInfoModel loadUserInfoModel];
    if (!info.vip) {
        UIView* view=[[UIView alloc] init];
        view.backgroundColor=kACColorWhite;
        UILabel* lab=[[UILabel alloc] initWithFrame:CGRectMake(10, 5, Screen_Width-20, 30)];
        lab.font=[UIFont systemFontOfSize:18];
        lab.textAlignment=UITextAlignmentCenter;
        lab.text=@"加入易转会员,直接联系卖家";
        [view addSubview:lab];
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        
            [view addGestureRecognizer:tapGesturRecognizer];
        [_bottomView addSubview:view];
        
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(_bottomView);
            make.width.height.mas_equalTo(_bottomView);
        }];
        
    }
    else{
    NSArray *imagesNor = @[@"tabr_07shoucang_up"];
    NSArray *imagesSel = @[@"tabr_07shoucang_down",@"ptgd_icon_xiaoxi",@"tabr_08gouwuche"];
    CGFloat buttonW = Screen_Width * 0.15;
    CGFloat buttonH = _bottomHeight;
    CGFloat buttonY = Screen_Height - buttonH;
    
    for (NSInteger i = 0; i < imagesNor.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:imagesNor[i]] forState:UIControlStateNormal];
        button.backgroundColor = kACColorBackgroundGray;
        [button setImage:[UIImage imageNamed:imagesSel[i]] forState:UIControlStateSelected];
        button.tag = i;
        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonX = (buttonW * i);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
//        [self.view addSubview:button];
        UILabel* label=[UILabel new];
        label.frame=CGRectMake(20, 0, _bottomView.mj_w/2-20, buttonH);;
        label.text=@"联系人:张先生";
        if (_product.linkmanName) {
            label.text=[NSString stringWithFormat:@"联系人:%@",_product.linkmanName];
        }
        [_bottomView addSubview:label];
    }
    }
}
-(void)tapAction:(id)tap

{
    
    NSLog(@"点击了tapView");
//    ETVIPViewController* v=[ETVIPViewController new];
    ETViphuiyuanViewController* v=[ETViphuiyuanViewController new];
    [self.navigationController pushViewController:v animated:YES];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0) {
//        ETVIPViewController* v=[ETVIPViewController new];
        ETViphuiyuanViewController* v=[ETViphuiyuanViewController new];

        [self.navigationController pushViewController:v animated:YES];
    }
}
- (void)setImageGroupArray:(NSArray *)imageGroupArray{
    _imageGroupArray = imageGroupArray;
    _cycleScrollView.placeholderImage = [UIImage imageNamed:@"首页_轮播占位图"];
    if (imageGroupArray.count == 0) return;
    _cycleScrollView.imageURLStringsGroup = _imageGroupArray;    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.y;

    if (scrollView == _tableView){
        //重新赋值，就不会有用力拖拽时的回弹
//        _tempScrollView.contentOffset = CGPointMake(_tempScrollView.contentOffset.x, 0);
        if (offset >= TopHeight && offset <= Screen_Width) {
            _leftButton.hidden=YES; //因为tempScrollView是放在tableView上的，tableView向上速度为1，实际上tempScrollView的速度也是1，此处往反方向走1/2的速度，相当于tableView还是正向在走1/2，这样就形成了视觉差！
//            _tempScrollView.contentOffset = CGPointMake(_tempScrollView.contentOffset.x, - offset / 2.0f);
        }
        else
            _leftButton.hidden=NO;
    }

}
//
//#pragma mark -- 监听滚动实现商品详情与图文详情界面的切换
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//
//    WeakSelf(self);
//    CGFloat offset = scrollView.contentOffset.y;
//    if (scrollView == _tableView) {
//        if (offset > _tableView.contentSize.height - Screen_Height + self.bottomHeight + 50) {
//            [UIView animateWithDuration:0.4 animations:^{
//                weakself.bigView.transform = CGAffineTransformTranslate(weakself.bigView.transform, 0, -Screen_Height +  self.bottomHeight + TopHeight);
//            } completion:^(BOOL finished) {
//
//            }];
//        }
//        //        [_basecontroller.segmentedControl didSelectIndex:1];
//    }
//    if (scrollView == _webView.scrollView) {
//        if (offset < -50) {
//            [UIView animateWithDuration:0.4 animations:^{
//                [UIView animateWithDuration:0.4 animations:^{
//                    weakself.bigView.transform = CGAffineTransformIdentity;
//
//                }];
//            } completion:^(BOOL finished) {
//
//            }];
//        }
//        //        [_basecontroller.segmentedControl didSelectIndex:1];
//
//    }
//}

#pragma mark -- UITableViewDelegate & dataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section==1){
        return 1;
    }
    else if(section==3){
    ETProductModel* p=[_products objectAtIndex:0];
    if ([p.releaseTypeId isEqualToString:@"3"]) {
        return 1;
    }
        return 3;
    }
    else if(section==4){
        ETProductModel* p=[_products objectAtIndex:0];
        if ([p.releaseTypeId isEqualToString:@"3"]) {
            return 0;
        }
        return 2;
    }
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        return 100;
    }
    else if (indexPath.section==1&&indexPath.row!=0){
        return 80;
    }
    else if (indexPath.section==1&&indexPath.row==0){
        return 40;
    }
    else if (indexPath.section==2) {
        if (_labelHeight) {
            return _labelHeight+63;
        }
        else
        {
            ETProductModel* p=[_products objectAtIndex:0];
            if ([p.releaseTypeId isEqualToString:@"3"]) {
                return 0;
            }
            else
                return 80;
        }
    }
    else if (indexPath.section==4) {
        if (indexPath.row==0) {
//            ETProductModel* p=[_products objectAtIndex:0];
//            if ([p.releaseTypeId isEqualToString:@"3"]) {
//                return 0;
////            }else if ([p.releaseTypeId isEqualToString:@"2"]) {
////                return 0;
////            }
////            return 80;
////        }else if (indexPath.row ==1) {
////            ETProductModel* p=[_products objectAtIndex:0];
////            if ([p.releaseTypeId isEqualToString:@"3"]) {
////                return 0;
////            }else if ([p.releaseTypeId isEqualToString:@"2"]) {
////                return 0;
//            }
            return 80;
        }
        else{
        return 160;
        }
    }
    else{
        return 60;
    }
}
//设置分区尾视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section>0) {
        if (section==5) {
            return 0.01;
        }
        else
            return 10;
    }
    else{
        return 0.01;
    }
}
//设置分区头视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0.01;
}
//设置分区的尾视图
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 10)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    //    if (!cell) {
    
    if (indexPath.section==0) {
        
//        ProductInfoCell *cell=[_tableView dequeueReusableCellWithIdentifier:@"productinfocell"];
        ProductInfoCell* cell=[[NSBundle mainBundle]loadNibNamed:@"ProductInfoCell" owner:self options:nil].firstObject;
        ETProductModel* p=[_products objectAtIndex:0];

        cell.titleLabel.text=p.title;
         cell.selectionStyle = UITableViewCellSelectionStyleNone;  
        cell.titleLabel.numberOfLines=0;
        //
        NSString*str=p.price;
        double a=[str doubleValue];
        if (a>=10000.0) {
            cell.oPriceLabel.text=[NSString stringWithFormat:@"¥%.0f万",a/10000.0];
        }
        else
        {
            float pp =[str intValue];
            cell.oPriceLabel.text=[NSString stringWithFormat:@"¥%.2f",pp];
        }
//        cell.priceLabel.text=[NSString stringWithFormat:@"价格:￥%@",@""];
        [cell.tradeBtn addTarget:self action:@selector(tiao) forControlEvents:UIControlEventTouchUpInside];
        UserInfoModel* m=[UserInfoModel loadUserInfoModel];
        if ([m.uid isEqualToString:p.userId]) {
//            cell.tradeBtn.enabled=NO;
//            [cell.tradeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            cell.tradeBtn.hidden=YES;
        }
        //
        DWTagList* tagList = [[DWTagList alloc] initWithFrame:CGRectMake(20.0f, cell.titleLabel.maxY +15.0f, Screen_Width-92, 30.0f)];
        NSMutableArray* tags=[NSMutableArray new];
        if ([p.serviceId isEqualToString:@"0"]) {
            [tags addObject:@"综合"];
        }
        else if ([p.serviceId isEqualToString:@"1"])
        {
            [tags addObject:@"工商"];
        }
        else if ([p.serviceId isEqualToString:@"2"])
        {
            [tags addObject:@"财税"];
        }
        else if ([p.serviceId isEqualToString:@"3"])
        {
            [tags addObject:@"行政"];
        }
        else if ([p.serviceId isEqualToString:@"4"])
        {
            [tags addObject:@"金融"];
        }
        else if ([p.serviceId isEqualToString:@"5"])
        {
            [tags addObject:@"资质"];
        }
        else if ([p.serviceId isEqualToString:@"6"])
        {
            [tags addObject:@"疑难"];
        }
        if (p.cityName) {
            [tags addObject:p.cityName];
        }
        if ([p.releaseTypeId isEqualToString:@"3"]) {
            [tags addObject:@"企服者"];
        }
        NSArray *array = [[NSArray alloc] initWithObjects:@"Foo", @"Tag Label 1", @"Tag Label 2", nil];
        [tagList setTags:[tags copy]];
        [cell.contentView addSubview:tagList];
        return cell;
    }
    else{
        UITableViewCell* cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //    }
        
        cell.textLabel.font = SYSTEMFONT(16);
        cell.textLabel.textColor = kACColorBlack;
        cell.textLabel.text = [_detailTitles objectAtIndex:indexPath.row+indexPath.section];
    if (indexPath.section==2) {
        ETProductModel* p=[_products objectAtIndex:0];
        cell.textLabel.text=@"经营范围";
        
        cell.detailTextLabel.numberOfLines=0;
        cell.detailTextLabel.text=@"转让北京现成资质14项房建总包三级，市政";
//        ETProductModel* p=[_products objectAtIndex:0];
        cell.detailTextLabel.text=p.business;
        if ([p.releaseTypeId isEqualToString:@"3"]) {
            cell.textLabel.text=@"详细内容";
            cell.detailTextLabel.text=p.detail;

        }
    }
    if (indexPath.section==3) {
        cell.textLabel.text=@"注册时间";
        cell.detailTextLabel.text=@"2019-06-19";
        ETProductModel* p=[_products objectAtIndex:0];
        cell.detailTextLabel.text=p.releaseTime;
        if (indexPath.row==1) {
            cell.textLabel.text=@"注册地址";
            cell.detailTextLabel.text=@"2019-06-19";
            cell.detailTextLabel.text=p.cityName;
        }
        if (indexPath.row==2) {
            cell.textLabel.text=@"纳税类型";
            cell.detailTextLabel.text=@"2019-06-19";
            if ([p.taxId isEqualToString:@"1"]) {
                cell.detailTextLabel.text=@"一般纳税人";
            }
            if ([p.taxId isEqualToString:@"2"]) {
                cell.detailTextLabel.text=@"小规模";
            }
            if ([p.taxId isEqualToString:@"3"]) {
                cell.detailTextLabel.text=@"小规模";
            }
            if ([p.taxId isEqualToString:@"4"]) {
                cell.detailTextLabel.text=@"一般纳税人";
            }
            
        }
    }
    if (indexPath.section==4&&indexPath.row==0) {
        ETProductModel* p=[_products objectAtIndex:0];
        cell.textLabel.text=@"附带资产";
        cell.detailTextLabel.text=@"";
        if (p.asset) {
            cell.detailTextLabel.text=p.asset;

        }
    }
    if (indexPath.section==4&&indexPath.row==1) {
        ETProductModel* p=[_products objectAtIndex:0];
        cell.textLabel.text=@"其他信息";
        cell.detailTextLabel.text=@"我们单位现在有多家现成资质转让可以量身定";
        if (p.information) {
            cell.detailTextLabel.text=p.information;
        }
    }
    if (indexPath.section==5) {
        ETProductModel *p=[_products objectAtIndex:0];
       
        cell.imageView.image=[UIImage imageNamed:@"我的_Bitmap"];
        if (_toUser.portrait) {
//            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_toUser.portrait]];
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_toUser.portrait] placeholderImage:[UIImage imageNamed:@"11566120515_.pic_hd"]];
        }
//        _img=cell.imageView.image;
        cell.textLabel.text=[NSString stringWithFormat:@"%@",_toUser.name];
        cell.detailTextLabel.text=@"易转科技";
    }
    return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==5) {
        UserMegViewController *megVC=[[UserMegViewController alloc]init];
        megVC.name=_toUser.name;
        megVC.photoImg=_toUser.portrait;
        [MySingleton sharedMySingleton].toUserid=_toUser.uid;
        [self presentViewController:megVC animated:YES completion:nil];

    }
}
- (void)tiao {
    ETBuyPushViewController *buy =[[ETBuyPushViewController alloc]init];
    buy.product=_products[0];
    ETProductModel* p=_products[0];
    buy.releaseId=p.releaseId;
    [self.navigationController pushViewController:buy animated:YES];
    
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
-(void)goshare
{
        [self.view addSubview:self.maskTheView];
        [self.view addSubview:self.shareView];
}
#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: // 转发到会话
            [[WXApiManagerShare sharedManager] sendLinkContent:[[NSURL URLWithString:[NSString stringWithFormat:@"%@",_share]] absoluteString]
                                                    Title:self.title
                                              Description:kShareDescText
                                                  AtScene:WXSceneSession];
            break;
        case 1: //分享到朋友圈
            [[WXApiManagerShare sharedManager] sendLinkContent:[[NSURL URLWithString:[NSString stringWithFormat:@"%@",_share]] absoluteString]
                                                    Title:self.title
                                              Description:kShareDescText
                                                  AtScene:WXSceneTimeline];
            break;
        default:
            break;
    }
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
        [_tableView reloadData];
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
    } failure:^(NSError *error) {
        NSLog(@"");
        
    }];
}
#pragma mark - 添加收藏
-(void)fav:(UIButton*)sender
{
   
    if(sender.selected)
        [self delfav];
    else{
    NSMutableDictionary* dic=[NSMutableDictionary new];
    long long a=[_releaseId longLongValue];
    NSDictionary *params = @{
                             @"releaseId" : @(a)
                             };
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    
    [HttpTool put:[NSString stringWithFormat:@"collect/myAdd"] params:params success:^(NSDictionary *response) {
//        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
           [MBProgressHUD showMBProgressHud:self.view withText:@"已收藏" withTime:1];
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"");
    }];
    }
    sender.selected=!sender.selected;
}

#pragma mark - 删除收藏
-(void)delfav
{
    NSMutableDictionary* dic=[NSMutableDictionary new];
    int a=[_releaseId doubleValue];
    NSDictionary *params = @{
                             @"releaseId" : @(a)
                             };
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    
    [HttpTool put:[NSString stringWithFormat:@"collect/myDel"] params:params success:^(NSDictionary *response) {
//        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
           [MBProgressHUD showMBProgressHud:self.view withText:@"取消收藏" withTime:1];
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"");
        
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
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //                [self showError:@"微信授权失败"];
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:5];
            [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.section==0) {
//        ETBuyPushViewController *buy =[[ETBuyPushViewController alloc]init];
//        [self.navigationController pushViewController:buy animated:YES];
//    }
//}
@end
