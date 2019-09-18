//
//  EaseSyetemController.m
//  AFNetworking
//
//  Created by 程立 on 2019/8/17.
//

#import "EaseSyetemController.h"
#import "EaseMessageModel.h"
#import "ETProductModel.h"
#import "ETPoctoryqgViewController.h"
#import "EaseSyetemListCell.h"
#import "EaseUserMeagessListCell.h"
#import "ETForBuyDetailController.h"
static NSString *const kEaseSyetemListCell = @"EaseSyetemListCell";
static NSString *const kEaseUserMeagessListCell = @"EaseUserMeagessListCell";
@interface EaseSyetemController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tab;
@property (nonatomic,strong) NSArray *list;
@property (nonatomic,strong) UIView *navigationView;
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) NSMutableArray *products;
@property (nonatomic,strong) NSMutableArray *arrayData;
@end

@implementation EaseSyetemController
- (UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - kNavBarHeight_StateBarH) style:UITableViewStylePlain];
        _tab.backgroundColor = kACColorWhite1_R242_G242_B242_A1;
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tab.showsVerticalScrollIndicator = NO;
        _tab.tableFooterView = [[UIView alloc]init];
        [_tab registerClass:[EaseSyetemListCell class] forCellReuseIdentifier:kEaseSyetemListCell];
        [_tab registerClass:[EaseUserMeagessListCell class] forCellReuseIdentifier:kEaseUserMeagessListCell];
    }
    return _tab;
}
-(void)viewWillAppear:(BOOL)animated
{
    _list = [EaseMessageModel bg_findAll:@"EaseMessageModel"];
    [_tab reloadData];
    [self wr_setNavBarTitleColor:kACColorBlackTypeface];
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:kACColorWhite];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self wr_setNavBarTitleColor:kACColorWhite];
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:kACColorBlue_Theme];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self enableLeftBackButton];
    if (_index==0) {
        self.title=@"易转官方平台";
    }
    else
        self.title=@"求购推送消息";
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.view addSubview:self.tab];
    [self PostUI];
    if (_index==1) {
        [self getsee];
    }
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_index==0) {
        if (!_list) {
            return 1;
        }else
            return _list.count;
    }else{
    if (!_products) {
        return 1;
    }else
        return _products.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_index==0) {
        ETProductModel* model = [_list objectAtIndex:indexPath.row];
        EaseSyetemListCell *cell = [tableView dequeueReusableCellWithIdentifier:kEaseSyetemListCell];
        [cell makeCellWithETProductModel:model WithIndexPath:indexPath];
        return cell;
    }else {
        ETProductModel* model = [_products objectAtIndex:indexPath.row];
        EaseUserMeagessListCell *cell = [EaseUserMeagessListCell new];
        [cell makeCellWithETProductModel:model WithIndexPath:indexPath];
        
        if (indexPath.row==_products.count-1) {
            UIImageView* bad=[UIImageView new];
            [bad setBackgroundColor:[UIColor redColor]];
            bad.layer.cornerRadius=10;
            bad.layer.masksToBounds=YES;
            
            UILabel* c=[UILabel new];
            c.text=@"新";
            c.textColor=[UIColor whiteColor];
            c.font=[UIFont systemFontOfSize:10];
            [bad addSubview:c];
            
            [cell.contentView addSubview:bad];
            [bad mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(cell).mas_equalTo(15);
                make.top.mas_equalTo(cell).mas_equalTo(10);

                make.size.mas_equalTo(20,20);
//                make.centerY.mas_equalTo(cell);
            }];
            
            [c mas_makeConstraints:^(MASConstraintMaker *make) {
                make.size.mas_equalTo(10,10);
                make.center.mas_equalTo(bad);
            }];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_index==0) {
        return 100;
    }else {
        return 116;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    ETProductModel* p=[_products objectAtIndex:indexPath.row];
//    ETPoctoryqgViewController* qg=[[ETPoctoryqgViewController alloc] init];
//    qg.releaseId=p.releaseId;
    
    NSDictionary *dict =[self.arrayData objectAtIndex:indexPath.row];

    ETForBuyDetailController* pur=[ETForBuyDetailController forBuyDetailController:dict];
    ETProductModel* p=[ETProductModel mj_objectWithKeyValues:dict];
    pur.releaseId=p.releaseId;
    pur.releaseId = dict[@"releaseId"];
    pur.product = [ETProductModel mj_objectWithKeyValues:dict];
    [self.navigationController pushViewController:pur animated:YES];
    
}

-(void)PostUI {
    WEAKSELF
    [HttpTool get:[NSString stringWithFormat:@"search/messageList2"] params:nil success:^(id responseObj) {
        if ([responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            return;
        }
        self.arrayData=[NSMutableArray new];
        weakSelf.products=[NSMutableArray array];
        for (NSDictionary* prod in responseObj[@"data"]) {
            ETProductModel *p = [ETProductModel mj_objectWithKeyValues:prod];
            [weakSelf.products addObject:p];
        }
        [weakSelf.tab reloadData];
//        NSIndexPath* path=[NSIndexPath indexPathWithIndex:weakSelf.products.count-1];
//        [weakSelf.tab scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        if (_index==1) {

            if(_products.count > 0){
                NSIndexPath *indexpath = [NSIndexPath indexPathForRow:_products.count-1  inSection:0];
                [_tab scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        }
        }
        else{
            if(_list.count > 0){
                NSIndexPath *indexpath = [NSIndexPath indexPathForRow:_list.count-1  inSection:0];
                
                [_tab scrollToRowAtIndexPath:indexpath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            }
        }
        [self.arrayData addObjectsFromArray:responseObj[@"data"]];

    } failure:^(NSError *error) {
      
    }];
}
-(void)getsee
{
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    NSString* token=[user objectForKey:@"token"];
    // 1.获得请求管理者
    static AFHTTPSessionManager *mgr = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    });
    [mgr.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    // 2.发送GET请求
    [mgr GET:[NSString stringWithFormat:@"%@/%@", @"https://app.yz-vip.cn", @"push/see"] parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
        //        _touserAvat=responseObject[@"data"];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}
@end
