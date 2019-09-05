//
//  ETRealtimePurchaseViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/8/1.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETRealtimePurchaseViewController.h"
#import "ETEnterpriseServiceTableViewCell1.h"
#import "ETProductModel.h"
#import "ETSaleDetailController.h"
@interface ETRealtimePurchaseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic, strong)UIView *searchView;
@property (nonatomic, strong) UITextField *searchTextField;
@property (nonatomic, strong) NSMutableArray *products;

@end

@implementation ETRealtimePurchaseViewController

- (UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.rowHeight=123;
        [_tab registerClass:[ETEnterpriseServiceTableViewCell1 class] forCellReuseIdentifier:@"cell"];
    }
    return _tab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tab];
//    self.searchView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, Screen_Width -20 - 50, 30)];
//    self.searchView.backgroundColor = [UIColor xm_colorFromRGB:0xF8F8F8];
//    self.searchView.clipsToBounds = YES;
//    self.searchView.layer.cornerRadius = 15.0;
//    self.navigationItem.titleView = self.searchView;
    [self PostUI];
}
#pragma mark - 企服者
- (void)PostUI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             @"serviceId" : @"4"
                             };
    [HttpTool get:[NSString stringWithFormat:@"release/releaseClassify"] params:params success:^(id responseObj) {
        _products=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        for (NSDictionary* prod in responseObj[@"data"]) {
            ETProductModel* p=[ETProductModel mj_objectWithKeyValues:prod];
            p.dictInfo = prod;
            [_products addObject:p];
        }
        //        NSLog(@"");
        [_tab reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_products count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ETEnterpriseServiceTableViewCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    ETProductModel* p=[_products objectAtIndex:indexPath.row];
    cell.giveserviceLab.text=p.title;
    [cell.comImg sd_setImageWithURL:[NSURL URLWithString:p.imageList] placeholderImage:nil];
    cell.moneyLab.text=p.price;
    cell.addressLab.text=p.cityName;
    cell.detailsLab.text=p.detail;
    if ([p.releaseTypeId isEqualToString:@"1"]) {
        UIImageView* jiao=[UIImageView new];
        [jiao setImage:[UIImage imageNamed:@"首页_出售"]];
        [cell.comImg addSubview:jiao];
        [jiao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(35);
            make.height.mas_equalTo(35);
        }];
    }
    if ([p.releaseTypeId isEqualToString:@"3"]) {
        UIImageView* jiao=[UIImageView new];
        [jiao setImage:[UIImage imageNamed:@"首页_企服者"]];
        [cell.comImg addSubview:jiao];
        [jiao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(35);
            make.height.mas_equalTo(35);
        }];
    }
    if ([p.releaseTypeId isEqualToString:@"2"]) {
        UIImageView* jiao=[UIImageView new];
        [jiao setImage:[UIImage imageNamed:@"首页_求购"]];
        [cell.comImg addSubview:jiao];
        [jiao mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(35);
            make.height.mas_equalTo(35);
        }];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tab deselectRowAtIndexPath:indexPath animated:YES];
    
    ETEnterpriseServiceTableViewCell1 *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 2
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    // 3点击没有颜色改变
    cell.selected = NO;
    
    
    ETProductModel* pm =[_products objectAtIndex:indexPath.row];
    ETSaleDetailController* p=[ETSaleDetailController saleDetailController:pm.dictInfo];
    [self.navigationController pushViewController:p animated:YES];
}

@end
