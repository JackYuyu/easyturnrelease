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

static NSString *const kETMineViewCell = @"ETMineViewCell";
@interface ETMineViewController ()<ETMineHeaderViewDelegate, JXPagerViewDelegate, JXCategoryViewDelegate>
///根控制器
@property (nonatomic, strong) JXPagerView *pagingView;
///头部视图
@property (nonatomic, strong) ETMineHeaderView *userHeaderView;
///横向滚动条
@property (nonatomic, strong) JXCategoryTitleView *categoryView;
///横向滚动条标题名称
@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (nonatomic, strong) ETMineListViewController *listView;
///数据源
@property (nonatomic, strong) NSMutableArray<UserInfosReleaseModel *> *arrDataSource;
///item选择当前索引
@property (nonatomic, assign) NSInteger categoryViewSelectedIndex;
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
    [self requestUserInfo];
    [self createSubViewsAndConstraints];
    
    
}

#pragma mark - createSubViewsAndConstraints
- (void)createSubViewsAndConstraints {
    
    _titles = @[@"出售", @"服务", @"求购"];
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
    
    self.navigationController.interactivePopGestureRecognizer.enabled = (self.categoryView.selectedIndex == 0);
    
    __weak typeof(self)weakSelf = self;
    self.pagingView.mainTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
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
        MCPageViewViewController *vc = [[MCPageViewViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
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

    }else if (indexPath.row == 6){
        ETStoreUpViewController*s= [ETStoreUpViewController new];
        [self.navigationController pushViewController:s animated:YES];

    }else if (indexPath.row == 7){
        
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
    if (index == 0) {
        listView.releaseTypeId = 1;
        
    }else if (index == 1) {
        listView.releaseTypeId = 3;
        
    }else if (index == 2){
         listView.releaseTypeId = 2;
    }
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

@end
