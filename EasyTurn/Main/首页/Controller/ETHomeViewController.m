//
//  ETHomeViewController.m
//  EasyTurn
//
//  Created by 程立 on 2019/7/19.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETHomeViewController.h"
#import "ETHomeTopView.h"
#import "ETHomeHeaderView.h"
#import "ETHomeModel.h"
#import "MarqueeView.h"
#import "ETHomeLocationController.h"
#import "JMColumnMenu.h"
#import "AticleMenu.h"
#import "ETEnterpriseServiceTableViewCell1.h"
#import "ETProductModel.h"
#import "FBSearchViewController.h"
#import "ETSaleDetailController.h"
#import <CoreLocation/CoreLocation.h>
#import "CityListViewController.h"
#import "ETRealtimePurchaseViewController.h"
#import "IANshowLoading.h"

#import "ETHomeListHeader.h"
#import "ETDynamicListVC.h"
#import "ETRealTimeBuyListVC.h"
#import "ETDynamicListCell.h"
#import "XMRefreshHeader.h"
#import "XMRefreshFooter.h"
#import "ETSaleDetailVC.h"
#import "ETServiceDetailController.h"
@interface ETHomeViewController ()<UITableViewDelegate, UITableViewDataSource, ETHomeHeaderViewDelegate,CLLocationManagerDelegate>
{
    CLLocationManager* manager;
}
@property (nonatomic, strong) ETHomeTopView *vHomeTop;
@property (nonatomic, strong) ETHomeHeaderView *vHomeHeader;
@property (nonatomic, strong) ETHomeListHeader *listHeader;
@property (nonatomic, strong) UITableView *tbHome;
@property (nonatomic, strong) MarqueeView *marqueeView;
@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, strong) NSMutableArray *serviceIdarr;
@property (nonatomic, strong) NSMutableArray* dylists;
@property(nonatomic, assign)NSInteger pageSize;
@property(nonatomic, assign)NSInteger pageIndex;
//广告
@property (nonatomic,strong) UIView * maskTheView;
@property (nonatomic,strong) UIView * shareView;
@end

@implementation ETHomeViewController


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

- (void)maskClickGesture {
    [self.maskTheView removeFromSuperview];
    [self.shareView removeFromSuperview];
    
}

- (UIView *)shareView{
    if (!_shareView) {
        _shareView = [[UIView alloc]init];
        _shareView.layer.cornerRadius=10;
        //        _shareView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        _shareView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        _shareView.backgroundColor=[UIColor clearColor];

        
    }
    return _shareView;
}
- (void)shareViewController {
    
    
    UIImageView* img=[UIImageView new];
    [img setImage:[UIImage imageNamed:@"1321566445086_.pic_hd"]];
    [_shareView addSubview:img];
    
    UIButton *returnImage=[[UIButton alloc]init];
//    [returnImage setTitle:@"我知道了" forState:UIControlStateNormal];
    [returnImage setBackgroundImage:[UIImage imageNamed:@"1301566443874_.pic"] forState:UIControlStateNormal];
//    [returnImage setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskClickGesture)];
    [returnImage addGestureRecognizer:tapGesture];
    [_shareView addSubview:returnImage];
    
    [_shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(283,360));
        make.center.mas_equalTo(self.view);
    }];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(310);
        make.width.mas_equalTo(283);
        make.top.mas_equalTo(self.shareView);
        make.centerX.mas_equalTo(self.view);
    }];
    
    [returnImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(220);
        make.height.mas_equalTo(45);

        make.top.mas_equalTo(img.mas_bottom).offset(25);
        make.centerX.mas_equalTo(self.view);
    }];
    
}
- (void)mask {
    [self.view addSubview: self.maskTheView];
    [self.view addSubview: self.shareView];
    [self shareViewController];
    
}

