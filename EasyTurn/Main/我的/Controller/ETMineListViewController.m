//
//  TestListBaseView.m
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/27.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "ETMineListViewController.h"
#import "ETMineListViewCell.h"
#import "ETMineViewModel.h"
#import "ETSaleDetailController.h"
#import "ETServiceDetailController.h"
#import "ETPoctoryqgViewController.h"
static NSString *const kETMineListViewCell = @"ETMineListViewCell";
@interface ETMineListViewController()<UITableViewDataSource, UITableViewDelegate, ETMineListViewCellDelegate>
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
///页码
@property (nonatomic, assign) NSInteger pageNumber;
@property (nonatomic, strong) NSMutableArray *products;
@end

@implementation ETMineListViewController

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - 40 - kNavBarHeight_StateBarH) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [UIView new];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[ETMineListViewCell class] forCellReuseIdentifier:kETMineListViewCell];
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(reloadMoreData)];
    }
    return _tableView;
}

- (NSMutableArray *)products {
    if (!_products) {
        _products = [NSMutableArray array];
    }
    return _products;
}

- (void)viewDidLoad {
    [self.view addSubview:self.tableView];
    [self requestUserOrderListWithReleaseTypeId:self.releaseTypeId];
    
   
}

- (void)showEmptyDataView:(BOOL)isHidden {
    
    UIView *showEmptyDataView = [[UIView alloc]init];
    [self.view addSubview:showEmptyDataView];
    [showEmptyDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(143, 132));
    }];
    
    UIImageView *imagevEmptyData = [[UIImageView alloc]init];
    imagevEmptyData.hidden = isHidden;
    imagevEmptyData.image = [UIImage imageNamed:@"我的_我的动态_空数据页面"];
    [self.view addSubview:imagevEmptyData];
    [imagevEmptyData mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(143, 132));
    }];
}

#pragma mark - 请求网络
- (void)requestUserOrderListWithReleaseTypeId:(NSInteger )releaseTypeId {
    WEAKSELF
    //赋值初始值
    self.pageNumber = 1;
    [ETMineViewModel requestUserOrderListWithPage:self.pageNumber WithPageSize:1 ReleaseTypeId:releaseTypeId WithSuccess:^(id request, STResponseModel *response, id resultObject) {
        if (response.code == 0) {
            NSArray *array = resultObject[@"data"];
            if (array.count == 0) {
                [weakSelf showEmptyDataView:NO];
            }else {
                [weakSelf.products addObjectsFromArray:array];
                NSMutableArray *products = [NSMutableArray array];
                [products addObjectsFromArray:array];
                weakSelf.arrDataSource = [UserInfosReleaseModel mj_objectArrayWithKeyValuesArray:products];
                [weakSelf.tableView reloadData];
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

#pragma mark - 下拉加载更多
- (void)reloadMoreData {
    WEAKSELF
    self.pageNumber = self.pageNumber + 1;
    [ETMineViewModel requestUserOrderListWithPage:self.pageNumber WithPageSize:1 ReleaseTypeId:self.releaseTypeId WithSuccess:^(id request, STResponseModel *response, id resultObject) {
        if (response.code == 0) {
            NSArray *array = resultObject[@"data"];
            NSMutableArray *products = [NSMutableArray array];
            [products addObjectsFromArray:array];
            weakSelf.arrDataSource = [UserInfosReleaseModel mj_objectArrayWithKeyValuesArray:products];
            [weakSelf.tableView reloadData];
            [weakSelf.tableView.mj_footer endRefreshing];
            if (weakSelf.arrDataSource.count == 0) {
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if (response.msg.length > 0) {
                [[ACToastView toastView:YES] showErrorWithStatus:response.msg];
            } else {
                [[ACToastView toastView:YES] showErrorWithStatus:kToastErrorServerNoErrorMessage];
            }
            [weakSelf.tableView.mj_footer endRefreshing];
        }
    } failure:^(id request, NSError *error) {
        [weakSelf.tableView.mj_footer endRefreshing];
    }];
    
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserInfosReleaseModel *model = self.arrDataSource[indexPath.row];
    ETMineListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kETMineListViewCell];
    cell.delegate = self;
    [cell makeCellWithUserInfosReleaseModel:model indexPath:indexPath];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 160;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.releaseTypeId == 1) {
        //出售
        NSDictionary *dict =[self.products objectAtIndex:indexPath.row];
        ETSaleDetailController *vc = [ETSaleDetailController saleDetailController:dict];
        vc.product = [ETProductModel mj_objectWithKeyValues:dict];
        [self.naviController pushViewController:vc animated:YES];
        
    }else if (self.releaseTypeId == 3) {
        //服务
        NSDictionary *dict =[_products objectAtIndex:indexPath.row];
        ETServiceDetailController * detail = [ETServiceDetailController serviceDetailController:dict];
        detail.product = [ETProductModel mj_objectWithKeyValues:dict];
        [self.naviController pushViewController:detail animated:YES];
        
    }else if (self.releaseTypeId == 2) {
        //求购
        ETPoctoryqgViewController *detail = [ETPoctoryqgViewController new];
        NSDictionary *dict =[_products objectAtIndex:indexPath.row];
        detail.releaseId = dict[@"releaseId"];
        detail.product = [ETProductModel mj_objectWithKeyValues:dict];
        [self.naviController pushViewController:detail animated:YES];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.scrollCallback(scrollView);
}

#pragma mark - ETMineListViewCellDelegate
- (void)onCLickETMineListViewCellButtonType:(UIButton *)sender WithIndexPath:(NSIndexPath *)indexPath {
        UserInfosReleaseModel *model = self.arrDataSource[indexPath.row];
    if ([_delegate respondsToSelector:@selector(eTMineListViewController:WithButtonType:WithReleaseId:)]) {
        [_delegate eTMineListViewController:self WithButtonType:sender WithReleaseId:model.releaseId];
    }
  
}


#pragma mark - JXPagingViewListViewDelegate

- (UIScrollView *)listScrollView {
    return self.tableView;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self.view;
}



@end
