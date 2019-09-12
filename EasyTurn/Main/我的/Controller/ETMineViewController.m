//
//  ETMineViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/9/1.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETMineViewController.h"
#import "ETMineHeaderView.h"
#import "ETMineViewCell.h"
#import "JXPagerView.h"
#import "JXCategoryView.h"
#import "JXCategoryTitleView.h"
#import "ETMineListViewController.h"
#import "ETMineViewModel.h"
#import "MCPageViewViewController.h"
#import "ETMyOrderVC.h"
#import "ETFootViewController.h"
#import "ETAuthenticateViewController.h"
#import "ETAccountViewController.h"
#import "ETStoreUpViewController.h"
#import "ETPutViewController.h"
#import "ETViphuiyuanViewController.h"
#import "ETInvitationController.h"
#import "ETFrequencyViewController.h"
#import "WXApiManagerShare.h"
#import "ETVIPViewController.h"
static NSString *const kETMineViewCell = @"ETMineViewCell";
@interface ETMineViewController ()<ETMineHeaderViewDelegate, JXPagerViewDelegate, JXCategoryViewDelegate, ETMineListViewControllerDelegate>
///根控制器
@property (nonatomic, strong) JXPagerView *pagingView;
///头部视图
@property (nonatomic, strong) ETMineHeaderView *userHeaderView;
///横向滚动条
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
///横向滚动条标题名称
@property (nonatomic, strong) NSMutableArray <NSString *> *titles;
@property (nonatomic, strong) ETMineListViewController *listView;
@property (nonatomic, assign) NSInteger pageNumber;
///数据源
@property (nonatomic, strong) NSMutableArray<UserInfosReleaseModel *> *arrDataSource;
///item选择当前索引
@property (nonatomic, assign) NSInteger categoryViewSelectedIndex;
@property (nonatomic, strong) ETMineViewModel *eTMineViewModel;
//提示框
@property (nonatomic,strong) UIView * maskTheView;
@property (nonatomic,strong) UIView * shareView;
@property (nonatomic,assign)int select1;
@property (nonatomic,copy) NSString * share;
@property (nonatomic, copy) NSString *releaseId;
@property (nonatomic,strong) UIView * maskTheView1;
@property (nonatomic,strong) UIView * shareView1;
@property (nonatomic,strong) UILabel * lab1;
@property (nonatomic,strong) UILabel *lab;
//
@property (nonatomic,assign) int count;
@property (nonatomic,assign) int myselect;

@end

@implementation ETMineViewController

- (NSMutableArray <UserInfosReleaseModel *> *)arrDataSource {
    if (!_arrDataSource) {
        _arrDataSource = [NSMutableArray array];
    }
    return _arrDataSource;
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
    self.view.backgroundColor=[UIColor whiteColor];
    _count=0;
    _titles = @[@"出售", @"服务", @"求购"];
    _titles=[_titles mutableCopy];
    [self requestUserOrderListWithReleaseTypeId:1];
    [self requestUserOrderListWithReleaseTypeId:2];
    [self requestUserOrderListWithReleaseTypeId:3];
    [self requestUserInfo];
//    [self createSubViewsAndConstraints];
    [self shareView];
    [self shareViewController];
    
    if (!_lab) {
        [self shareViewController1];
    }
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestRefreshMine) name:Refresh_Mine object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestUserInfoRefreshing) name:FaBuChengGongRefresh_Mine object:nil];
}


#pragma mark - createSubViewsAndConstraints
- (void)createSubViewsAndConstraints {
    
    _userHeaderView = [[ETMineHeaderView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 421)];
    _userHeaderView.delegate = self;
    
    _categoryView = [[JXCategoryTitleView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 40)];
    self.categoryView.titles = self.titles;
    self.categoryView.titleFont = kFontSize(15);
    self.categoryView.backgroundColor = kACColorWhite;
    self.categoryView.delegate = self;
    self.categoryView.titleSelectedColor = kACColorRGB(47, 134, 251);
    self.categoryView.titleColor = kACColorBlackTypeface;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.titleLabelZoomEnabled = NO;

    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorLineViewColor = kACColorRGB(47, 134, 251);;
    lineView.indicatorLineWidth = 33;
    lineView.indicatorLineViewHeight = 3;
    self.categoryView.indicators = @[lineView];
    
    _pagingView = [[JXPagerView alloc] initWithDelegate:self];
    [self.view addSubview:self.pagingView];
    
    self.categoryView.contentScrollView = self.pagingView.listContainerView.collectionView;
    
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == _myselect);
    
    __weak typeof(self)weakSelf = self;
    self.pagingView.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf requestUserInfo];
        [weakSelf requestUserInfoRefreshing];
    }];
}

