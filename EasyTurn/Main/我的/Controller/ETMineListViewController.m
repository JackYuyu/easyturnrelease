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
static NSString *const kETMineListViewCell = @"ETMineListViewCell";
@interface ETMineListViewController()<UITableViewDataSource, UITableViewDelegate, ETMineListViewCellDelegate>
@property (nonatomic, copy) void(^scrollCallback)(UIScrollView *scrollView);
///页码
@property (nonatomic, assign) NSInteger pageNumber;
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

- (void)viewDidLoad {
    [self.view addSubview:self.tableView];
    [self requestUserOrderListWithReleaseTypeId:self.releaseTypeId];
    
}

#pragma mark - 请求网络
- (void)requestUserOrderListWithReleaseTypeId:(NSInteger )releaseTypeId {
    WEAKSELF
    //赋值初始值
    self.pageNumber = 1;
    [ETMineViewModel requestUserOrderListWithPage:self.pageNumber WithPageSize:1 ReleaseTypeId:releaseTypeId WithSuccess:^(id request, STResponseModel *response, id resultObject) {
        if (response.code == 0) {
            NSArray *array = resultObject[@"data"];
            NSMutableArray *products = [NSMutableArray array];
            [products addObjectsFromArray:array];
            weakSelf.arrDataSource = [UserInfosReleaseModel mj_objectArrayWithKeyValuesArray:products];
            [weakSelf.tableView reloadData];
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
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.scrollCallback(scrollView);
}

#pragma mark - ETMineListViewCellDelegate
- (void)onCLickETMineListViewCellButtonType:(UIButton *)sender {
    if (sender.tag == 1000) {
        //分享
    }else if (sender.tag == 1001){
        //刷新
    }else if (sender.tag == 1002){
        //删除
    }else if (sender.tag == 1003){
        //查看
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
