//
//  ETPassWordViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/23.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import "ETPassWordViewController.h"

@interface ETPassWordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSArray *arr;

@end

@implementation ETPassWordViewController

-(UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.tableFooterView = [[UIView alloc]init];
        _tab.rowHeight=55.5;
    }
    return _tab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:0 action:nil];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"设置密码";
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont systemFontOfSize:18]};
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
    [self.view addSubview:self.tab];
}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 2;
//}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    if (indexPath.row==0) {
        UILabel *lab=[[UILabel alloc]init];
        [cell addSubview:lab];
        lab.text=@"请输入原密码";
        lab.font=[UIFont systemFontOfSize:12];
        lab.textColor=[UIColor blackColor];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(17);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(95, 21));
        }];
        
        UITextField*text1=[[UITextField alloc]init];
//        text1.placeholder=@"输入密码";
        [cell addSubview:text1];
        
        [text1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
             make.left.mas_equalTo(109);
             make.size.mas_equalTo(CGSizeMake(100, 32));
            
        }];
        
    }else if (indexPath.row==1) {
        UILabel *lab=[[UILabel alloc]init];
        [cell addSubview:lab];
        lab.text=@"请输入密码";
        lab.font=[UIFont systemFontOfSize:12];
        lab.textColor=[UIColor blackColor];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(17);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(95, 21));
        }];
        
        UITextField*text1=[[UITextField alloc]init];
        //        text1.placeholder=@"输入密码";
        [cell addSubview:text1];
        
        [text1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(109);
            make.size.mas_equalTo(CGSizeMake(100, 32));
            
        }];
    }else if (indexPath.row==2){
        UILabel *lab=[[UILabel alloc]init];
        [cell addSubview:lab];
        lab.text=@"确认密码";
        lab.font=[UIFont systemFontOfSize:12];
        lab.textColor=[UIColor blackColor];
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(17);
            make.left.mas_equalTo(15);
            make.size.mas_equalTo(CGSizeMake(95, 21));
        }];
        
        UITextField*text1=[[UITextField alloc]init];
        //        text1.placeholder=@"输入密码";
        [cell addSubview:text1];
        
        [text1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(10);
            make.left.mas_equalTo(109);
            make.size.mas_equalTo(CGSizeMake(100, 32));
            
        }];
    }
    
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