#pragma mark - 请求网络 - 个人信息
- (void)requestUserInfo {
    WEAKSELF
    NSString *uid = [UserInfoModel loadUserInfoModel].uid;
    [IANshowLoading showLoadingForView:self.view];
    [ETMineViewModel requestUserInfoWithUid:uid WithSuccess:^(id request, STResponseModel *response, id resultObject) {
        [IANshowLoading hideLoadingForView:self.view];
        if (response.code == 0) {
            ETMineViewModel *model = response.data;
            weakSelf.eTMineViewModel = model;
            [weakSelf.userHeaderView makeMineHeaderViewWithETMineViewModel:model];

        }else{
            if (response.msg.length > 0) {
                [[ACToastView toastView:YES] showErrorWithStatus:response.msg];
            } else {
                [[ACToastView toastView:YES] showErrorWithStatus:kToastErrorServerNoErrorMessage];
            }
        }
    } failure:^(id request, NSError *error) {
        
    }];
}

#pragma mark - 请求网络 - 刷新页面
- (void)requestUserInfoRefreshing {
    WEAKSELF
    NSString *uid = [UserInfoModel loadUserInfoModel].uid;
    [IANshowLoading showLoadingForView:self.view];
    [ETMineViewModel requestUserInfoWithUid:uid WithSuccess:^(id request, STResponseModel *response, id resultObject) {
        [IANshowLoading hideLoadingForView:self.view];
        if (response.code == 0) {
            self.categoryView.titles = @[@"出售", @"服务", @"求购"];
            self.categoryView.defaultSelectedIndex = self.categoryViewSelectedIndex;
            [self.categoryView reloadData];
            [self.pagingView reloadData];
            [weakSelf.pagingView.mainTableView.mj_header endRefreshing];
            
        }else{
            if (response.msg.length > 0) {
                [[ACToastView toastView:YES] showErrorWithStatus:response.msg];
            } else {
                [[ACToastView toastView:YES] showErrorWithStatus:kToastErrorServerNoErrorMessage];
            }
            [weakSelf.pagingView.mainTableView.mj_header endRefreshing];
        }
    } failure:^(id request, NSError *error) {
        [weakSelf.pagingView.mainTableView.mj_header endRefreshing];
    }];
}


- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.pagingView.frame = CGRectMake(0, kStatusBarHeight, Screen_Width, Screen_Height - kNavBarHeight_StateBarH);
}


#pragma mark - ETMineHeaderViewDelegate
- (void)eTMineHeaderviewDidSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        if ([self.eTMineViewModel.userInfo.isChecked isEqualToString:@"5"]) {
            MCPageViewViewController *vc = [[MCPageViewViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }else {
            [MBProgressHUD showMBProgressHud:self.view withText:@"您还未进行企业法人认证,快去身份认证吧!" withTime:2];
        }
       
    }else if (indexPath.row == 1){
        ETAuthenticateViewController* a=[ETAuthenticateViewController new];
        [self.navigationController pushViewController:a animated:YES];

    }else if (indexPath.row == 2){
        ETMyOrderVC* o=[[ETMyOrderVC alloc] init];
        [self.navigationController pushViewController:o animated:YES];
    }else if (indexPath.row == 3){
        ETAccountViewController*c =[ETAccountViewController new];
        [self.navigationController pushViewController:c animated:YES];
    }else if (indexPath.row == 4){
        ETFootViewController* f=[[ETFootViewController alloc] init];
        [self.navigationController pushViewController:f animated:YES];
    }else if (indexPath.row == 5){
        ETInvitationController *vc = [[ETInvitationController alloc]init];
        vc.model = self.eTMineViewModel;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.row == 6){
        ETStoreUpViewController*s= [ETStoreUpViewController new];
        [self.navigationController pushViewController:s animated:YES];

    }else if (indexPath.row == 7){
        if (self.eTMineViewModel.userInfo.isSign == 0) {
            [self requestSign];
        }else if (self.eTMineViewModel.userInfo.isSign == 1){
            [MBProgressHUD showMBProgressHud:self.view withText:@"已经签到过了" withTime:2];
        }
        
    }
}

