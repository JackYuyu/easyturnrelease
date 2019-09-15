//
//  ETStoreUpViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/23.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import "ETStoreUpViewController.h"
#import "ETEnterpriseServiceTableViewCell1.h"
#import "ETProductModel.h"

#import "ETServiceDetailController.h"
#import "ETSaleDetailController.h"
#import "ETPoctoryqgViewController.h"
#import "ETFavListCell.h"
@interface ETStoreUpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)UIButton *loadingBtn;
@property(nonatomic,strong)NSMutableArray*products;
@property(nonatomic,strong)NSMutableArray*details;

@property(nonatomic,strong)UIButton *deleBtn;
@property(nonatomic,strong)ETProductModel *m;
@end

@implementation ETStoreUpViewController
-  (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tab reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self enableLeftBackWhiteButton];
    self.title=@"我的收藏";
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tab];

    [self.tab registerClass:[ETEnterpriseServiceTableViewCell1 class] forCellReuseIdentifier:@"cell"];
     [self PostUI:@"1"];
}


- (UITableView *)tab
{
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-158) style:UITableViewStylePlain];
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



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _products.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETFavListCell* cell=[ETFavListCell dynamicListCell:tableView dict:_products[indexPath.row]];
    cell.imvLine.hidden=YES;
    _deleBtn =[[UIButton alloc]init];
    [_deleBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
    [cell addSubview:self.deleBtn];
    _deleBtn.layer.borderWidth=1;
    _deleBtn.layer.cornerRadius=4;
    _deleBtn.titleLabel.font=[UIFont systemFontOfSize:13 weight:9];
    _deleBtn.layer.borderColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0].CGColor;
    _deleBtn.tag=indexPath.row;
    [_deleBtn addTarget:self action:@selector(aaaa:) forControlEvents:UIControlEventTouchUpInside];
    [_deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(60, 26));
    }];
    return cell;

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
    
    NSDictionary *temp =[_products objectAtIndex:indexPath.row];
    
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
                             };
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    
    [HttpTool get:[NSString stringWithFormat:@"collect/my"] params:params success:^(NSDictionary *response) {
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        //        NSLog(@"%@",jsonDict);
        _products=[NSMutableArray new];
        _details=[NSMutableArray new];

        NSDictionary* a=response[@"data"];
//        for (NSDictionary* prod in response[@"data"]) {
//
//            ETProductModel* p=[ETProductModel mj_objectWithKeyValues:prod];
//            if (p) {
//                [_products addObject:p];
//
//            }
//        }
//        NSArray *array = [response objectForKey:@"data"];
//        if(array && ![array isKindOfClass:[NSNull class]]){
//            [_details addObjectsFromArray:array];
//        }
        NSArray *array = [response objectForKey:@"data"];
        if(array && ![array isKindOfClass:[NSNull class]]){
            [_products addObjectsFromArray:array];
            [_tab reloadData];
        }
//        [_tab reloadData];
    } failure:^(NSError *error) {
        
    }];
}
- (void)PostUI1:(NSInteger)b {
//    NSInteger m=_products.count;
    
    NSMutableDictionary* dic=[NSMutableDictionary new];
    ETProductModel* p=[ETProductModel mj_objectWithKeyValues:[_products objectAtIndex:b]];
    
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
