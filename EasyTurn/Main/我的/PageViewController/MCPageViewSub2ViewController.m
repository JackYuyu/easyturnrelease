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
    member* m =[_members objectAtIndex:indexPath.row];
    cell.nameLab.text=m.uid;
    [cell.userImg sd_setImageWithURL:[NSURL URLWithString:m.portrait]];
    return cell;
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