- (void)eTMineHeaderviewOnClickPayRefreshCount {
    ETFrequencyViewController *vc = [[ETFrequencyViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 请求网络 - 签到
- (void)requestSign {
    WEAKSELF
    [HttpTool put:[NSString stringWithFormat:@"user/sign"] params:nil success:^(NSDictionary *response) {
        [IANshowLoading hideLoadingForView:self.view];
        NSString *code = response[@"data"][@"code"];
        if (code.integerValue == 0) {
            [MBProgressHUD showMBProgressHud:weakSelf.view withTitle:@"签到成功" detail:@"刷新次数 +1" withTime:2];
            weakSelf.eTMineViewModel.userInfo.isSign = 1;
            [weakSelf requestUserInfo];
        }else {
            NSString* msg = response[@"data"][@"msg"];
            if (msg.length > 0) {
                [[ACToastView toastView:YES] showErrorWithStatus:msg];
            } else {
                [[ACToastView toastView:YES] showErrorWithStatus:kToastErrorServerNoErrorMessage];
            }
        }
    } failure:^(NSError *error) {
        [IANshowLoading hideLoadingForView:self.view];
    }];
    
}

- (void)eTMineHeaderviewOnClickHeaderEdit {
    ETPutViewController *vc = [[ETPutViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)eTMineHeaderviewOnClickPayVip {
    if ([MySingleton sharedMySingleton].review==1) {
        ETVIPViewController *vc = [[ETVIPViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
    ETViphuiyuanViewController *vc = [[ETViphuiyuanViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - JXPagingViewDelegate
- (UIView *)tableHeaderViewInPagerView:(JXPagerView *)pagerView {
    return self.userHeaderView;
}

- (NSUInteger)tableHeaderViewHeightInPagerView:(JXPagerView *)pagerView {
    return 421;
}

- (NSUInteger)heightForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return 40;
}

- (UIView *)viewForPinSectionHeaderInPagerView:(JXPagerView *)pagerView {
    return self.categoryView;
}

- (NSInteger)numberOfListsInPagerView:(JXPagerView *)pagerView {
    //和categoryView的item数量一致
    return _titles.count;
}

- (id<JXPagerViewListViewDelegate>)pagerView:(JXPagerView *)pagerView initListAtIndex:(NSInteger)index {
    ETMineListViewController *listView = [[ETMineListViewController alloc] init];
    listView.naviController = self.navigationController;
    listView.delegate = self;
    if (index == 0) {
        listView.releaseTypeId = 1;
        
    }else if (index == 1) {
        listView.releaseTypeId = 3;
        
    }else if (index == 2){
         listView.releaseTypeId = 2;
    }
    listView.releaseTypeId=_myselect;
    return listView;
}

#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    self.categoryViewSelectedIndex = index;
    self.navigationController.interactivePopGestureRecognizer.enabled = (index == 0);

}

- (void)categoryView:(JXCategoryBaseView *)categoryView didClickedItemContentScrollViewTransitionToIndex:(NSInteger)index {
    
    [categoryView.contentScrollView setContentOffset:CGPointMake(index * categoryView.contentScrollView.bounds.size.width, 0) animated:YES];
}

#pragma mark - ETMineListViewControllerDelegate
- (void)eTMineListViewController:(ETMineListViewController *)vc WithButtonType:(UIButton *)sender WithReleaseId:(nonnull NSString *)releaseId {
    _releaseId = releaseId;
    if (sender.tag == 1000) {
        //分享
        [self popShareView];
       
    }else if (sender.tag == 1001){
        //刷新
        [self refrechShare];
    }else if (sender.tag == 1002){
        //删除
        [self delfav123];
    }else if (sender.tag == 1003){
        //查看
    }
}

- (void)popShareView {
    [self.view addSubview:self.maskTheView];
    [self.view addSubview:self.shareView];
}

- (UIView *)maskTheView {
    if (!_maskTheView) {
        _maskTheView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _maskTheView.backgroundColor = [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:0.5];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage)];
        [_maskTheView addGestureRecognizer:tap];
    }
    return _maskTheView;
}

- (UIView *)shareView {
    if (!_shareView) {
        _shareView = [[UIView alloc]initWithFrame:CGRectMake(30, Screen_Height/2-80, Screen_Width-60,200)];
        _shareView.layer.cornerRadius=10;
        //        _shareView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        _shareView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
    }
    return _shareView;
}

#pragma mark - 订单分享
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
    label.textAlignment = NSTextAlignmentCenter;
    [_shareView addSubview:label];
    
}


- (void)clickImage {
    [self.maskTheView removeFromSuperview];
    [self.shareView removeFromSuperview];
}

- (void)clickImage1 {
    [self delfav1];
    _select1=0;
    [self clickImage];
}

- (void)clickImage2 {
    [self delfav1];
    _select1=1;
    [self clickImage];
    
}

- (void)delfav1 {
    WEAKSELF
    NSDictionary *params = @{
                             @"id" : @(_releaseId.integerValue)
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"user/shareReleaseById"] params:params success:^(NSDictionary *response) {
        _share=response[@"data"];
        if (_select1==0) {
            
            [[WXApiManagerShare sharedManager] sendLinkContent:[[NSURL URLWithString:[NSString stringWithFormat:@"%@",_share]] absoluteString]
                                                         Title:self.title
                                                   Description:@"分享一个链接"
                                                       AtScene:WXSceneSession];

            
        }
        if (_select1==1) {
            
            [[WXApiManagerShare sharedManager] sendLinkContent:[[NSURL URLWithString:[NSString stringWithFormat:@"%@",_share]] absoluteString]
                                                         Title:self.title
                                                   Description:@"分享一个链接"
                                                       AtScene:WXSceneTimeline];
        }
        
    } failure:^(NSError *error) {
   
    }];
}

- (void)refrechShare {
    [self.view addSubview:self.maskTheView1];
    if (_lab) {
        [_lab removeFromSuperview];
        [self.view addSubview:self.shareView1];
        [self shareViewController1];
    }
    
}

- (UIView *)maskTheView1{
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
        //        _shareView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        _shareView1.layer.cornerRadius=20;
        _shareView1.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
    }
    return _shareView1;
}

#pragma mark - 订单刷新
- (void)shareViewController1 {

    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(20, 25, Screen_Width, 45)];
    
    lab.text=[NSString stringWithFormat:@"您的剩余刷新次数%@",self.eTMineViewModel.userInfo.refreshCount];
    lab.textColor=[UIColor blackColor];
    lab.font =[UIFont systemFontOfSize:20];
    _lab=lab;
    [_shareView1 addSubview:lab];
    
    _lab1=[[UILabel alloc]initWithFrame:CGRectMake(20, 60, Screen_Width-90, 50)];
    _lab1.text = @"确定刷新吗?";
    _lab1.textColor=[UIColor blackColor];
    _lab1.font =[UIFont systemFontOfSize:14];
    [_shareView1 addSubview:self.lab1];
    
    UIButton *returnbtn =[[UIButton alloc]initWithFrame:CGRectMake(_shareView.size.width-150, 155, 50, 21)];
    [returnbtn setTitle:@"关闭" forState:UIControlStateNormal];
    returnbtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [returnbtn addTarget:self action:@selector(clickImage11) forControlEvents:UIControlEventTouchUpInside];
    [returnbtn setTitleColor:[UIColor colorWithRed:243/255.0 green:22/255.0 blue:22/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_shareView1 addSubview:returnbtn];
    
    UIButton *surebtn =[[UIButton alloc]initWithFrame:CGRectMake(_shareView.size.width-100, 155, 50, 21)];
    [surebtn setTitle:@"确定" forState:UIControlStateNormal];
    surebtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [surebtn setTitleColor:[UIColor colorWithRed:243/255.0 green:22/255.0 blue:22/255.0 alpha:1.0] forState:UIControlStateNormal];
    [surebtn addTarget:self action:@selector(postuia) forControlEvents:UIControlEventTouchUpInside];
    //    _surebtn=surebtn;
    [_shareView1 addSubview:surebtn];
    
}

- (void)clickImage11 {
    [self.maskTheView1 removeFromSuperview];
    [self.shareView1 removeFromSuperview];
}

- (void)postuia {
    
    [self clickImage11];
    
    if (_eTMineViewModel.userInfo.refreshCount.integerValue == 0 ) {
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"不能再刷新" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alter show];
        return;
    }else {
         [self PostUI2];
    }
   
    
    
}

- (void)PostUI2 {
    WEAKSELF
    NSDictionary*params = @{
                            @"releaseId" :@(_releaseId.integerValue)
                            };
    
    [HttpTool get:[NSString stringWithFormat:@"release/refresh"] params:params success:^(id responseObj) {
        NSLog(@"====================刷新成功");
        NSString *str=responseObj[@"code"];
        if ([str isEqualToString:@"0"]) {
            [MBProgressHUD showMBProgressHud:self.view withText:@"刷新成功" withTime:1];
        }else {
            [MBProgressHUD showMBProgressHud:self.view withText:@"刷新失败，请充值刷新次数" withTime:1];
        }
        [weakSelf requestUserInfoRefreshing];
        [weakSelf requestUserInfo];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - 订单删除
-(void)delfav123 {
    
    ACAlertView *lga = [ACAlertView alertViewWithTitle:@"确认删除此订单吗?" message:@"" style:AHKAlertViewStyleAlert buttonTitles:@[@"确定"] cancelButtonTitle:nil destructiveButtonTitle:@"取消" didDismissActionHandler:^(NSString *title, NSUInteger index) {
         [self delOrder];
    } didDismissCancelHandler:^() {
        
    } didDismissDestructiveHandler:^() {
        
    }];
    [lga showAnimated:YES completionHandler:nil];

}


-(void)delOrder {
    WEAKSELF
    NSDictionary *params = @{
                             @"releaseId" : @(_releaseId.integerValue)
                             };
    [HttpTool put:[NSString stringWithFormat:@"release/resultDel"] params:params success:^(NSDictionary *response) {
        NSString *code = response[@"code"];
        if (code.integerValue == 0) {
            [MBProgressHUD showMBProgressHud:self.view withText:@"删除成功" withTime:1];
            [weakSelf requestUserInfoRefreshing];
        }else{
            NSString *msg = response[@"msg"];
            if (msg.length > 0) {
                [MBProgressHUD showMBProgressHud:self.view withText:msg withTime:1];
            } else {
                [MBProgressHUD showMBProgressHud:self.view withText:kToastErrorServerNoErrorMessage withTime:1];
            }
        }
        
    } failure:^(NSError *error) {
        NSLog(@"");
        
    }];
}

#pragma mark - 通知刷新页面
- (void)requestRefreshMine {
    [self requestUserInfo];
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 请求网络
- (void)requestUserOrderListWithReleaseTypeId:(NSInteger )releaseTypeId {
    WEAKSELF
    //赋值初始值
    [ETMineViewModel requestUserOrderListWithPage:self.pageNumber WithPageSize:1 ReleaseTypeId:releaseTypeId WithSuccess:^(id request, STResponseModel *response, id resultObject) {
        if (response.code == 0) {
            NSArray *array = resultObject[@"data"];
            if (array.count == 0) {
                
                if (releaseTypeId==1) {
                    [_titles replaceObjectAtIndex:0 withObject:@""];
                    _count++;
                }
                if (releaseTypeId==2) {
                                    [_titles replaceObjectAtIndex:1 withObject:@""];
                                    _count++;
                }
                if (releaseTypeId==3) {
                                    [_titles replaceObjectAtIndex:2 withObject:@""];
                                    _count++;
                }
                

            }else {
                _count++;
            }
            if (_count==3) {
                NSMutableArray* temp=[NSMutableArray array];
                for (NSString* a in _titles) {
                    if ([a isEqualToString:@""]) {
                    }
                    else{
                        [temp addObject:a];
                    }
                }
                for (NSString* a in temp) {
                    if ([a isEqualToString:@"出售"]) {
                        _myselect=1;
                    }
                    else if ([a isEqualToString:@"服务"])
                    {
                        _myselect=2;
                    }
                    else if ([a isEqualToString:@"求购"])
                    {
                        _myselect=3;
                    }
                    break;
                }
                [_titles removeAllObjects];
                _titles=[temp mutableCopy];
                [self createSubViewsAndConstraints];
            }
        }else{
            if (response.msg.length > 0) {
                [[ACToastView toastView:YES] showErrorWithStatus:response.msg];
            } else {
                [[ACToastView toastView:YES] showErrorWithStatus:kToastErrorServerNoErrorMessage];
            }
        }
    } failure:^(id request, NSError *error) {
        
    }];
}
@end
