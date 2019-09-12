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
#import "ETLoginViewController.h"
#import "ETUnsubscribeViewController.h"

@interface ETPutViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)NSString *message;
@property(nonatomic,assign)int ischeck;
@end

@implementation ETPutViewController

- (void)viewWillAppear:(BOOL)animated {
    [self.tab reloadData];
    [super.navigationController setNavigationBarHidden:NO animated:TRUE];

}

- (void)viewWillDisappear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:NO animated:TRUE];
    if (self.block) {
        self.block();
    }
}
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
    self.title = @"设置";
    [self enableLeftBackWhiteButton];
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tab];
    [self btnController];
    [self PostissignUI];
}

- (void)btnController {
    UIButton * backBtn=[[UIButton alloc]init];
    backBtn.backgroundColor=[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
    [backBtn setTitle:@"退出" forState:UIControlStateNormal];
    backBtn.titleLabel.font=[UIFont systemFontOfSize:18];
    backBtn.layer.cornerRadius = 6;
    [backBtn addTarget:self action:@selector(backbtntiao) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(502-kNavigationBarHeight-kStatusBarHeight);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(48);
    }];
}

- (void)backbtntiao {
    NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
    if ([defs objectForKey:@"token"]) {
        [defs removeObjectForKey:@"token"];
        [defs synchronize];
    }
    [UserInfoModel delelteUserInfoModel];
    [((AppDelegate *)[UIApplication sharedApplication].delegate) loginViewController];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 2;
    }else if (section==1) {
        return 4;
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
        NSArray*arr=@[@"设置用户信息",@"设置密码"];
        cell.textLabel.text=arr[indexPath.row];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    }else
    {
        NSArray*arr1=@[@"清空缓存",@"联系我们",@"关于易转",@"注销账户"];
        cell.textLabel.text=arr1[indexPath.row];
         if (indexPath.row==0)
        {
            CGFloat size = [self folderSizeAtPath:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject] + [self folderSizeAtPath:NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject] + [self folderSizeAtPath:NSTemporaryDirectory()];
            
            _message = size > 1 ? [NSString stringWithFormat:@"缓存%.0fM, 删除缓存", size] : [NSString stringWithFormat:@"缓存%.0fK, 删除缓存", size * 1024.0];
            cell.detailTextLabel.text=[NSString stringWithFormat:@"%.2fM", size];
//            [_tab reloadData];
            
        }else if (indexPath.row==1)
        {
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }
        else if (indexPath.row==2)
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
            UIBarButtonItem *backItem = [UIBarButtonItem new];
            backItem.title = @"";
            self.navigationItem.backBarButtonItem = backItem;
            [self.navigationController pushViewController:etset animated:YES];
            
        }else if (indexPath.row==1) {
            ETPassWordViewController*password=[[ETPassWordViewController alloc]init];
            UIBarButtonItem *backItem = [UIBarButtonItem new];
            backItem.title = @"";
            self.navigationItem.backBarButtonItem = backItem;
            [self.navigationController pushViewController:password animated:YES];
        }
    }else if (indexPath.section==1)
    {
        if (indexPath.row==0) {
            NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
            NSString* token=[user objectForKey:@"token"];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:nil message:_message preferredStyle:(UIAlertControllerStyleAlert)];
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
                [self cleanCaches:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject];
                [self cleanCaches:NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject];
                [self cleanCaches:NSTemporaryDirectory()];
                [self.tab reloadData];
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:nil];
            [alert addAction:action];
            [alert addAction:cancel];
            [self showDetailViewController:alert sender:nil];
            
            [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            [_tab reloadData];
        }else if (indexPath.row==1) {
            ETTouchMeinViewController*ettouchVC=[[ETTouchMeinViewController alloc]init];
            UIBarButtonItem *backItem = [UIBarButtonItem new];
            backItem.title = @"";
            self.navigationItem.backBarButtonItem = backItem;
            [self.navigationController pushViewController:ettouchVC animated:YES];
        }else if (indexPath.row==2) {
            ETAboutViewController*etaboutVC = [[ETAboutViewController alloc]init];
            UIBarButtonItem *backItem = [UIBarButtonItem new];
            backItem.title = @"";
            self.navigationItem.backBarButtonItem = backItem;
            [self.navigationController pushViewController:etaboutVC animated:YES];
        }else if (indexPath.row==3) {
           
            
            
            UserInfoModel* info=[UserInfoModel loadUserInfoModel];
//            if (info.) {
//                
//            }
            if (_ischeck==4) {
                UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"请联系企业法人操作" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"关闭" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    NSLog(@"点击了关闭");
                }];
                //3.添加动作
                [alertSheet addAction:action1];
                [alertSheet addAction:cancel];
                
                //4.显示sheet
                [self presentViewController:alertSheet animated:YES completion:nil];
            }else if (_ischeck==5) {                
                ETUnsubscribeViewController *unsu =[[ETUnsubscribeViewController alloc]init];
                [self.navigationController pushViewController:unsu animated:YES];
            }
            else{
            UIAlertController *alertSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"确认清除账户所有信息并注销" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
               
                NSUserDefaults *defs = [NSUserDefaults standardUserDefaults];
                NSDictionary* defaults = [defs dictionaryRepresentation];
                for (id key in defaults) {
                    if (![key isEqualToString:@"token"]) {
                        [defs removeObjectForKey:key];
                        [defs synchronize];
                    } else {
                        NSLog(@"%@",[defs objectForKey:key]);
                    }
                }
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
- (void)PostissignUI {
    UserInfoModel* info=[UserInfoModel loadUserInfoModel];
    
    NSDictionary *params = @{
                             
                             };
    NSData *data = [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    [HttpTool get:[NSString stringWithFormat:@"user/info"] params:params success:^(NSDictionary *response) {
        
        int b=[response[@"data"][@"userInfo"][@"isChecked"] intValue];
        if (b==5||b==4) {
        }
        if (b==1) {

        }
        _ischeck=b;
        NSLog(@"0");

        
    } failure:^(NSError *error) {
        NSLog(@"失败");
    }];
    
}
@end
