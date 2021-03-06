//
//  ETSynViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/8/30.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETSynViewController.h"
#import "ETEnterpriseServiceTableViewCell1.h"
#import "ETProductModel.h"
#import "ETSaleDetailController.h"
#import "ETDynamicListCell.h"
#import "ETEnterpriseServiceListSegment.h"
#import "ETServiceDetailController.h"
@interface ETSynViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic, strong)UIView *searchView;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) NSMutableArray *products;
@property (nonatomic,strong) ETEnterpriseServiceListSegment *segment;
@property (nonatomic,assign) NSInteger order;
@property (nonatomic,assign) NSInteger cityId;

@end

@implementation ETSynViewController

- (UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-123) style:UITableViewStylePlain];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.rowHeight=123;
        _tab.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        [_tab registerClass:[ETEnterpriseServiceTableViewCell1 class] forCellReuseIdentifier:@"cell"];
    }
    return _tab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self enableLeftBackWhiteButton];
    _order=0;
    _cityId=0;
    
    WeakSelf(self);
    self.segment = [ETEnterpriseServiceListSegment enterpriseServiceListSegment:^(NSInteger segIndex, NSString * _Nonnull itemId) {
        NSLog(@"");
        if (segIndex==1&&[itemId isEqualToString:@"2"]) {
            _order=1;
        }
        else
            _order=0;
        if (segIndex==0) {
            _cityId=[itemId integerValue];
        }
        [weakself PostUI];
    }];
    [self.view addSubview:self.segment];
    [self.view addSubview:self.tab];
    self.searchView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, Screen_Width -20 - 50, 30)];
    self.searchView.backgroundColor = [UIColor xm_colorFromRGB:0xF8F8F8];
    self.searchView.clipsToBounds = YES;
    self.searchView.layer.cornerRadius = 15.0;
    //    self.navigationItem.titleView = self.searchView;
    
    self.searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, 2, Screen_Width -20 - 80, 26)];
    self.searchTextField.placeholder = @"搜索个关键词试试";
    self.searchTextField.font = [UIFont systemFontOfSize:13.0];
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchTextField.delegate = self;
    [self.searchView addSubview:self.searchTextField];
    
    self.tab.backgroundColor = RGBACOLOR(242, 242, 242, 1);
    self.tab.frame = CGRectMake(0, CGRectGetMaxY(self.segment.frame), Screen_Width, Screen_Height-[UIApplication sharedApplication].statusBarFrame.size.height-44-self.segment.frame.size.height);
    [self.view bringSubviewToFront:self.segment];
    [self PostUI];
//    [self setNavi];

}
#pragma mark - 企服者
- (void)PostUI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             @"serviceId" : @"6",
                             @"cityId" : @(_cityId),
                             @"type" : @(_order),
                             @"page" : @(1),
                             @"size" : @(100)
                             
                             };
    [HttpTool get:[NSString stringWithFormat:@"release/findReleasesByPriceAndCity"] params:params success:^(id responseObj) {
        _products=[NSMutableArray new];
        //        NSDictionary* a=responseObj[@"data"];
        //        for (NSDictionary* prod in responseObj[@"data"]) {
        //            ETProductModel* p=[ETProductModel mj_objectWithKeyValues:prod];
        //            [_products addObject:p];
        //        }
        //        //        NSLog(@"");
        //        [_tab reloadData];
        if (responseObj && [responseObj isKindOfClass:[NSDictionary class]]) {
            NSArray *array = responseObj[@"data"][@"rows"];
            if(array && ![array isKindOfClass:[NSNull class]]){
                [_products addObjectsFromArray:array];
                [_tab reloadData];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ETDynamicListCell dynamicListCell:tableView dict:_products[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tab deselectRowAtIndexPath:indexPath animated:YES];
    
    ETEnterpriseServiceTableViewCell1 *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 2
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    // 3点击没有颜色改变
    cell.selected = NO;
    
    NSDictionary *dict =[_products objectAtIndex:indexPath.row];
    ETServiceDetailController* p=[ETServiceDetailController serviceDetailController:dict];
    [self.navigationController pushViewController:p animated:YES];
}

@end
