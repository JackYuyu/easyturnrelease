//
//  ETRealTimeBuyListVC.m
//  EasyTurn
//
//  Created by 刘盖 on 2019/8/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETRealTimeBuyListVC.h"
#import "IANshowLoading.h"
#import "ETRealTimeBuyListCell.h"
#import "ETSaleDetailController.h"
#import "ETCartViewController.h"
#import "ETPoctoryqgViewController.h"
#import "ETPoctoryqgServiceViewController.h"
#import "ETForBuyDetailController.h"
@interface ETRealTimeBuyListVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrayData;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger pageSize;

@end

@implementation ETRealTimeBuyListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self enableLeftBackWhiteButton];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"实时求购";
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = RGBACOLOR(242, 242, 242, 1);
    self.tableView.frame = CGRectMake(0, 0, Screen_Width, Screen_Height-[UIApplication sharedApplication].statusBarFrame.size.height-44);
    self.page = 1;
    self.pageSize = 10;
    [self requestData:YES];
}

- (NSMutableArray *)arrayData{
    if (!_arrayData) {
        _arrayData = [NSMutableArray array];
    }
    return _arrayData;
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
        WeakSelf(self);
        _tableView.mj_header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
            [weakself requestData:YES];
        }];
    }
    return _tableView;
}


- (void)requestData:(BOOL)isHeader{
    if (isHeader) {
        self.page=1;
        [IANshowLoading showLoadingForView:self.view];
        [self.arrayData removeAllObjects];
        [self.tableView reloadData];
    }
    WeakSelf(self);
    NSDictionary *params = @{
                             @"releaseTypeId":@(2),
                             @"page": @(self.page),
                             @"pageSize": @(self.pageSize)
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"release/releaseList"] params:params success:^(id responseObj) {
        [weakself handleData:responseObj isFailed:NO];
        NSLog(@"%@",responseObj);
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        [weakself handleData:nil isFailed:YES];
    }];
}

- (void)handleData:(NSDictionary *)responseObj isFailed:(BOOL)isFailed{
    [IANshowLoading hideLoadingForView:self.view];
    if (self.tableView.mj_header) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer) {
        [self.tableView.mj_footer endRefreshing];
    }
    if (responseObj && [responseObj isKindOfClass:[NSDictionary class]]) {
        NSArray *array = [responseObj objectForKey:@"data"][@"rows"];
        
        NSInteger total = [[responseObj objectForKey:@"data"][@"total"] integerValue];
        total=total/self.pageSize+1;
        self.page++;
        
        if(self.page<=total){
            
            if (!self.tableView.mj_footer) {
                WeakSelf(self);
                self.tableView.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
                    [weakself requestData:NO];
                }];
            }
        }
        else{
            [self.tableView.footer noticeNoMoreData];
//            self.tableView.mj_footer = nil;
        }
        if(array && ![array isKindOfClass:[NSNull class]]){
            [self.arrayData addObjectsFromArray:array];
            [self.tableView reloadData];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrayData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ETRealTimeBuyListCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ETRealTimeBuyListCell realTimeBuyListCell:tableView dict:self.arrayData[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict =[self.arrayData objectAtIndex:indexPath.row];
//    ETCartViewController* pur=[ETCartViewController new];
    
//    ETPoctoryqgViewController* pur=[ETPoctoryqgViewController new];
//    ETPoctoryqgServiceViewController* pur=[ETPoctoryqgServiceViewController new];
    ETForBuyDetailController* pur=[ETForBuyDetailController forBuyDetailController:dict];
    ETProductModel* p=[ETProductModel mj_objectWithKeyValues:dict];
    pur.releaseId=p.releaseId;
    pur.releaseId = dict[@"releaseId"];
    pur.product = [ETProductModel mj_objectWithKeyValues:dict];
    [self.navigationController pushViewController:pur animated:YES];
}
@end
