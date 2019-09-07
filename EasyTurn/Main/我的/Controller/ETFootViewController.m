//
//  ETStoreUpViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/23.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import "ETFootViewController.h"
#import "ETEnterpriseServiceTableViewCell1.h"
#import "ETProductModel.h"
#import "ETFootListCell.h"
#import "ETServiceDetailController.h"
#import "ETSaleDetailController.h"
#import "ETPoctoryqgViewController.h"
#import "XMRefreshFooter.h"
@interface ETFootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)UIButton *loadingBtn;
@property(nonatomic,strong)NSMutableArray*products;
@property(nonatomic,strong)UIButton *deleBtn;
@property(nonatomic,strong)ETProductModel *m;

@property(nonatomic, assign)NSInteger pageSize;
@property(nonatomic, assign)NSInteger page;
@end

@implementation ETFootViewController
-  (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tab reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title=@"访问记录";
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tab];
//    [self.view addSubview:self.loadingBtn];
    [self.tab registerClass:[ETEnterpriseServiceTableViewCell1 class] forCellReuseIdentifier:@"cell"];
    self.pageSize = 10;
    self.page = 1;
     [self PostUI:@"1"];
    _products=[NSMutableArray new];
    WEAKSELF
    _tab.mj_footer = [XMRefreshFooter xm_footerWithRefreshingBlock:^{
//        self.page += 1;
        [weakSelf PostUI:@"1"];
    }];
}


- (UITableView *)tab
{
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.rowHeight=158;
        _tab.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    }
    return _tab;
}

- (UIButton *)loadingBtn {
    if (!_loadingBtn) {
        _loadingBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 50)];
        [_loadingBtn setTitle:@"点击加载更多" forState:UIControlStateNormal];
        [_loadingBtn setTitle:@"" forState:UIControlStateSelected];
        _loadingBtn.selected=YES;
        [_loadingBtn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
        
    }
    return _loadingBtn;
}


#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [ETFootListCell cellHeight];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _products.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [ETFootListCell dynamicListCell:tableView dict:_products[indexPath.row]];
}
- (void)aaaa:(UIButton*)sender {
    [self PostUI1:sender.tag];
    NSLog(@"1");
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tab deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 2
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    // 3点击没有颜色改变
    cell.selected = NO;
    NSDictionary *dict =[_products objectAtIndex:indexPath.row];
    NSMutableDictionary* temp0=[dict mutableCopy];

    dict=dict[@"releases"];
    NSMutableDictionary* temp=[dict mutableCopy];
    [temp setObject:temp0[@"releaseId"] forKey:@"releaseId"];
    ETProductModel* p=[ETProductModel mj_objectWithKeyValues:temp];
    if ([p.releaseTypeId isEqualToString:@"3"]) {
        ETServiceDetailController * detail=[ETServiceDetailController serviceDetailController:temp];
        detail.product=p;
        [self.navigationController pushViewController:detail animated:YES];
    }
    else if([p.releaseTypeId isEqualToString:@"1"]){
        ETSaleDetailController* detail=[ETSaleDetailController saleDetailController:temp];
        detail.product=p;
        [self.navigationController pushViewController:detail animated:YES];
    }
    else{
        ETPoctoryqgViewController* pur=[ETPoctoryqgViewController new];
        ETProductModel* p=[ETProductModel mj_objectWithKeyValues:temp];
        pur.releaseId=p.releaseId;
        pur.releaseId = temp[@"releaseId"];
        pur.product = [ETProductModel mj_objectWithKeyValues:temp];
        [self.navigationController pushViewController:pur animated:YES];
    }
}

- (void)PostUI:(NSString*)head {
    NSDictionary *params = @{
                             @"page": @(self.page),
                             @"size": @(self.pageSize)
                             };
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    
    [HttpTool get:[NSString stringWithFormat:@"releaseHistory/findAll"] params:params success:^(NSDictionary *response) {

        if (response && [response isKindOfClass:[NSDictionary class]]) {

            
            NSInteger total = [[response objectForKey:@"data"][@"total"] integerValue];
            total=total/10+1;
            self.page++;
            
            if(self.page<=total){
                
                if (!_tab.mj_footer) {
                    WeakSelf(self);
                    _tab.mj_footer = [MJRefreshBackGifFooter footerWithRefreshingBlock:^{
                        [weakself PostUI:@"1"];

                    }];
                }
            }
            else{
                _tab.mj_footer = nil;
            }
            NSArray *array = [response objectForKey:@"data"][@"rows"];
            if(array && ![array isKindOfClass:[NSNull class]]){
                [_products addObjectsFromArray:array];
                [_tab reloadData];
            }
        }
    } failure:^(NSError *error) {
        
    }];
}
- (void)PostUI1:(NSInteger)b {
//    NSInteger m=_products.count;
    
    NSMutableDictionary* dic=[NSMutableDictionary new];
    ETProductModel* p=[_products objectAtIndex:b];
    
    long long a=[p.releaseId longLongValue];
    NSDictionary *params = @{
                             @"releaseId" : @(a)
                             };
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    
    [HttpTool put:[NSString stringWithFormat:@"collect/myDel"] params:params success:^(NSDictionary *response) {
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
      
        NSLog(@"");
                [_products removeObjectAtIndex:b];
        [_tab reloadData];
    } failure:^(NSError *error) {
        NSLog(@"");
    }];

}
@end
