//
//  MCPageViewSub2ViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/9/19.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCPageViewSub2ViewController.h"
#import "ETManageTableViewCell.h"
#import "member.h"
#import "UserInfoModel.h"
#import "UserMegViewController.h"
@interface MCPageViewSub2ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tab;
@property (nonatomic,strong)NSString* comName;
@property(nonatomic,strong)NSMutableArray* members;

@end

@implementation MCPageViewSub2ViewController

-(UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.bounces=NO;
        _tab.rowHeight=120;
        _tab.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
        [_tab registerNib:[UINib nibWithNibName:@"ETManageTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    }
    return _tab;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _members.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ETManageTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    UserInfoModel* m =[_members objectAtIndex:indexPath.row];
    cell.nameLab.text=m.uid;
    cell.timeLab.text=@"注册时长: 3年";
    cell.hosnLab.text=@"历史沟通订单:322";
    cell.orderLab.text=@"历史成交订单:300";
    [cell.userImg sd_setImageWithURL:[NSURL URLWithString:m.portrait]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self PostInfoUI:indexPath.row];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.view addSubview:self.tab];
    [self PostCorpUI];
}
#pragma mark - 公司
- (void)PostCorpUI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    UserInfoModel* info=[UserInfoModel loadUserInfoModel];
    NSDictionary *params = @{
                             @"id" : @([info.uid intValue])
                             };
    [HttpTool get:[NSString stringWithFormat:@"user/getCompanyInfo"] params:params success:^(id responseObj) {
        //        _products=[NSMutableArray new];
        //        NSDictionary* a=responseObj[@"data"];
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
        _comName=responseObj[@"data"][@"companyName"];
        [self PostCorpUI1];
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - u员工列表
- (void)PostCorpUI1 {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    UserInfoModel* info=[UserInfoModel loadUserInfoModel];
    NSDictionary *params = @{
                             @"companyName" : _comName
                             };
    [HttpTool get:[NSString stringWithFormat:@"user/releaseList"] params:params success:^(id responseObj) {
                _members=[NSMutableArray new];
        //        NSDictionary* a=responseObj[@"data"];
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
//        _comLab.text=responseObj[@"data"][@"companyName"];
        member* m=[member mj_objectWithKeyValues:responseObj[@"data"]];
        for (NSDictionary* prod in responseObj[@"data"]) {
            UserInfoModel* m=[UserInfoModel mj_objectWithKeyValues:prod];
                        [_members addObject:m];

                    }
        [_tab reloadData];
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)PostInfoUI:(NSInteger)a
{
    UserInfoModel* p=[_members objectAtIndex:a];

    NSDictionary *params = @{
                             @"uid" : p.uid
                             };

    [HttpTool get:[NSString stringWithFormat:@"user/info"] params:params success:^(id responseObj) {
        if ([responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            return;
        }
        //        _products=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        UserInfoModel* info=[UserInfoModel mj_objectWithKeyValues:responseObj[@"data"][@"userInfo"]];
        NSLog(@"");

        UserMegViewController *megVC=[[UserMegViewController alloc]init];
        megVC.name=info.name;
        megVC.photoImg=info.portrait;
        [MySingleton sharedMySingleton].toUserid=info.uid;
        [self.owner.navigationController pushViewController:megVC animated:YES];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
