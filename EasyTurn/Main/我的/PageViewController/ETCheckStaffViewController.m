//
//  ETUnsubscribeViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/8/26.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETCheckStaffViewController.h"
#import "ETunsTableViewCell.h"
#import "member.h"
@interface ETCheckStaffViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tab;
@property (nonatomic,strong) NSMutableArray * prout;
@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic,strong) NSMutableArray * products;

@property (nonatomic,strong)NSString* uid;
@end

@implementation ETCheckStaffViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"员工申请";
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.view addSubview:self.tab];
    UIButton *subBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, Screen_Height-100, Screen_Width-20, 40)];
    subBtn.backgroundColor =[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
    [subBtn setTitle:@"一键注销企业全部账户" forState:UIControlStateNormal];
//    [self.view addSubview:subBtn];
    _prout=[[NSMutableArray alloc]initWithObjects:@"1",@"3", nil];
    [self PostInfoUI];
//    [self PostInfoUI1];
    
    _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, TopHeight)];
    _navigationView.backgroundColor = kACColorClear;
    [self.navigationController.view addSubview:_navigationView];
    _leftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _leftButton.frame = CGRectMake(15, StatusBarHeight, 55, 45);
    //    [_leftButton setBackgroundColor:[UIColor blueColor]];
    [_leftButton setImage:[UIImage imageNamed:@"navigation_back_hl"] forState:(UIControlStateNormal)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(7, StatusBarHeight+7, 44, 44);
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateSelected];
    _leftButton=btn;
    [_leftButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_navigationView addSubview:_leftButton];
}
-(void)backAction
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, TopHeight, Screen_Width, Screen_Height) style:UITableViewStylePlain];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.rowHeight=100;
        _tab.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        [_tab registerNib:[UINib nibWithNibName:@"ETunsTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        [self.view addSubview:self.tab];
    }
    return _tab;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    ETunsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    member* m =[_products objectAtIndex:indexPath.row];
    cell.nameLab.text=m.realName;
    [cell.userImg sd_setImageWithURL:[NSURL URLWithString:m.image]];
//    cell.nameLab.text=_prout[indexPath.row];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
//定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
//进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        [_prout removeObjectAtIndex:indexPath.row];
//        // Delete the row from the data source.
//        [_tab deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        member* m=[_products objectAtIndex:indexPath.row];
        _uid=m.userId;
        [self PostInfoUI1];
    }
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"拒绝";
}

-(void)PostInfoUI
{
    NSDictionary *params = @{
                             @"type" :@(1)
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"user/checkedStaffList"] params:params success:^(id responseObj) {
        if (![MySingleton filterNull:responseObj[@"data"]]) {
            return;
        }

        _products=[NSMutableArray new];
        for (NSDictionary* d in responseObj[@"data"]) {
            member* m=[member mj_objectWithKeyValues:d];
            [_products addObject:m];
        }
        [_tab reloadData];
        NSLog(@"%@",responseObj);
        //        _products=[NSMutableArray new];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)PostInfoUI1
{
    NSDictionary *params = @{
                             @"id" :_uid
                             };
    
    [HttpTool put:[NSString stringWithFormat:@"user/staffLogout"] params:params success:^(id responseObj) {
        
        [_tab reloadData];
        NSLog(@"%@",responseObj);
        //        _products=[NSMutableArray new];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
