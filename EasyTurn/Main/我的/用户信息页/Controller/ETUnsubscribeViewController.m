//
//  ETUnsubscribeViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/8/26.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETUnsubscribeViewController.h"
#import "ETunsTableViewCell.h"
#import "member.h"

@interface ETUnsubscribeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tab;
@property (nonatomic,strong) NSMutableArray * prout;
@property (nonatomic,strong)NSString* comName;
@property (nonatomic,strong) NSMutableArray * products;

@property (nonatomic,strong)NSString* uid;

@end

@implementation ETUnsubscribeViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"注销账户";
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.view addSubview:self.tab];
    UIButton *subBtn=[[UIButton alloc]initWithFrame:CGRectMake(10, Screen_Height-160, Screen_Width-20, 40)];
    subBtn.backgroundColor =[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
    [subBtn setTitle:@"一键注销企业全部账户" forState:UIControlStateNormal];
    [self.view addSubview:subBtn];
    _prout=[[NSMutableArray alloc]initWithObjects:@"1",@"3", nil];
    [self PostCorpUI];
//    [self PostInfoUI];
//    [self PostInfoUI1];
}
- (UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-100) style:UITableViewStylePlain];
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
    cell.nameLab.text=m.uid;
    [cell.userImg sd_setImageWithURL:[NSURL URLWithString:m.portrait]];
    cell.detailTextLabel.text=@"";
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
        member* m=[_products objectAtIndex:indexPath.row];
        _uid=m.uid;
        [self PostInfoUI1];
//        [_prout removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
//        [_tab deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"注销账户";
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
        _comName = responseObj[@"data"][@"companyName"];
        [self PostInfoUI];

        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)PostInfoUI
{
    NSDictionary *params = @{
                             @"companyName" : _comName
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"user/releaseList"] params:params success:^(id responseObj) {
        NSLog(@"%@",responseObj);
                _products=[NSMutableArray new];
        for (NSDictionary* d in responseObj[@"data"]) {
            member* m=[member mj_objectWithKeyValues:d];
            [_products addObject:m];
        }
        [_tab reloadData];
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
