//
//  MCPageViewSub3ViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/12/12.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCPageViewSub3ViewController.h"
#import "ETAdimiTableViewCell.h"
#import "member.h"
@interface MCPageViewSub3ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIButton *ordersBtn;
@property (nonatomic,strong)UIButton *ordersBtn1;
@property (nonatomic,strong)UIButton *ordersBtn2;
@property (nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSMutableArray* members;
@end

@implementation MCPageViewSub3ViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 30, Screen_Width, Screen_Height) style:UITableViewStylePlain];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.rowHeight=150;
        _tab.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        [_tab registerNib:[UINib nibWithNibName:@"ETAdimiTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    return _tab;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _members.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ETAdimiTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    return cell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    UIView * screeView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 30)];
    screeView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:screeView];
    
    UILabel *screenLab =[[UILabel alloc]initWithFrame:CGRectMake(30,0 , 40, 20)];
    screenLab.text=@"筛选";
    screenLab.textColor=[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
    screenLab.font=[UIFont systemFontOfSize:13];
    [screeView addSubview:screenLab];
    
    _ordersBtn=[[UIButton alloc]initWithFrame:CGRectMake(75, 2, 15, 15)];
    [_ordersBtn setImage:[UIImage imageNamed:@"注册_未选中"] forState:UIControlStateNormal];
    [_ordersBtn setImage:[UIImage imageNamed:@"订单管理_分组"] forState:UIControlStateSelected];
    _ordersBtn.selected=YES;
    _ordersBtn.tag=1;
    [_ordersBtn addTarget:self action:@selector(shaixuan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_ordersBtn];
    
    
    UILabel *orderLab =[[UILabel alloc]initWithFrame:CGRectMake(95,0 , 60, 20)];
    orderLab.text=@"全部订单";
    orderLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    orderLab.font=[UIFont systemFontOfSize:13];
    [screeView addSubview:orderLab];
    
    _ordersBtn1=[[UIButton alloc]initWithFrame:CGRectMake(170, 2, 15, 15)];
    [_ordersBtn1 setImage:[UIImage imageNamed:@"注册_未选中"] forState:UIControlStateNormal];
    [_ordersBtn1 setImage:[UIImage imageNamed:@"订单管理_分组"] forState:UIControlStateSelected];
     _ordersBtn1.tag=2;
    [_ordersBtn1 addTarget:self action:@selector(shaixuan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_ordersBtn1];
    
    
    UILabel *orderLab1 =[[UILabel alloc]initWithFrame:CGRectMake(190,0 , 50, 20)];
    orderLab1.text=@"已完成";
    orderLab1.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    orderLab1.font=[UIFont systemFontOfSize:13];
    [screeView addSubview:orderLab1];
    
    _ordersBtn2=[[UIButton alloc]initWithFrame:CGRectMake(250, 2, 15, 15)];
    [_ordersBtn2 setImage:[UIImage imageNamed:@"注册_未选中"] forState:UIControlStateNormal];
    [_ordersBtn2 setImage:[UIImage imageNamed:@"订单管理_分组"] forState:UIControlStateSelected];
     _ordersBtn2.tag=3;
    [_ordersBtn2 addTarget:self action:@selector(shaixuan:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_ordersBtn2];
    
    
    UILabel *orderLab2 =[[UILabel alloc]initWithFrame:CGRectMake(270,0 , 50, 20)];
    orderLab2.text=@"交易中";
    orderLab2.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    orderLab2.font=[UIFont systemFontOfSize:13];
    [screeView addSubview:orderLab2];
    [self.view addSubview:self.tab];
    [self PostCorpUI1];

}

- (void)shaixuan:(UIButton*)sender {
    if (sender.tag==1) {
        _ordersBtn.selected=YES;
        _ordersBtn1.selected=NO;
        _ordersBtn2.selected=NO;
      
    }else if (sender.tag==2) {
        _ordersBtn.selected=NO;
        _ordersBtn1.selected=YES;
        _ordersBtn2.selected=NO;
       
    }else if (sender.tag==3) {
        _ordersBtn.selected=NO;
        _ordersBtn1.selected=NO;
        _ordersBtn2.selected=YES;
    }
}
#pragma mark - 订单列表
- (void)PostCorpUI1 {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    UserInfoModel* info=[UserInfoModel loadUserInfoModel];
    NSDictionary *params = @{
                             @"tradStatus" : @(1)
                             };
    [HttpTool get:[NSString stringWithFormat:@"release/getFindAllReleaseList"] params:params success:^(id responseObj) {
        _members=[NSMutableArray new];
        //        NSDictionary* a=responseObj[@"data"];
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
        //        _comLab.text=responseObj[@"data"][@"companyName"];
        member* m=[member mj_objectWithKeyValues:responseObj[@"data"]];
        for (NSDictionary* prod in responseObj[@"data"]) {
            member* m=[member mj_objectWithKeyValues:prod];
            [_members addObject:m];
            
        }
        [_tab reloadData];
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

@end
