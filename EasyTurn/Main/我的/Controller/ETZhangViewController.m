//
//  ETZhangViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/8/2.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETZhangViewController.h"
#import "ETZhangTableViewCell.h"
#import "ETProductModel.h"

@interface ETZhangViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tab;
@property (nonatomic,strong)NSMutableArray *produte;
@end

@implementation ETZhangViewController

- (UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.rowHeight=89;
        _tab.tableFooterView = [[UIView alloc] init];
        [_tab registerClass:[ETZhangTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"账单记录";
    [self.view addSubview:self.tab];
    [self PostUI];
}
- (void)PostUI
{
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"pay/findUserOrders"] params:params success:^(id responseObj) {
        _produte=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        for (NSDictionary* prod in responseObj[@"data"]) {
            ETProductModel* p=[ETProductModel mj_objectWithKeyValues:prod];
            [_produte addObject:p];
        }
        [_tab reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _produte.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    ETZhangTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    cell=[[ETZhangTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    ETZhangTableViewCell *cell=[ETZhangTableViewCell new];
    ETProductModel* p=[_produte objectAtIndex:indexPath.row];
    [cell.phoneImg sd_setImageWithURL:[NSURL URLWithString:p.images]];
    cell.comLab.text=p.title;
    cell.orderformLab.text=[NSString stringWithFormat:@"订单编号:%@",p.orderid];
    cell.timeLab.text=p.payTime;
    cell.numberLab.text=[NSString stringWithFormat:@"¥:%@",p.price];
    return cell;
}

@end
