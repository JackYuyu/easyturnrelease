//
//  ETAccountViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/20.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import "ETAccountViewController.h"
#import "Masonry.h"
#import "ETPusCashViewController.h"
#import "ETZhangViewController.h"
#import "ETProductModel.h"
@interface ETAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSMutableArray*products;
@property(nonatomic,strong)UIButton *btn;
@property(nonatomic,strong)NSString*change;

@end

@implementation ETAccountViewController

-(UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.backgroundColor=[UIColor whiteColor];
        _tab.bounces=NO;
        _tab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    }
    return _tab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
      self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"账单记录" style:UIBarButtonItemStylePlain target:self action:@selector(tiaoZhang)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
  
    self.title=@"账户余额";
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont systemFontOfSize:18]};
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
    [self.view addSubview:self.tab];
    [self.tab addSubview:self.btn];
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(79);
        make.left.mas_equalTo(39);
        make.right.mas_equalTo(self.view).mas_offset(-39);
        make.height.mas_equalTo(39);

//        make.size.mas_equalTo(CGSizeMake(281, 39));
    }];
    [self PostUI];
}
- (void)tiaoZhang {
    ETZhangViewController *zhangVC=[[ETZhangViewController alloc]init];
    [self.navigationController pushViewController:zhangVC animated:YES];
}

- (void)PostUI{
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"pay/findUsersPocketMoney"] params:params success:^(id responseObj) {
     NSString* a=responseObj[@"data"];
        _change=a;
        [_tab reloadData];
    } failure:^(NSError *error) {
        _change=@"0.0";
        [_tab reloadData];
        NSLog(@"%@",error);
    }];
}

- (UIButton *)btn
{
    if (!_btn)
    {
        _btn=[[UIButton alloc]init];
        [_btn setTitle:@"提现" forState:UIControlStateNormal];
        _btn.backgroundColor=[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
        [_btn addTarget:self action:@selector(puchash) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btn;
}


- (void)puchash
{
    ETPusCashViewController*push=[[ETPusCashViewController alloc]init];
    UIBarButtonItem *backItem = [UIBarButtonItem new];
    backItem.title = @"";
    push.change=_change;
    self.navigationItem.backBarButtonItem = backItem;
    [self.navigationController pushViewController:push animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }    
    cell.imageView.image=[UIImage imageNamed:@""];
    cell.textLabel.text=@"账户余额";
    ETProductModel* p=[_products objectAtIndex:0];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"¥%@",_change];
//    cell.detailTextLabel.text=[NSString stringWithFormat:@"¥%@",_products];
    cell.detailTextLabel.textColor=[UIColor colorWithRed:248/255.0 green:124/255.0 blue:43/255.0 alpha:1.0];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tab deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 2
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    // 3点击没有颜色改变
    cell.selected = NO;
}
@end
