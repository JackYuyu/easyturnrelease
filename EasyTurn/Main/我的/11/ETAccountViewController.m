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
@interface ETAccountViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)UIButton *btn;
@end

@implementation ETAccountViewController

-(UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.tableFooterView = [[UIView alloc]init];
    }
    return _tab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"账单记录" style:UIBarButtonItemStylePlain target:0 action:nil];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor colorWithRed:230/242.0 green:230/242.0 blue:230/242.0 alpha:1.0];
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
        make.size.mas_equalTo(CGSizeMake(281, 39));
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
    cell.detailTextLabel.text=@"$360";
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
