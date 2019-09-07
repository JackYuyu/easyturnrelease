//
//  EaseSyetemController.m
//  AFNetworking
//
//  Created by 程立 on 2019/8/17.
//

#import "EaseSyetemController.h"
#import "EaseMessageModel.h"
#import "ETProductModel.h"
#import "ETPoctoryqgViewController.h"
@interface EaseSyetemController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tab;
@property (nonatomic,strong) NSArray *list;
@property (nonatomic,strong) UIView *navigationView;
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) NSMutableArray *products;

@end

@implementation EaseSyetemController
- (UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, TopHeight, [[UIScreen mainScreen]bounds].size.width, Screen_Height) style:UITableViewStylePlain];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.bounces=NO;
        _tab.rowHeight=60;
        _tab.showsVerticalScrollIndicator = NO;
        _tab.tableFooterView = [[UIView alloc]init];
    }
    return _tab;
}
-(void)viewWillAppear:(BOOL)animated
{
    _list=[EaseMessageModel bg_findAll:@"EaseMessageModel"];
    [super.navigationController setNavigationBarHidden:NO animated:TRUE];
    [_tab reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:NO animated:TRUE];    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_index==0) {
        self.title=@"易转平台官方";
    }
    else
        self.title=@"平台求购推送";
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.view addSubview:self.tab];
    [self PostUI];

}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_index==0) {
        if (!_list) {
            return 1;
        }
        else
            return _list.count;
    }
    else{
    if (!_products) {
        return 1;
    }
    else
        return _products.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray*arr=@[@"姓名",@"支付宝账号"];
    EaseMessageModel* m=[_list objectAtIndex:indexPath.row];
    ETProductModel* p=[_products objectAtIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed:@"dropdown_loading_01"];
    if (_index==0) {
        if (indexPath.row==0) {
            cell.textLabel.text=@"欢迎来到易转!!";
        }
        else
        {
            cell.textLabel.text=m.address;
//            cell.detailTextLabel.text=p.createDate;
        }
    }
    else{
//        if (indexPath.row==0) {
//            cell.textLabel.text=@"很高兴为你服务!!";
//        }
//        else
        {
            cell.textLabel.text=p.title;
            NSString* time=[p.createDate stringByReplacingOccurrencesOfString:@".000+0000" withString:@""];
            time=[time stringByReplacingOccurrencesOfString:@"T" withString:@" "];

            cell.detailTextLabel.text=time;
        }
    }

//    cell.detailTextLabel.text=m.address;
    [cell.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(30);
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(cell.contentView);
    }];

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ETProductModel* p=[_products objectAtIndex:indexPath.row];
    ETPoctoryqgViewController* qg=[[ETPoctoryqgViewController alloc] init];
    qg.releaseId=p.releaseId;
    [self.navigationController pushViewController:qg animated:YES];
    
}
-(void)PostUI
{
    NSDictionary *params = @{
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"search/messageList"] params:params success:^(id responseObj) {
        if ([responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            return;
        }
                _products=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        for (NSDictionary* prod in responseObj[@"data"]) {
            ETProductModel* p=[ETProductModel mj_objectWithKeyValues:prod];
            [_products addObject:p];
        }
        NSLog(@"");
        [_tab reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
