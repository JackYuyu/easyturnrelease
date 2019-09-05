//
//  ETSaleDetailVC.m
//  EasyTurn
//
//  Created by 程立 on 2019/8/28.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETSaleDetailVC.h"
#import "ETSaleDetailCell.h"
#import "ActionTopView.h"
#import "ActionBottomView.h"
@interface ETSaleDetailVC ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) UIButton *leftButton;
@end

@implementation ETSaleDetailVC
- (void)viewWillAppear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:YES animated:TRUE];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:NO animated:TRUE];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setUI];
    _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width/2, TopHeight)];
    _navigationView.backgroundColor = kACColorClear;
    [self.view addSubview:_navigationView];
    _leftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _leftButton.frame = CGRectMake(15, StatusBarHeight+15, 30, 30);
    //    [_leftButton setBackgroundColor:[UIColor blueColor]];
    [_leftButton setImage:[UIImage imageNamed:@"商品_分组 7"] forState:(UIControlStateNormal)];
    [_leftButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_navigationView addSubview:_leftButton];
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setUI
{
    UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-40) style:UITableViewStyleGrouped];
    tableView.delegate=self;
    tableView.dataSource=self;
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 382)];
    headerView.backgroundColor = [UIColor whiteColor];
    
    UIImageView* com=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 202)];
    [com setImage:[UIImage imageNamed:@"sale_分组 2"]];
    [headerView addSubview:com];
    [com mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(headerView).offset(0);
        //        make.size.mas_equalTo(340,232);
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(-35);
        make.height.mas_equalTo(232);
    }];
    
    ActionTopView *actionTopView = [[NSBundle mainBundle] loadNibNamed:@"ActionTopView" owner:nil options:nil].lastObject;

    [headerView addSubview:actionTopView];
    actionTopView.layer.cornerRadius=5;
    actionTopView.layer.masksToBounds=YES;
    [actionTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(headerView).offset(0);
//        make.size.mas_equalTo(340,232);
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(-35);
        make.height.mas_equalTo(232);
    }];
    
    tableView.tableHeaderView=headerView;
    [self.view addSubview:tableView];
    
    ActionBottomView *actionBottomView = [[NSBundle mainBundle] loadNibNamed:@"ActionBottomView" owner:nil options:nil].lastObject;
//    actionBottomView.frame=CGRectMake(0, Screen_Height-40, Screen_Width, 40);
    [self.view addSubview:actionBottomView];
//    actionTopView.layer.cornerRadius=5;
//    actionTopView.layer.masksToBounds=YES;
    [actionBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.view).offset(0);
//        //        make.size.mas_equalTo(340,232);
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(0);
        make.height.mas_equalTo(40);
    }];
}

//设置表格视图有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }else{
        return 1;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
//设置每行的UITableViewCell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
//    if (cell==nil) {
    UITableViewCell * cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
//    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%d分区",indexPath.section];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"第%d行",indexPath.row];
    cell.textLabel.text=@"联系人姓名";
    cell.detailTextLabel.text=@"赵先生";
    [cell.textLabel setFont:[UIFont systemFontOfSize:12]];
    [cell.detailTextLabel setFont:[UIFont systemFontOfSize:15]];

    cell.imageView.image= [UIImage imageNamed:@"image"];
//    cell.backgroundColor = [UIColor purpleColor];
    //    cell.showsReorderControl=YES;
    //    cell.shouldIndentWhileEditing=YES;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if (indexPath.section==0) {
        ETSaleDetailCell* cell=[[NSBundle mainBundle]loadNibNamed:@"ETSaleDetailCell" owner:self options:nil].firstObject;;
        [cell.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.mas_equalTo(headerView).offset(0);
            //        make.size.mas_equalTo(340,232);
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(430);
        }];
        return cell;
    }
    
    return cell;
}

//设置行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 430;
    }else{
        return 64;
    }
}
//设置分区尾视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
//设置分区头视图高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
//设置分区的尾视图
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    view.backgroundColor = [UIColor lightGrayColor];
    return view;
}
//设置分区的头视图
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    view.backgroundColor = RGBCOLOR(254, 254, 254);
    CGRect frameRect = CGRectMake(0, 0, 100, 40);
    
    UILabel *label = [[UILabel alloc] initWithFrame:frameRect];
    
    label.text=@"出售基本信息";
    [label setFont:[UIFont systemFontOfSize:12]];
    [view addSubview:label];
    return view;
}
//选中cell时调用的方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