- (MarqueeView *)marqueeView{
    if (!_dylists) {
        return [MarqueeView new];
    }
    if (!_marqueeView) {
        NSMutableArray *arr1=[NSMutableArray array];
        for (ETProductModel*p in _serviceIdarr) {
            [arr1 addObject:p.title];
        }
        MarqueeView *marqueeView =[[MarqueeView alloc]initWithFrame:CGRectMake(0, 290-32-32-42, 250, 30) withTitle:_dylists];
        marqueeView.titleColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        marqueeView.titleFont = [UIFont systemFontOfSize:12];
        __weak MarqueeView *marquee = marqueeView;
        
        marqueeView.handlerTitleClickCallBack = ^(NSInteger index){
//            ETProductModel *p=self->_serviceIdarr[index];
            NSLog(@"%@----%zd",marquee.titleArr[index-1],index);
            ETRealTimeBuyListVC *etrealTime=[[ETRealTimeBuyListVC alloc]init];
            [self.navigationController pushViewController:etrealTime animated:YES];
            
        };
        _marqueeView = marqueeView;
    }
    return _marqueeView;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self PostUI];
    self.navigationController.navigationBar.hidden = YES;
    

}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (UITableView *)tbHome {
    WEAKSELF
    if (!_tbHome) {
        _tbHome = [[UITableView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + 65, Screen_Width, Screen_Height - kStatusBarHeight - 65) style:UITableViewStylePlain];
        _tbHome.showsVerticalScrollIndicator = NO;
        _tbHome.backgroundColor = kACColorWhite;
        _tbHome.delegate = self;
        _tbHome.dataSource = self;
        _vHomeHeader = [[ETHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 327-32-32-37)];
        _vHomeHeader.block = ^{
            ETRealTimeBuyListVC *etrealTime = [[ETRealTimeBuyListVC alloc]init];
            [weakSelf.navigationController pushViewController:etrealTime animated:YES];
        };
        _vHomeHeader.delegate = self;
        _tbHome.tableHeaderView = _vHomeHeader;
        _tbHome.tableFooterView = [[UIView alloc]init];
    }
    return _tbHome;
}

- (ETHomeListHeader *)listHeader{
    if (!_listHeader) {
        WeakSelf(self);
        _listHeader = [ETHomeListHeader homeListHeader:^{
            NSLog(@"查看全部动态列表");
            [weakself.navigationController pushViewController:[[ETDynamicListVC alloc] init] animated:YES];
        }];
    }
    return _listHeader;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageSize = 10;
    self.pageIndex = 1;
    _products=[NSMutableArray new];
    [self postDylist];
    self.serviceIdarr=[NSMutableArray array];
    [self createSubViewsAndConstraints];
    [self requestDate];
    [self location];
    WEAKSELF
    _tbHome.mj_header = [XMRefreshHeader xm_headerWithRefreshingBlock:^{
        self.pageIndex = 1;
        [_products removeAllObjects];
        [weakSelf PostUI];
    }];
    _tbHome.mj_footer = [XMRefreshFooter xm_footerWithRefreshingBlock:^{
        self.pageIndex += 1;
        [weakSelf PostUI];
    }];
    [self mask];
    [self getJimName];
    [self PostBaiduUI];
    [self PostuserinfoUI];
}

