//
//  ETSetUserViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/20.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import "ETSetUserViewController.h"
#import "ActionView.h"
#import "ETNametitleViewController.h"
#import "UserInfoModel.h"
@interface ETSetUserViewController ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate>
{
    ActionView *_actionView;
//    UIImage *_headImage;

}
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)NSArray *arr;
@property(nonatomic,strong)    UIImage *headImage;
@property(nonatomic,strong)    NSString *nameStr;

@end

@implementation ETSetUserViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
}
-(UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.tableFooterView = [[UIView alloc]init];
        _tab.rowHeight=55.5;
    }
    return _tab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(baocunYonghu)];
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor=[UIColor whiteColor];
    self.title=@"设置用户信息";
    self.navigationController.navigationBar.titleTextAttributes=
    @{NSForegroundColorAttributeName:[UIColor whiteColor],
      NSFontAttributeName:[UIFont systemFontOfSize:18]};
    self.navigationController.navigationBar.barTintColor=[UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
    [self.view addSubview:self.tab];
}
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 2;
//}
-(void)baocunYonghu {
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 2;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    NSArray*arr=@[@"头像",@"昵称"];
    cell.textLabel.text=arr[indexPath.row];
    if (indexPath.row==0)
    {
        UIImageView*topImg=[[UIImageView alloc]init];
        topImg.image=[UIImage imageNamed:@"我的_Bitmap"];
        UserInfoModel* info=[UserInfoModel loadUserInfoModel];
        if (info.portrait) {
            [topImg sd_setImageWithURL:[NSURL URLWithString:info.portrait]];
            topImg.layer.masksToBounds = YES;
            topImg.layer.cornerRadius = 25;
        }
        if (_headImage) {
            topImg.image=_headImage;
            topImg.layer.masksToBounds = YES;
            topImg.layer.cornerRadius = 25;
            
            [[NSUserDefaults standardUserDefaults] setObject:UIImagePNGRepresentation(_headImage) forKey:@"port"];
        }
        [cell addSubview:topImg];
        [topImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(3);
            make.right.mas_equalTo(-29);
            make.size.mas_equalTo(CGSizeMake(50, 50));
        }];
        
    }
    if (indexPath.row==1) {

    NSArray *arr1=@[@"",@"易转"];
    cell.detailTextLabel.text=arr1[indexPath.row];
    UserInfoModel* info=[UserInfoModel loadUserInfoModel];
    cell.detailTextLabel.text=info.name;
        if (_nameStr) {
            cell.detailTextLabel.text=_nameStr;

        }
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tab deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 2
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    // 3点击没有颜色改变
    cell.selected = NO;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    UIView *coverView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, window.width, window.height)];
    coverView.backgroundColor = [UIColor blackColor];
    coverView.alpha = 0;
    [window addSubview:coverView];
    if (indexPath.row==0) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(coverClick:)];
        [coverView addGestureRecognizer:tap];
        
        ActionView *actionView = [[NSBundle mainBundle] loadNibNamed:@"ActionView" owner:nil options:nil].lastObject;
        _actionView = actionView;
        actionView.block = ^(UIButton *sender) {
            [self coverClick:tap];
            if (sender.tag == 1) {
                [self cameraClick];
            }else if (sender.tag == 2) {
                [self albumClick];
            }
        };
        actionView.frame = CGRectMake(0, window.height, window.width, 153);
        [window addSubview:actionView];
        
        [UIView animateWithDuration:0.2 animations:^{
            actionView.y = window.height - 153;
            coverView.alpha = 0.2;
        }];
    }else if (indexPath.row==1) {
        ETNametitleViewController *nametitle=[ETNametitleViewController new];
        nametitle.block = ^(NSString * _Nonnull name) {
            _nameStr=name;
            [_tab reloadData];
        };
        UIBarButtonItem *backItem = [UIBarButtonItem new];
        backItem.title = @"返回";
        self.navigationItem.backBarButtonItem = backItem;
        [self.navigationController pushViewController:nametitle animated:YES];
    }
}
- (void)coverClick:(UITapGestureRecognizer *)tap {
    [UIView animateWithDuration:0.2 animations:^{
        _actionView.y = [UIApplication sharedApplication].keyWindow.height;
        tap.view.alpha = 0;
    }completion:^(BOOL finished) {
        [tap.view removeFromSuperview];
        [_actionView removeFromSuperview];
    }];
}
- (void)cameraClick {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController * picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = YES;  //是否可编辑
        //摄像头
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您没有摄像头" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

- (void)albumClick {
    UIImagePickerController * picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;//是否可以编辑
    //打开相册选择照片
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark 拍摄、相册完成后要执行的方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //得到图片
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    //    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    //    _headImage = [UIImage imageWithData:imageData];
    _headImage = image;
    
//
//    [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"xh/head" forKey:@"tmpPath"];
    [ud synchronize];
    __weak typeof(self) weakself = self;
    [OSSImageUploader asyncUploadImage:_headImage complete:^(NSArray<NSString *> *names, UploadImageState state) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@",[NSString stringWithFormat:@"/%@", names.lastObject]);
            NSLog(@"");
            [self PostUI:[NSString stringWithFormat:@"/%@", names.lastObject]];
//            [weakself postEdit:@{@"headurl" : [NSString stringWithFormat:@"/%@", names.lastObject]}];
        });
    }];
    
//    [_tab reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [_tab reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - 用户信息
- (void)PostHeadUI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    if (![user objectForKey:@"uid"]) {
        return;
    }
    NSDictionary *params = @{
                             @"uid" : [user objectForKey:@"uid"]
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"user/info"] params:params success:^(id responseObj) {
        //        _products=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        UserInfoModel* info=[UserInfoModel mj_objectWithKeyValues:responseObj[@"data"][@"userInfo"]];
        [UserInfoModel saveUserInfoModel:info];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark 点击Cancel按钮后执行方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 上传头像图片地址
- (void)PostUI:(NSString*)head {
    NSDictionary *params = @{
                             @"headImageUrl" : [NSString stringWithFormat:@"%@%@",alioss,head]
                             };
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];

    [HttpTool put:[NSString stringWithFormat:@"user/updateUserHeadImage"] params:params success:^(NSDictionary *response) {
//        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        [self PostHeadUI];
    } failure:^(NSError *error) {
        
    }];
}
@end
