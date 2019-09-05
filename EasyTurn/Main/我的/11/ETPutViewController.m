//
//  ETPutViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/20.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import "ETPutViewController.h"
#import "ETSetUserViewController.h"
#import "ETPassWordViewController.h"
#import "ETPhoneNumberViewController.h"
#import "ETTouchMeinViewController.h"
#import "ETAboutViewController.h"
@interface ETPutViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSArray *arr;

@end

@implementation ETPutViewController

-(UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStyleGrouped];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0,0,0,0.01)];
        _tab.sectionFooterHeight =0;
    }
    return _tab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"VIP会员";
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont systemFontOfSize:18]};
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
    [self.view addSubview:self.tab];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }else if (section==1) {
        return 5;
    }
    return YES;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    if (indexPath.section==0) {
        NSArray*arr=@[@"设置用户信息",@"设置密码",@"修改手机号码"];
        cell.textLabel.text=arr[indexPath.row];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
        NSArray*arr1=@[@"推送开关",@"清空缓存",@"联系我们",@"关于易转",@"注销账户"];
        cell.textLabel.text=arr1[indexPath.row];
        if (indexPath.row==0)
        {
            UISwitch*swit=[[UISwitch alloc]init];
            [cell addSubview:swit];
            [swit mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(8);
                make.right.mas_equalTo(-15);
                make.size.mas_equalTo(CGSizeMake(49, 30));
                
            }];
        }else if (indexPath.row==1)
        {
            
            cell.detailTextLabel.text=@"2.5kb";
        }else if (indexPath.row==2)
        {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row==3)
        {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }else
        {
            
        }
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tab deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 2
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    // 3点击没有颜色改变
    cell.selected = NO;
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            ETSetUserViewController*etset=[[ETSetUserViewController alloc]init];
            [self.navigationController pushViewController:etset animated:YES];
            
        }else if (indexPath.row==1) {
            ETPassWordViewController*password=[[ETPassWordViewController alloc]init];
            [self.navigationController pushViewController:password animated:YES];
        }else if (indexPath.row==2) {
            ETPhoneNumberViewController*phonenumber=[[ETPhoneNumberViewController alloc]init];
            [self.navigationController pushViewController:phonenumber animated:YES];
        }
    }else if (indexPath.section==1)
    {
        if (indexPath.row==0) {
            
            
        }else if (indexPath.row==1) {
            CGFloat size = [self folderSizeAtPath:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject] + [self folderSizeAtPath:NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject] + [self folderSizeAtPath:NSTemporaryDirectory()];
            
            NSString *message = size > 1 ? [NSString stringWithFormat:@"缓存%.0fM, 删除缓存", size] : [NSString stringWithFormat:@"缓存%.0fK, 删除缓存", size * 1024.0];
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:message preferredStyle:(UIAlertControllerStyleAlert)];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                [self cleanCaches:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject];
                [self cleanCaches:NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject];
                [self cleanCaches:NSTemporaryDirectory()];
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
            [alert addAction:action];
            [alert addAction:cancel];
            [self showDetailViewController:alert sender:nil];
        }else if (indexPath.row==2) {
            ETTouchMeinViewController*ettouchVC=[[ETTouchMeinViewController alloc]init];
            [self.navigationController pushViewController:ettouchVC animated:YES];
        }else if (indexPath.row==3) {
            ETAboutViewController*etaboutVC = [[ETAboutViewController alloc]init];
            [self.navigationController pushViewController:etaboutVC animated:YES];
        }else if (indexPath.row==4) {
            UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认清除账户所有信息并注销" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了项目1");
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                NSLog(@"点击了关闭");
            }];
            //3.添加动作
            [alertSheet addAction:action1];
            [alertSheet addAction:cancel];
            
            //4.显示sheet
            [self presentViewController:alertSheet animated:YES completion:nil];
        }
    }
}
// 计算目录大小
- (CGFloat)folderSizeAtPath:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *manager = [NSFileManager defaultManager];
    CGFloat size = 0;
    if ([manager fileExistsAtPath:path]) {
        // 获取该目录下的文件，计算其大小
        NSArray *childrenFile = [manager subpathsAtPath:path];
        for (NSString *fileName in childrenFile) {
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            size += [manager attributesOfItemAtPath:absolutePath error:nil].fileSize;
        }
        // 将大小转化为M
        return size / 1024.0 / 1024.0;
    }
    return 0;
}
// 根据路径删除文件
- (void)cleanCaches:(NSString *)path{
    // 利用NSFileManager实现对文件的管理
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        // 获取该路径下面的文件名
        NSArray *childrenFiles = [fileManager subpathsAtPath:path];
        for (NSString *fileName in childrenFiles) {
            // 拼接路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            // 将文件删除
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
}
@end
