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
#import "EaseSyetemListCell.h"
#import "EaseUserMeagessListCell.h"
static NSString *const kEaseSyetemListCell = @"EaseSyetemListCell";
static NSString *const kEaseUserMeagessListCell = @"EaseUserMeagessListCell";
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
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height - kNavBarHeight_StateBarH) style:UITableViewStylePlain];
        _tab.backgroundColor = kACColorWhite1_R242_G242_B242_A1;
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tab.showsVerticalScrollIndicator = NO;
        _tab.tableFooterView = [[UIView alloc]init];
        [_tab registerClass:[EaseSyetemListCell class] forCellReuseIdentifier:kEaseSyetemListCell];
        [_tab registerClass:[EaseUserMeagessListCell class] forCellReuseIdentifier:kEaseUserMeagessListCell];
    }
    return _tab;
}
-(void)viewWillAppear:(BOOL)animated
{
    _list = [EaseMessageModel bg_findAll:@"EaseMessageModel"];
    [_tab reloadData];
    [self wr_setNavBarTitleColor:kACColorBlackTypeface];
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:kACColorWhite];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self wr_setNavBarTitleColor:kACColorWhite];
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:kACColorBlue_Theme];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self enableLeftBackButton];
    if (_index==0) {
        self.title=@"易转官方平台";
    }
    else
        self.title=@"求购推送消息";
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
        }else
            return _list.count;
    }else{
    if (!_products) {
        return 1;
    }else
        return _products.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_index==0) {
        ETProductModel* model = [_list objectAtIndex:indexPath.row];
        EaseSyetemListCell *cell = [tableView dequeueReusableCellWithIdentifier:kEaseSyetemListCell];
        [cell makeCellWithETProductModel:model WithIndexPath:indexPath];
        return cell;
    }else {
        ETProductModel* model = [_products objectAtIndex:indexPath.row];
        EaseUserMeagessListCell *cell = [tableView dequeueReusableCellWithIdentifier:kEaseUserMeagessListCell];
        [cell makeCellWithETProductModel:model WithIndexPath:indexPath];
        return cell;
    }
}

//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    NSArray*arr=@[@"姓名",@"支付宝账号"];
////    EaseMessageModel* m=[_list objectAtIndex:indexPath.row];
//    ETProductModel* p=[_products objectAtIndex:indexPath.row];
//    cell.imageView.image=[UIImage imageNamed:@"dropdown_loading_01"];
//    if (_index==0) {
//        EaseMessageModel* m=[_list objectAtIndex:indexPath.row];
//
//        if (indexPath.row==0) {
//            cell.textLabel.text=@"欢迎来到易转!!";
//        }
//        else
//        {
//            cell.textLabel.text=m.address;
////            cell.detailTextLabel.text=p.createDate;
//        }
//    }
//
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_index==0) {
        return 100;
    }else {
        return 116;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ETProductModel* p=[_products objectAtIndex:indexPath.row];
    ETPoctoryqgViewController* qg=[[ETPoctoryqgViewController alloc] init];
    qg.releaseId=p.releaseId;
    [self.navigationController pushViewController:qg animated:YES];
    
}

-(void)PostUI {
    WEAKSELF
    [HttpTool get:[NSString stringWithFormat:@"search/messageList"] params:nil success:^(id responseObj) {
        if ([responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            return;
        }
        weakSelf.products=[NSMutableArray array];
        for (NSDictionary* prod in responseObj[@"data"][@"content"]) {
            ETProductModel *p = [ETProductModel mj_objectWithKeyValues:prod];
            [weakSelf.products addObject:p];
        }
        [weakSelf.tab reloadData];
        
    } failure:^(NSError *error) {
      
    }];
}
        
@end
