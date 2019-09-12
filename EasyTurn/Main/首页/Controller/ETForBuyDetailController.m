//
//  ETForBuyDetailController.m
//  EasyTurn
//
//  Created by 刘盖 on 2019/9/5.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETForBuyDetailController.h"
#import "IANshowLoading.h"
#import "ETSaleDetailHeaderView.h"

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
#import "WXApiManagerShare.h"
#import "EaseTextView.h"
static NSString* const kShareButtonText = @"分享";
static NSString* const kShareDescText = @"分享一个链接";
static NSString* const kShareFailedText = @"分享失败";
@interface ETForBuyDetailController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) UIButton *btnBack;
@property (nonatomic,strong) UIButton *btnRight;
@property (nonatomic,strong) UILabel *labelTitle;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) ETSaleDetailBotToolView *toolView;
@property (nonatomic,strong) UIView * maskEditView;
@property (nonatomic,strong) NSMutableDictionary *detailInfo;
@property (nonatomic, strong) UserInfoModel *toUser;

@property (nonatomic,strong) UIView * maskTheView;
@property (nonatomic,strong) UIView * shareView;
@property (nonatomic,strong) NSString *share;

@property (nonatomic,assign)int select;

//编辑分享
@property (nonatomic, strong) UIButton* edit;
@property (nonatomic, strong) UIButton* moreshare;
@end

@implementation ETForBuyDetailController

+ (instancetype)forBuyDetailController:(NSDictionary *)detailInfo{
    ETForBuyDetailController *vc = [[self alloc] init];
    vc.detailInfo = [NSMutableDictionary dictionaryWithDictionary:detailInfo];
    return vc;
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
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"求购详情";
    self.title=@"求购详情";
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = RGBACOLOR(242, 242, 242, 1);
    self.tableView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height-50-BottomSafeHeightGap);
    [self setupNav];
    WeakSelf(self);
    self.toolView = [ETSaleDetailBotToolView detailBotToolView:^(NSInteger clickTag) {
        switch (clickTag) {
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
    }];
    self.toolView.blockvip = ^{
        [self vipAction];
    };
    [self.view addSubview:self.toolView];
    [self.toolView refreshIsCollected:[[MySingleton filterNull:self.detailInfo[@"isCollect"]] boolValue]];
    
    self.tableView.tableHeaderView = [ETSaleDetailHeaderView forBuyDetailHeaderView:self.detailInfo click:^{
        UserInfoModel* m=[UserInfoModel loadUserInfoModel];
        ETProductModel* p=[ETProductModel mj_objectWithKeyValues:self.detailInfo];
        if ([m.uid isEqualToString:p.userId]) {
            return;
        }
        ETBuyPushViewController *buy =[[ETBuyPushViewController alloc]init];
        buy.product = [ETProductModel mj_objectWithKeyValues:weakself.detailInfo];
        buy.releaseId= weakself.detailInfo[@"releaseId"];
        [weakself.navigationController pushViewController:buy animated:YES];
    }];
    [self requestData:YES];
    [self PostInfoUI];
    
    [self shareView];
    [self shareViewController];
    [self maskEditView];
    [self getEditController];
    UserInfoModel* info=[UserInfoModel loadUserInfoModel];
    if ([info.uid isEqualToString:_product.userId]) {
        self.toolView.hidden=YES;
    }
}
-(void)vipAction
{
    
    NSLog(@"点击了tapView");
    //    ETVIPViewController* v=[ETVIPViewController new];
    ETViphuiyuanViewController* v=[ETViphuiyuanViewController new];
    [self.navigationController pushViewController:v animated:YES];
    
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
#if __IPHONE_OS_VERSION_MAX_ALLOWED>=__IPHONE_11_0
        if (@available(iOS 11.0, *)) {
            [_tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
#endif
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 0)];
        //        WeakSelf(self);
        //        _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        //            [weakself requestData:YES];
        //        }];
    }
    return _tableView;
}