#pragma mark - 动态列表
- (void)PostUI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             @"page" : [NSString stringWithFormat:@"%i", self.pageIndex ],
                             @"pageSize": [NSString stringWithFormat:@"%i", self.pageSize ],
                             @"cityId": @(0)
                             };
    [IANshowLoading showLoadingForView:self.view];
    [HttpTool get:[NSString stringWithFormat:@"release/dynamic"] params:params success:^(id responseObj) {
        [_tbHome.mj_header endRefreshing];
        [_tbHome.mj_footer endRefreshing];
        [IANshowLoading hideLoadingForView:self.view];
        
        if (responseObj && [responseObj isKindOfClass:[NSDictionary class]]) {
            NSArray *array = responseObj[@"data"][@"rows"];
            if(array && ![array isKindOfClass:[NSNull class]]){
                [_products addObjectsFromArray:array];
                [_tbHome reloadData];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [IANshowLoading hideLoadingForView:self.view];
        [_tbHome.mj_header endRefreshing];
        [_tbHome.mj_footer endRefreshing];
    }];
}

//实时动态
-(void)postDylist
{
    WeakSelf(self);
    NSDictionary *params = @{
                             @"releaseTypeId":@(2)
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"release/releaseList"] params:params success:^(id responseObj) {
        _dylists=[NSMutableArray new];
                NSDictionary* a=responseObj[@"data"];
                for (NSDictionary* prod in responseObj[@"data"][@"rows"]) {
                    ETProductModel* p=[ETProductModel mj_objectWithKeyValues:prod];
                    [_dylists addObject:p.title];
                }
        NSLog(@"%@",responseObj);
        dispatch_async(dispatch_get_main_queue(), ^{
            _marqueeView.titleArr=_dylists;
            [self.vHomeHeader addSubview:self.marqueeView];
            //
//            NSString* str=[NSString stringWithFormat:@"全部 %d 条",_dylists.count];

            NSString* c=responseObj[@"data"][@"total"];
            NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"全部 %d 条",[c integerValue]]];
            NSString* b=[NSString stringWithFormat:@"%d",[c integerValue]];
            [str addAttribute:NSForegroundColorAttributeName value:kACColorBlue_Theme range:NSMakeRange(3,b.length)];
            
            self.vHomeHeader.laAllQiugou.attributedText=str;

        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - 产品搜索
- (void)PostSearchUI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             @"page" : @"1",
                             @"pageSize": @"10",
                             @"cityId": @(2),
                             @"keyword" : @"营业",
                             @"priceOrder" : @(2)
                             };
    [HttpTool get:[NSString stringWithFormat:@"search/product"] params:params success:^(id responseObj) {
        _products=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"][@"productList"];
        for (NSDictionary* prod in responseObj[@"data"][@"productList"]) {
            ETProductModel* p=[ETProductModel mj_objectWithKeyValues:prod];
            [_products addObject:p];
        }
        //        NSLog(@"");
        [_tbHome reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)location
{
    manager = [[CLLocationManager alloc]init];//初始化一个定位管理对象
    [manager requestAlwaysAuthorization];//申请定位服务权限
    //    [manager requestWhenInUseAuthorization];
    manager.delegate=self;//设置代理
    [manager startUpdatingLocation];//开启定位服务
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    NSLog(@"%@",locations);
    //位置坐标
    CLLocation *location=[locations firstObject];
    
    
    _coordinate=location.coordinate;
    
    NSLog(@"您的当前位置:经度：%f,纬度：%f,海拔：%f,航向：%f,速度：%f",_coordinate.longitude,_coordinate.latitude,location.altitude,location.course,location.speed);
    [self PostCityUI];
    [manager stopUpdatingLocation];
}

#pragma mark -  获取cityID
- (void)PostCityUI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             @"lat" : [NSString stringWithFormat:@"%f", _coordinate.latitude ],
                             @"lng": [NSString stringWithFormat:@"%f", _coordinate.longitude ]
                             };
    [HttpTool get:[NSString stringWithFormat:@"city/getCityByLocation"] params:params success:^(id responseObj) {

        [_vHomeTop.btnLocationDown setTitle:responseObj[@"data"][@"name"] forState:UIControlStateNormal];
        //cityId
        NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
        [user setObject:responseObj[@"data"][@"id"] forKey:@"cityid"];
        [user setObject:responseObj[@"data"][@"name"] forKey:@"cityname"];
        [user synchronize];
        //        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - createSubViewsAndConstraints
- (void)createSubViewsAndConstraints {
    
    _vHomeTop = [[ETHomeTopView alloc]init];
    [self.view addSubview:_vHomeTop];
    _vHomeTop.block1 = ^{
        [self homeHeaderViewPushSearch];
    };
    _vHomeTop.block = ^{
        CityListViewController* loc=[CityListViewController new];
        loc.block = ^{
            [self location];
        };
        loc.delegate = self;
        //热门城市列表
        loc.arrayHotCity = [NSMutableArray arrayWithObjects:@"广州",@"北京",@"天津",@"厦门",@"重庆",@"福州",@"泉州",@"济南",@"深圳",@"长沙",@"无锡", nil];
        //历史选择城市列表
        loc.arrayHistoricalCity = [NSMutableArray arrayWithObjects:@"福州",@"厦门",@"泉州", nil];
        //定位城市列表
        NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
        loc.arrayLocatingCity   = [NSMutableArray arrayWithObjects:[user objectForKey:@"cityname"], nil];
        [self.navigationController pushViewController:loc animated:YES];
        

    };
    [_vHomeTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kStatusBarHeight + 75);
    }];
    
    [self.view addSubview:self.tbHome];
 
}
- (void)didClickedWithCityName:(NSString*)cityName
{
    NSLog(@"%@",cityName);
    [_vHomeTop.btnLocationDown setTitle:cityName forState:UIControlStateNormal];

}
#pragma mark - 请求网络
- (void)requestDate {
    WEAKSELF
    [IANshowLoading showLoadingForView:self.view];
    [ETHomeModel requestGetIndexBannerSuccess:^(id request, STResponseModel *response, id resultObject) {
        [IANshowLoading hideLoadingForView:self.view];
        if (response.code == 0) {
            ETHomeModel *model = response.data;
            NSMutableArray *imageGroupArray = [NSMutableArray array];
            [model.adList enumerateObjectsUsingBlock:^(AdListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [imageGroupArray addObject:obj.image];
            }];
            weakSelf.vHomeHeader.imageGroupArray = imageGroupArray;
            [weakSelf.tbHome reloadData];
        }
    } failure:^(id request, NSError *error) {
        [IANshowLoading hideLoadingForView:self.view];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return self.listHeader.frame.size.height;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.listHeader;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        return [ETDynamicListCell dynamicListCell:tableView dict:_products[indexPath.row]];
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 128;
    return [ETDynamicListCell cellHeight];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict =[_products objectAtIndex:indexPath.row];
    ETProductModel* p=[ETProductModel mj_objectWithKeyValues:dict];
    if ([p.releaseTypeId isEqualToString:@"3"]) {
        ETServiceDetailController * detail=[ETServiceDetailController serviceDetailController:dict];
        detail.product=p;
        [self.navigationController pushViewController:detail animated:YES];
    }
    else{
    ETSaleDetailController* detail=[ETSaleDetailController saleDetailController:dict];
        detail.product=p;
    [self.navigationController pushViewController:detail animated:YES];
    }
}

#pragma mark -ETHomeHeaderViewDelegate
- (void)homeHeaderViewPushSearch {
    AMLog(@"11");
    FBSearchViewController* search = [FBSearchViewController new];
    [self.navigationController pushViewController:search animated:NO];
    
}

- (void)slideshowHeadViewDidSelectItemAtIndex:(NSInteger)index {
    
}
-(void)getJimName
{
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* userid=[user objectForKey:@"uid"];
    long long uid=[userid longLongValue];
    NSDictionary *params = @{
                             @"userId" : @(uid)
                             };
    [HttpTool get:[NSString stringWithFormat:@"user/getJimAuroraName"] params:params success:^(id responseObj) {
        NSLog(@"");
        if ([responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            return;
        }
        NSDictionary* a=responseObj[@"data"];
        EaseUserModel* model=[EaseUserModel new];
        model.nickname=[a objectForKey:@"username"];
        model.avatarURLPath=[a objectForKey:@"img"];
        model.buddy=[a objectForKey:@"auroraName"];
        [model bg_saveOrUpdate];
        
        //        NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
        //        NSDictionary* a=responseObj[@"data"];
        //        [user setObject:[a objectForKey:@"auroraName"] forKey:@"huanxin"];
        //        [user synchronize];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - 获取百度token
- (void)PostBaiduUI {
    
    NSDictionary *params = @{
                             @"grant_type" : @"client_credentials",
                             @"client_id": @"ECvVABCvGZ6D0huXWzfARIhG",
                             @"client_secret": @"NqPs01HjA2QTotblFGjChovPzKbxcuyv"
                             };
    static AFHTTPSessionManager *mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [AFHTTPSessionManager manager];
        
        mgr.requestSerializer = [AFJSONRequestSerializer serializer];
        mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html",@"text/json", @"text/plain", @"text/javascript", nil];
        mgr.requestSerializer.timeoutInterval = 10;
    });
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //secret
    NSMutableDictionary *newdic = [NSMutableDictionary dictionaryWithDictionary:params];
    NSData *jsonData =[NSJSONSerialization dataWithJSONObject:newdic options:NSJSONWritingPrettyPrinted error:nil];
    NSString* jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    // 2.发送POST请求
    [mgr POST:[NSString stringWithFormat:@"https://aip.baidubce.com/oauth/2.0/token?grant_type=client_credentials&client_id=%@&client_secret=%@&", @"ECvVABCvGZ6D0huXWzfARIhG",@"NqPs01HjA2QTotblFGjChovPzKbxcuyv"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary* a=responseObject[@"access_token"];
        NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
        [user setObject:responseObject[@"access_token"] forKey:@"access_token"];
        [user synchronize];
        NSLog(@"");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
- (void)PostuserinfoUI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    if (![user objectForKey:@"uid"]) {
        return;
    }
    NSDictionary *params = @{
                             @"uid" : [user objectForKey:@"uid"]
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"user/info"] params:params success:^(id responseObj) {
        //        _products=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        UserInfoModel* info=[UserInfoModel mj_objectWithKeyValues:responseObj[@"data"][@"userInfo"]];
        [UserInfoModel saveUserInfoModel:info];
        
        NSLog(@"");
        //        [_tableView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
