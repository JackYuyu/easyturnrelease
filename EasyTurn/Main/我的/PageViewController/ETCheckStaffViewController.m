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
#import "CustomTableViewCell.h"
#import "NSObject+Category.h"
static NSString * const CustomTableViewCellID = @"cell";

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
    _navigationView.backgroundColor = kACColorBlue_Theme;
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
    
    UILabel *headtitle=[[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/2-36, 30, 72, 25)];
    headtitle.textColor=kACColorWhite;
    headtitle.text=@"员工申请";
    [_navigationView addSubview:headtitle];
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
        [_tab registerClass:[CustomTableViewCell class] forCellReuseIdentifier:CustomTableViewCellID];
        [self.view addSubview:self.tab];
    }
    return _tab;
}

#pragma mark - UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [cell reloadFirstSectionIndexPath:indexPath];
    }else{
        [cell reloadSecondSectionIndexPath:indexPath];
    }
    member* m =[_products objectAtIndex:indexPath.row];
    [cell.bankImage sd_setImageWithURL:[NSURL URLWithString:m.image]];
    cell.label.text=m.realName;
    cell.labelUid.text=m.userId;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 103;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    //    UILabel * headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, K_Screen_Width, 0.01)];
    //    headerLabel.backgroundColor = [UIColor lightGrayColor];
    //    headerLabel.text = @"区头";
    UIView* view=[[UIView alloc] initWithFrame:CGRectZero];
    return view;
}

#pragma mark - 设置删除代理方法
/**使用系统默认的删除按钮
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete){
 
 }
 }
 //自定义系统默认的删除按钮文字
 - (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
 return @"自定义按钮";
 }
 */

//自定义多个左滑菜单选项
- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *deleteAction;
    deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"拒绝" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        [tableView setEditing:NO animated:YES];//退出编辑模式，隐藏左滑菜单
        member* m =[_products objectAtIndex:indexPath.row];
        _uid=m.userId;
        [self PostRefuseInfoUI];
    }];
    if (indexPath.row == 0) {//在不同的cell上添加不同的按钮
        UITableViewRowAction *shareAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"同意" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            [tableView setEditing:NO animated:YES];//退出编辑模式，隐藏左滑菜单
            member* m =[_products objectAtIndex:indexPath.row];
            _uid=m.userId;
            [self PostAgreeInfoUI];
        }];
        shareAction.backgroundColor = [UIColor blueColor];
        return @[deleteAction,shareAction];
    }
    return @[deleteAction];
}
/**自定义设置iOS11系统下的左滑删除按钮大小*/
//开始编辑左滑删除
- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section = indexPath.section;
    if (@available(iOS 11.0, *)) {
        for (UIView * subView in self.tab.subviews) {
            if ([subView isKindOfClass:NSClassFromString(@"UISwipeActionPullView")]) {
                subView.backgroundColor = [UIColor clearColor];//如果自定义只有一个按钮就要去掉按钮默认红色背景
                //设置按钮frame
                for (UIView * sonView in subView.subviews) {
                    if ([sonView isKindOfClass:NSClassFromString(@"UISwipeActionStandardButton")]) {
                        CGRect cRect = sonView.frame;
                        cRect.origin.y = sonView.frame.origin.y + 10;
                        cRect.size.height = sonView.frame.size.height - 20;
                        sonView.frame = cRect;
                    }
                }
                //自定义按钮的文字大小
                //                if (subView.subviews.count == 1 && section == 0) {//表示有一个按钮
                //                    UIButton * deleteButton = subView.subviews[0];
                //                    deleteButton.titleLabel.font = [UIFont systemFontOfSize:20];
                //                }
                //                //自定义按钮的图片
                //                if (subView.subviews.count == 1 && section == 1) {//表示有一个按钮
                //                    UIButton * deleteButton = subView.subviews[0];
                //                    [deleteButton setImage:[UIImage imageNamed:@"login_btn_message"] forState:UIControlStateNormal];;
                //                }
                //自定义按钮的文字图片
                if (subView.subviews.count >= 2 && section == 0) {//表示有两个按钮
                    UIButton * deleteButton = subView.subviews[1];
                    UIButton * shareButton = subView.subviews[0];
                    [self setUpDeleteButton:deleteButton];
                    [self setUpShareButton:shareButton];
                }
            }
        }
    }
}

//结束编辑左滑删除
- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

//判断是否显示左滑删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return _products.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
//    ETunsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
//    member* m =[_products objectAtIndex:indexPath.row];
//    cell.nameLab.text=m.realName;
//    [cell.userImg sd_setImageWithURL:[NSURL URLWithString:m.image]];
////    cell.nameLab.text=_prout[indexPath.row];
//    return cell;
//}
//
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
////定义编辑样式
//- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewCellEditingStyleDelete;
//}
////进入编辑模式，按下出现的编辑按钮后,进行删除操作
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
////        [_prout removeObjectAtIndex:indexPath.row];
////        // Delete the row from the data source.
////        [_tab deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        member* m=[_products objectAtIndex:indexPath.row];
//        _uid=m.userId;
//        [self PostInfoUI1];
//    }
//}
//
//
////修改编辑按钮文字
//- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return @"拒绝";
//}

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

-(void)PostRefuseInfoUI
{
    NSDictionary *params = @{
                             @"id" :_uid
                             };
    
    [HttpTool put:[NSString stringWithFormat:@"user/checkedStaff"] params:params success:^(id responseObj) {
        
        [_tab reloadData];
        NSLog(@"%@",responseObj);
        //        _products=[NSMutableArray new];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)PostAgreeInfoUI
{
    NSDictionary *params = @{
                             @"id" :_uid
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"user/checkedStaff"] params:params success:^(id responseObj) {
        
        [_tab reloadData];
        NSLog(@"%@",responseObj);
        [MBProgressHUD showMBProgressHud:self withText:@"审核成功" withTime:1.0];
        //        _products=[NSMutableArray new];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