- (void)setupNav{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(7, StatusBarHeight+7, 44, 44);
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateSelected];
    //    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [btn addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    self.btnBack = btn;
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(Screen_Width-44-7, StatusBarHeight+7, 25, 25);
    [btn setImage:[UIImage imageNamed:@"WechatIMG23"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"WechatIMG23"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:@"WechatIMG23"] forState:UIControlStateSelected];
    //    [btn setImageEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 0)];
    [btn addTarget:self action:@selector(shareBtn) forControlEvents:UIControlEventTouchUpInside];
    self.btnRight = btn;
    
    self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.btnBack.frame)+10, CGRectGetMinY(self.btnBack.frame), CGRectGetMinX(self.btnRight.frame)-CGRectGetMaxX(self.btnBack.frame)-20, 44)];
    self.labelTitle.textColor = [UIColor whiteColor];
    self.labelTitle.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    self.labelTitle.textAlignment = NSTextAlignmentCenter;
    self.labelTitle.text = @"求购详情";
    
    [self.view addSubview:self.btnBack];
    //    [self.view addSubview:self.labelTitle];
    [self.view addSubview:self.btnRight];
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
        WeakSelf(self);
        //        [MySingleton showAlertWithIsActionSheet:NO title:nil msg:@"分享一次赠送刷新次数6次(每天10次机会)" btnTitles:@[@"确定"] vc:self click:^(NSInteger tag) {
        //            [weakself.view addSubview:weakself.maskTheView];
        //            [weakself.view addSubview:weakself.shareView];
        //        }];
        [weakself.view addSubview:weakself.maskTheView];
        [weakself.view addSubview:weakself.shareView];
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
        _shareView = [[UIView alloc]initWithFrame:CGRectMake(30, Screen_Height/2-80, Screen_Width-60,200)];
        _shareView.layer.cornerRadius=10;
        //        _shareView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        _shareView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    return _shareView;
}
- (void)shareViewController {
    UIButton *returnImage=[[UIButton alloc]initWithFrame:CGRectMake(0, 140, _shareView.size.width, 60)];
    [returnImage setTitle:@"取消" forState:UIControlStateNormal];
    [returnImage setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)];
    [returnImage addGestureRecognizer:tapGesture];
    [_shareView addSubview:returnImage];
    UIView*centerView=[[UIView alloc]init];
    centerView.backgroundColor= [UIColor colorWithRed:230/255.f green:230/255.f blue:230/255.f alpha:0.5];
    [_shareView addSubview:centerView];
    [centerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(140);
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
    
    UILabel* label=[[UILabel alloc] initWithFrame:CGRectMake(10, 100, _shareView.frame.size.width-20, 40)];
    label.text=@"分享一次赠送刷新次数6次(每天10次机会)";
    label.font = SYSTEMFONT(13);
    label.textColor=[UIColor redColor];
    label.textAlignment=UITextAlignmentCenter;
    [_shareView addSubview:label];
    
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
    ETProductModel* p=[ETProductModel mj_objectWithKeyValues:self.detailInfo];
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
- (void)leftAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightAction{
    
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
    [self sendMsgToBuyer];
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
            [weakself.toolView refreshIsCollected:[[MySingleton filterNull:weakself.detailInfo[@"isCollect"]] boolValue]];
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
            [weakself.toolView refreshIsCollected:[[MySingleton filterNull:weakself.detailInfo[@"isCollect"]] boolValue]];
            NSLog(@"");
        } failure:^(NSError *error) {
            NSLog(@"");
            [IANshowLoading hideLoadingForView:self.view];
        }];
    }
}
- (void)sendMsgToBuyer {
    NSDictionary *params = @{
                             @"releaseId" : self.detailInfo[@"releaseId"]
                             };
    [HttpTool get:[NSString stringWithFormat:@"release/sendMsgToBuyer"] params:params success:^(id responseObj) {

        NSLog(@"");

    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)requestData:(BOOL)isHeader{
    if (isHeader) {
        [IANshowLoading showLoadingForView:self.view];
        [self.tableView reloadData];
    }
    WeakSelf(self);
    NSDictionary *params = @{
                             @"releaseId" : self.detailInfo[@"releaseId"]
                             };
    [HttpTool get:[NSString stringWithFormat:@"release/releaseDetail"] params:params success:^(id responseObj) {
        [IANshowLoading hideLoadingForView:self.view];
        if ([responseObj[@"msg"] containsString:@"次数已用尽"]) {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"免费查看次数已用尽！您可以选择充值会员来开启无限查看权限！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alter.delegate=self;
            [alter show];
            return;
        }
        if ([responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            return;
        }
        weakself.detailInfo = [NSMutableDictionary dictionaryWithDictionary:responseObj[@"data"]];
        [weakself.toolView refreshIsCollected:[[MySingleton filterNull:weakself.detailInfo[@"isCollect"]] boolValue]];
        
        //
        UserInfoModel* m=[UserInfoModel loadUserInfoModel];
        ETProductModel* p=[ETProductModel mj_objectWithKeyValues:self.detailInfo];
        if ([m.uid isEqualToString:p.userId]) {
            [self.btnRight setImage:[UIImage imageNamed:@"sale_更多"] forState:UIControlStateNormal];
        }
        [weakself.tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [IANshowLoading hideLoadingForView:self.view];
    }];
    //    WeakSelf(self);
    //    NSDictionary *params = @{
    //                             @"releaseTypeId":@(2)
    //                             };
    //
    //    [HttpTool get:[NSString stringWithFormat:@"release/releaseList"] params:params success:^(id responseObj) {
    //        [weakself handleData:responseObj isFailed:NO];
    //        NSLog(@"%@",responseObj);
    //    } failure:^(NSError *error) {
    //        NSLog(@"%@",error);
    //        [weakself handleData:nil isFailed:YES];
    //    }];
}

- (void)handleData:(NSDictionary *)responseObj isFailed:(BOOL)isFailed{
    [IANshowLoading hideLoadingForView:self.view];
    //    if (self.tableView.mj_header) {
    //        [self.tableView.mj_header endRefreshing];
    //    }
    //    if (responseObj && [responseObj isKindOfClass:[NSDictionary class]]) {
    //        NSArray *array = [responseObj objectForKey:@"data"][@"rows"];
    //        if(array && ![array isKindOfClass:[NSNull class]]){
    //            [self.arrayData addObjectsFromArray:array];
    //            [self.tableView reloadData];
    //        }
    //    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        NSString* temp = [MySingleton filterNull:self.detailInfo[@"serviceId"]];
        if ([temp isEqualToString:@"0"])
        {
        return 2;
        }
        else{
            return 8;
        }
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0&&indexPath.row==0) {
        //        int a=[EaseTextView numberOfLinesForMessage:self.detailInfo[@"business"]]+1;
        //
        //        return 10*kScaleX+[UIFont systemFontOfSize:13].lineHeight+10*kScaleX+[UIFont systemFontOfSize:15 weight:UIFontWeightMedium].lineHeight*a+10*kScaleX+1;
        return [ETSaleAndServiceDetailCell cellHeightLines:self.detailInfo[@"detail"]];
    }
    return [ETSaleAndServiceDetailCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10*kScaleX+[UIFont systemFontOfSize:12 weight:UIFontWeightMedium].lineHeight+10*kScaleX;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:12 weight:UIFontWeightMedium];
    label.textColor = RGBCOLOR(153, 153, 153);
    label.frame = CGRectMake(15*kScaleX, 10*kScaleX, Screen_Width-15*kScaleX*2, label.font.lineHeight);
    if (section == 0) {
        label.text = @"求购基本信息";
    }
    else{
        label.text = @"其他信息";
    }
    [view addSubview:label];
    view.frame = CGRectMake(0, 0, Screen_Width, 5*kScaleX+[UIFont systemFontOfSize:12 weight:UIFontWeightMedium].lineHeight+10*kScaleX);
    return view;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@(NO) forKey:@"isBlue"];
    [dict setObject:@(1) forKey:@"radiusState"];
    [dict setObject:@(1) forKey:@"lines"];
    [dict setObject:@([UIFont systemFontOfSize:15 weight:UIFontWeightMedium].lineHeight) forKey:@"subHeight"];
    if (indexPath.section == 0) {
        NSString* temp = [MySingleton filterNull:self.detailInfo[@"serviceId"]];
        if ([temp isEqualToString:@"0"])
        {
        
        switch (indexPath.row) {
            case 0:
            {
                [dict setObject:@"详细内容" forKey:@"title"];
                [dict setObject:[NSString stringWithFormat:@"%@",self.detailInfo[@"detail"]] forKey:@"subTitle"];
                [dict setObject:@(0) forKey:@"radiusState"];
                //                int a=[EaseTextView numberOfLinesForMessage:self.detailInfo[@"business"]]+1;
                [dict setObject:@(0) forKey:@"lines"];
                [dict setObject:@([self subFirstHight:self.detailInfo[@"detail"]]) forKey:@"subHeight"];
            }
                break;
            default:
            {
                [dict setObject:@"所在区域" forKey:@"title"];
                [dict setObject:[NSString stringWithFormat:@"%@",self.detailInfo[@"cityName"]] forKey:@"subTitle"];
                [dict setObject:@(2) forKey:@"radiusState"];
            }
                break;
        }
        }
        else{
            
            switch (indexPath.row) {
                case 0:
                {
                    [dict setObject:@"服务类型" forKey:@"title"];
                    [dict setObject:[NSString stringWithFormat:@"%@",self.detailInfo[@"detail"]] forKey:@"subTitle"];
                    NSString *serviceId = [MySingleton filterNull:self.detailInfo[@"serviceId"]];
                    NSString *title = @"";
                    if (!serviceId) {
                        serviceId = @"";
                    }
                    if ([serviceId isEqualToString:@"0"]) {
                        [dict setObject:[NSString stringWithFormat:@"%@-%@" ,@"综合服务",self.detailInfo[@"proceed"]] forKey:@"subTitle"];
                    }
                    else if ([serviceId isEqualToString:@"1"])
                    {
                        [dict setObject:[NSString stringWithFormat:@"%@-%@" ,@"工商服务",self.detailInfo[@"proceed"]] forKey:@"subTitle"];

                    }
                    else if ([serviceId isEqualToString:@"2"])
                    {
                        [dict setObject:[NSString stringWithFormat:@"%@-%@" ,@"财税服务",self.detailInfo[@"proceed"]] forKey:@"subTitle"];

                    }
                    else if ([serviceId isEqualToString:@"3"])
                    {
                        [dict setObject:[NSString stringWithFormat:@"%@-%@" ,@"行政服务",self.detailInfo[@"proceed"]] forKey:@"subTitle"];

                    }
                    else if ([serviceId isEqualToString:@"4"])
                    {
                        [dict setObject:[NSString stringWithFormat:@"%@-%@" ,@"金融服务",self.detailInfo[@"proceed"]] forKey:@"subTitle"];

                    }
                    else if ([serviceId isEqualToString:@"5"])
                    {
                        [dict setObject:[NSString stringWithFormat:@"%@-%@" ,@"资质服务",self.detailInfo[@"proceed"]] forKey:@"subTitle"];

                    }
                    else if ([serviceId isEqualToString:@"6"])
                    {
                        [dict setObject:[NSString stringWithFormat:@"%@-%@" ,@"综合服务",self.detailInfo[@"proceed"]] forKey:@"subTitle"];

                    }
                    else if ([serviceId isEqualToString:@"7"])
                    {
                        [dict setObject:[NSString stringWithFormat:@"%@-%@" ,@"知产服务",self.detailInfo[@"proceed"]] forKey:@"subTitle"];

                    }
                    else if ([serviceId isEqualToString:@"8"])
                    {
                        [dict setObject:[NSString stringWithFormat:@"%@-%@" ,@"法律服务",self.detailInfo[@"proceed"]] forKey:@"subTitle"];

                    }
                    [dict setObject:@(0) forKey:@"radiusState"];
                    //                int a=[EaseTextView numberOfLinesForMessage:self.detailInfo[@"business"]]+1;
                    [dict setObject:@(0) forKey:@"lines"];
                    [dict setObject:@([self subFirstHight:self.detailInfo[@"detail"]]) forKey:@"subHeight"];
                }
                    break;
                case 1:
                {
                    [dict setObject:@"经营范围" forKey:@"title"];
                    NSString* temp=[NSString stringWithFormat:@"%@",self.detailInfo[@"scope"]];
                    temp=[temp stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
                    if ([temp isEqualToString:@""])
                        temp=@"暂无";
                    [dict setObject:temp forKey:@"subTitle"];
                    [dict setObject:@(2) forKey:@"radiusState"];
                }
                    break;
                case 2:
                {
                    [dict setObject:@"纳税类型" forKey:@"title"];
                    NSString* temp1 = [MySingleton filterNull:self.detailInfo[@"taxId"]];
                    if (temp1) {
                    [dict setObject:[NSString stringWithFormat:@"%@",self.detailInfo[@"taxId"]] forKey:@"subTitle"];
                    if ([self.detailInfo[@"taxId"] isEqualToString:@"0"])
                        [dict setObject:@"暂无" forKey:@"subTitle"];
                    if ([self.detailInfo[@"taxId"] isEqualToString:@"2"]) {
                        [dict setObject:@"一般纳税人" forKey:@"subTitle"];
                    }
                    else{
                        [dict setObject:@"小规模" forKey:@"subTitle"];
                    }
                    }
                    else
                    {
                        [dict setObject:@"暂无" forKey:@"subTitle"];

                    }
                    [dict setObject:@(2) forKey:@"radiusState"];
                }
                    break;
                case 3:
                {
                    [dict setObject:@"注册资本" forKey:@"title"];
                    [dict setObject:[NSString stringWithFormat:@"%@",self.detailInfo[@"capital"]] forKey:@"subTitle"];
                    if ([self.detailInfo[@"capital"] isKindOfClass:[NSNull class]])
                        [dict setObject:@"暂无" forKey:@"subTitle"];
                    [dict setObject:@(2) forKey:@"radiusState"];
                }
                    break;
                case 4:
                {
                    [dict setObject:@"银行开户" forKey:@"title"];
                    NSString* temp1 = [MySingleton filterNull:self.detailInfo[@"bank"]];
                    if (temp1) {
                        
                    [dict setObject:[NSString stringWithFormat:@"%@",self.detailInfo[@"bank"]] forKey:@"subTitle"];
                    if ([self.detailInfo[@"bank"] isEqualToString:@""])
                        [dict setObject:@"暂无" forKey:@"subTitle"];
                    if ([self.detailInfo[@"bank"] isEqualToString:@"2"]) {
                        [dict setObject:@"代开" forKey:@"subTitle"];
                    }
                    else{
                        [dict setObject:@"自开户" forKey:@"subTitle"];
                    }
                    }
                    else{
                        [dict setObject:@"暂无" forKey:@"subTitle"];
                    }
                    [dict setObject:@(2) forKey:@"radiusState"];
                }
                    break;
                case 5:
                {
                    [dict setObject:@"注册地址" forKey:@"title"];
                    NSString* temp1 = [MySingleton filterNull:self.detailInfo[@"regUrl"]];
                    if (temp1) {
                    [dict setObject:[NSString stringWithFormat:@"%@",self.detailInfo[@"regUrl"]] forKey:@"subTitle"];
                    if ([self.detailInfo[@"regUrl"] isEqualToString:@"2"]) {
                        [dict setObject:@"企服者提供" forKey:@"subTitle"];
                    }
                    else{
                        [dict setObject:@"自供" forKey:@"subTitle"];
                            }
                    }
                    else{
                        [dict setObject:@"暂无" forKey:@"subTitle"];
                    }
                    [dict setObject:@(2) forKey:@"radiusState"];
                }
                    break;
                case 6:
                {
                    [dict setObject:@"求购区域" forKey:@"title"];
                    [dict setObject:[NSString stringWithFormat:@"%@",self.detailInfo[@"cityName"]] forKey:@"subTitle"];
                    if ([self.detailInfo[@"cityName"] isEqualToString:@""])
                        [dict setObject:@"暂无" forKey:@"subTitle"];

                    [dict setObject:@(2) forKey:@"radiusState"];
                }
                    break;
                case 7:
                {
                    [dict setObject:@"备注" forKey:@"title"];
                    [dict setObject:[NSString stringWithFormat:@"%@",self.detailInfo[@"remarks"]] forKey:@"subTitle"];
                    if ([self.detailInfo[@"remarks"] isKindOfClass:[NSNull class]])
                        [dict setObject:@"暂无" forKey:@"subTitle"];

                    [dict setObject:@(2) forKey:@"radiusState"];
                }
                    break;
                default:
                {
                    [dict setObject:@"所在区域" forKey:@"title"];
                    [dict setObject:[NSString stringWithFormat:@"%@",self.detailInfo[@"cityName"]] forKey:@"subTitle"];
                    [dict setObject:@(2) forKey:@"radiusState"];
                }
                    break;
            }
            
        }
    }
    else{
        [dict setObject:@"联系人:" forKey:@"title"];
        [dict setObject:[NSString stringWithFormat:@"%@",self.detailInfo[@"linkmanName"]] forKey:@"subTitle"];
        [dict setObject:@(3) forKey:@"radiusState"];
    }
    return [ETSaleAndServiceDetailCell saleAndServiceDetailCell:tableView model:dict];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    if (indexPath.section == 1) {
    //        [self chatAction];
    //    }
    if (indexPath.section==1) {
        UserMegViewController *megVC=[[UserMegViewController alloc]init];
        megVC.name=_toUser.name;
        megVC.photoImg=_toUser.portrait;
        [MySingleton sharedMySingleton].toUserid=_toUser.uid;
        [self.navigationController pushViewController:megVC animated:YES];

    }
}

- (NSString *)taxTitle{
    NSString *taxId = [MySingleton filterNull:self.detailInfo[@"taxId"]];
    if (!taxId) {
        taxId = @"";
    }
    if ([taxId isEqualToString:@"1"]) {
        return @"一般纳税人";
    }
    if ([taxId isEqualToString:@"2"]) {
        return @"小规模";
    }
    if ([taxId isEqualToString:@"3"]) {
        return @"小规模";
    }
    if ([taxId isEqualToString:@"4"]) {
        return @"一般纳税人";
    }
    return @"";
}

- (NSString *)buildTitle{
    NSString *serviceId = [MySingleton filterNull:self.detailInfo[@"serviceId"]];
    NSString *title = @"";
    if (!serviceId) {
        serviceId = @"";
    }
    if ([serviceId isEqualToString:@"0"]) {
        title = @"综合服务";
    }
    else if ([serviceId isEqualToString:@"1"])
    {
        title = @"工商服务";
    }
    else if ([serviceId isEqualToString:@"2"])
    {
        title = @"财税服务";
    }
    else if ([serviceId isEqualToString:@"3"])
    {
        title = @"行政服务";
    }
    else if ([serviceId isEqualToString:@"4"])
    {
        title = @"金融服务";
    }
    else if ([serviceId isEqualToString:@"5"])
    {
        title = @"资质服务";
    }
    else if ([serviceId isEqualToString:@"6"])
    {
        title = @"疑难服务";
    }
    return title;
    
}
-(void)PostInfoUI
{
    ETProductModel* p=[ETProductModel mj_objectWithKeyValues:self.detailInfo];
    
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
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (CGFloat)subFirstHight:(NSString *)string{
    NSString *temp = [MySingleton filterNull:string];
    if (!temp) {
        temp = @"";
    }
    CGSize size = [temp boundingRectWithSize:CGSizeMake(Screen_Width-15*kScaleX*2*2, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium]} context:nil].size;
    size.height = MAX(size.height, [UIFont systemFontOfSize:15 weight:UIFontWeightMedium].lineHeight);
    return size.height;
}
@end
