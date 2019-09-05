//
//  ETDynamicListVC.m
//  EasyTurn
//
//  Created by 刘盖 on 2019/8/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETDynamicListVC.h"
#import "ETDynamicListSegment.h"
#import "IANshowLoading.h"
#import "ETDynamicListCell.h"
#import "ETSaleDetailController.h"
#import "ETServiceDetailController.h"
#import "ETProductModel.h"
@interface ETDynamicListVC ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) ETDynamicListSegment *segView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *arrayData;

@property (nonatomic,copy) NSString *cityNum;
@property (nonatomic,assign) NSInteger segIndex;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign) NSInteger pageSize;
@end

@implementation ETDynamicListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"动态列表";
    self.segIndex = 0;
    self.cityNum = @"0";
    self.page = 1;
    self.pageSize = 10;
    [self enableLeftBackWhiteButton];

    WeakSelf(self);
    self.segView = [ETDynamicListSegment dynamicListSegmentWithClick:^(NSInteger segIndex, NSString * _Nonnull cityId) {
        weakself.segIndex = segIndex;
        if (segIndex == 0) {
            weakself.cityNum = cityId;
        }
        [weakself requestData:YES];
    }];
    [self.view addSubview:self.segView];
    
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = RGBACOLOR(242, 242, 242, 1);
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.segView.frame), Screen_Width, Screen_Height-[UIApplication sharedApplication].statusBarFrame.size.height-44-self.segView.frame.size.height);
    [self.view bringSubviewToFront:self.segView];
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
        self.page = 1;
        [IANshowLoading showLoadingForView:self.view];
        [self.arrayData removeAllObjects];
        [self.tableView reloadData];
    }
    WeakSelf(self);
    NSInteger typeId = 0;
    if (self.segIndex == 1) {
        typeId = 1;
    }
    else if (self.segIndex == 2){
        typeId = 3;
    }
    NSDictionary *params = @{
                             @"cityId": self.cityNum,
                             @"typeId": @(typeId),
                             @"page": @(self.page),
                             @"pageSize": @(self.pageSize)
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"release/cityDynamic"] params:params success:^(id responseObj) {
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
        id code = [responseObj objectForKey:@"code"];
        if (code && [code integerValue]==0) {
            NSInteger total = [[responseObj objectForKey:@"data"][@"total"] integerValue];
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
                self.tableView.mj_footer = nil;
            }
            NSArray *array = [responseObj objectForKey:@"data"][@"rows"];
            if(array && ![array isKindOfClass:[NSNull class]]){
                [self.arrayData addObjectsFromArray:array];
                [self.tableView reloadData];
            }
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
    return [ETDynamicListCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ETDynamicListCell dynamicListCell:tableView dict:self.arrayData[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict =[self.arrayData objectAtIndex:indexPath.row];
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
@end
