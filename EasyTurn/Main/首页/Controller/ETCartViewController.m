//
//  ETPurchaseViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/8/17.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETCartViewController.h"
#import "ETPhreasTableViewCell.h"
#import "ETProductModel.h"
#import "ETBuyPushViewController.h"
#import "UserMegViewController.h"
@interface ETCartViewController () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *Tab;
@property (nonatomic,strong) UILabel *stitleLab;
@property (nonatomic, assign) CGFloat bottomHeight;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong)UILabel * fuwuBtn;
@property (nonatomic,strong)UIView *xinxView;
@property (nonatomic, strong) NSMutableArray *products;
@property(strong,nonatomic)UIButton *button;
@property(strong,nonatomic)UIButton *mbutton;
@property(strong,nonatomic)UIWindow *window;
@property (nonatomic, strong) UserInfoModel *toUser;

@end

@implementation ETCartViewController

- (UITableView *)Tab {
    if (!_Tab) {
        _Tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 10, Screen_Width, 340) style:UITableViewStylePlain];
        if (IPHONE_X) {
            _Tab = [[UITableView alloc] initWithFrame:CGRectMake(0, 10, Screen_Width, 340)];
        }
        _Tab.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0,0,0,0.01)];
        _Tab.delegate=self;
        _Tab.dataSource=self;
        _Tab.bounces=NO;
        _Tab.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _Tab.showsVerticalScrollIndicator = NO;
        [_Tab registerClass:[ETPhreasTableViewCell class] forCellReuseIdentifier:@"cell"];
        _Tab.sectionFooterHeight = 0;
        
        _Tab.sectionHeaderHeight = 0;
    }
    return _Tab;
}
-(void)viewWillAppear:(BOOL)animated
{
    [_button removeFromSuperview];
    [_mbutton removeFromSuperview];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"实时求购";
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.view addSubview:self.Tab];
    
    [self PostUI];
}

- (void) xinxi {
    _xinxView=[[UIView alloc]initWithFrame:CGRectMake(0, Screen_Height-180, Screen_Width, 90)];
    if (IPHONE_X) {
        _xinxView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height-230, Screen_Width, 90)];
    }
    _xinxView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:_xinxView];

    UIImageView *userImg=[[UIImageView alloc]initWithFrame:CGRectMake(10, 20, 50, 50)];
    userImg.image=[UIImage imageNamed:@"我的_Bitmap"];
    if (_toUser.portrait) {
        //            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:_toUser.portrait]];
        [userImg sd_setImageWithURL:[NSURL URLWithString:_toUser.portrait] placeholderImage:[UIImage imageNamed:@"11566120515_.pic_hd"]];
    }
    [_xinxView addSubview:userImg];

    UILabel *lab1=[[UILabel alloc]initWithFrame:CGRectMake(65, 20, Screen_Width, 21)];
    lab1.text=[NSString stringWithFormat:@"%@",_toUser.name];
    [_xinxView addSubview:lab1];

    UILabel *lab2=[[UILabel alloc]initWithFrame:CGRectMake(65, 50, Screen_Width, 21)];
    lab2.text=@"未进行企业认证";
    lab2.font=[UIFont systemFontOfSize:14];
    lab2.textColor=[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    [_xinxView addSubview:lab2];
    
    
    _bottomHeight=40;
    _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height-60- _bottomHeight, Screen_Width, _bottomHeight)];
    if (IPHONE_X) {
        _bottomView= [[UIView alloc] initWithFrame:CGRectMake(0, Screen_Height-110- _bottomHeight, Screen_Width, _bottomHeight)];
    }
    _bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_bottomView];
    
    UIView* add=[UIView new];
    add.frame=CGRectMake(_bottomView.mj_w/2, 0, _bottomView.mj_w/4, _bottomHeight);
    add.backgroundColor= RGBCOLOR(60, 138, 239);
    
    UIButton *addButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    addButton.frame = CGRectMake(_bottomView.mj_w/4-_bottomHeight-10, 5, _bottomHeight-10, _bottomHeight-10);
    addButton.backgroundColor = RGBCOLOR(60, 138, 239);
    //    addButton.titleLabel.font = SYSTEMFONT(16);
    //    [addButton setTitle:@"联系人:张先生" forState:(UIControlStateNormal)];
    //    [addButton setTitleColor:kACColorWhite forState:(UIControlStateNormal)];
    [addButton setBackgroundImage:[UIImage imageNamed:@"detail_分组_6"] forState:UIControlStateNormal];
    addButton.tag=0;
    [addButton addTarget:self action:@selector(addAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [add addSubview:addButton];
    
    //
    UIView* msg=[UIView new];
    msg.frame=CGRectMake(0, 0, _bottomHeight, _bottomHeight);;
    msg.backgroundColor=kACColorBackgroundGray;
    
    //
    UIButton *msgButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    msgButton.frame = CGRectMake(5, 5, _bottomHeight-10, _bottomHeight-10);
    msgButton.backgroundColor = kACColorBackgroundGray;
    [msgButton setBackgroundImage:[UIImage imageNamed:@"detail_icon_聊天"] forState:UIControlStateNormal];
    msgButton.tag=0;
    [msgButton addTarget:self action:@selector(addAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [msg addSubview:msgButton];
    
    [add addSubview:msg];
    [_bottomView addSubview:add];
    
    UIButton *addimButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    addimButton.frame = CGRectMake(_bottomView.mj_w*3/4, 0, _bottomView.mj_w/4, _bottomHeight);
    addimButton.backgroundColor = RGBCOLOR(60, 138, 239);
    addimButton.titleLabel.font = SYSTEMFONT(16);
    [addimButton setTitle:@"联系商家" forState:(UIControlStateNormal)];
    [addimButton setTitleColor:kACColorWhite forState:(UIControlStateNormal)];
    addimButton.tag=1;
    [addimButton addTarget:self action:@selector(addAction1) forControlEvents:(UIControlEventTouchUpInside)];
    [_bottomView addSubview:addimButton];
    //
//    UIButton *msgButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    msgButton.frame = CGRectMake(5, 5, _bottomHeight-10, _bottomHeight-10);
////    msgButton.backgroundColor = [UIColor whiteColor];
//    [msgButton setBackgroundImage:[UIImage imageNamed:@"detail_icon_聊天"] forState:UIControlStateNormal];
//    msgButton.tag=0;
//    [msgButton addTarget:self action:@selector(addAction:) forControlEvents:(UIControlEventTouchUpInside)];
//    [msg addSubview:msgButton];
//
//    [add addSubview:msg];
//    [_bottomView addSubview:add];
//
//    UIButton *addimButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    addimButton.frame = CGRectMake(_bottomView.mj_w*3/4, 0, _bottomView.mj_w/4, _bottomHeight);
//    addimButton.backgroundColor = RGBCOLOR(60, 138, 239);
//    addimButton.titleLabel.font = SYSTEMFONT(16);
//    [addimButton setTitle:@"联系商家" forState:(UIControlStateNormal)];
//    [addimButton setTitleColor:kACColorWhite forState:(UIControlStateNormal)];
//    addimButton.tag=1;
//    [addimButton addTarget:self action:@selector(addAction1) forControlEvents:(UIControlEventTouchUpInside)];
//    [_bottomView addSubview:addimButton];
//
//    NSArray *imagesNor = @[@"tabr_07shoucang_up"];
//    NSArray *imagesSel = @[@"tabr_07shoucang_down",@"ptgd_icon_xiaoxi",@"tabr_08gouwuche"];
//    CGFloat buttonW = Screen_Width * 0.15;
//    CGFloat buttonH = _bottomHeight;
//    CGFloat buttonY = Screen_Height - buttonH;
//
//    for (NSInteger i = 0; i < imagesNor.count; i++) {
//        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//        [button setImage:[UIImage imageNamed:imagesNor[i]] forState:UIControlStateNormal];
//        button.backgroundColor = kACColorBackgroundGray;
//        [button setImage:[UIImage imageNamed:imagesSel[i]] forState:UIControlStateSelected];
//        button.tag = i;
//        [button addTarget:self action:@selector(bottomButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        CGFloat buttonX = (buttonW * i);
//        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
//        //        [self.view addSubview:button];
        UILabel* label=[UILabel new];
        label.frame=CGRectMake(20, 0, _bottomView.mj_w/2-20, 40);;
        label.text=@"联系人:张先生";
        label.backgroundColor=kACColorBackgroundGray;
        if (_product.linkmanName) {
            label.text=[NSString stringWithFormat:@"联系人:%@",_product.linkmanName];
        }
        [_bottomView addSubview:label];
//    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goMeg)];
    [_xinxView addGestureRecognizer:tap];
}
-(void)goMeg
{
    UserMegViewController *megVC=[[UserMegViewController alloc]init];
    megVC.name=_toUser.name;
    megVC.photoImg=_toUser.portrait;
    [MySingleton sharedMySingleton].toUserid=_toUser.uid;
    [self presentViewController:megVC animated:YES completion:nil];
}
-(void)addAction1
{
    ETProductModel* p=[_products objectAtIndex:0];
    if (p.linkmanMobil) {
        NSString *openUrl = [NSString stringWithFormat:@"tel://%@", p.linkmanMobil];
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl] options:@{} completionHandler:nil];
        } else {
            // Fallback on earlier versions
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:openUrl]];
            
        }
    }
}
-(void)addAction:(id)sender
{
    [self getJimName];
}
-(void)getJimName
{
    ETProductModel* p=[_products objectAtIndex:0];
    long long uid=[p.userId longLongValue];
    NSDictionary *params = @{
                             @"userId" : @(uid)
                             };
    [HttpTool get:[NSString stringWithFormat:@"user/getJimAuroraName"] params:params success:^(id responseObj) {
        NSLog(@"");
        NSDictionary* a=responseObj[@"data"];
        EaseUserModel* model=[EaseUserModel new];
        model.nickname=[a objectForKey:@"username"];
        model.avatarURLPath=[a objectForKey:@"img"];
        model.buddy=[a objectForKey:@"auroraName"];
        model.cart=@"1";
        [model bg_saveOrUpdate];
        //touser
        _product.touser=[a objectForKey:@"auroraName"];
        [_product bg_saveOrUpdate];
        
        EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:[a objectForKey:@"auroraName"] conversationType:EMConversationTypeChat];
        chatController.cartcontroller=YES;
        chatController.releaseid=_releaseId;
        chatController.title=[a objectForKey:@"auroraName"];
        [self.navigationController pushViewController:chatController animated:YES];
        //        NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
        //        NSDictionary* a=responseObj[@"data"];
        //        [user setObject:[a objectForKey:@"auroraName"] forKey:@"huanxin"];
        //        [user synchronize];
        NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
//        NSString* b=[user objectForKey:@"uid"];
//        if ([b isEqualToString:_toUser.uid]) {
//            [self createButton];
//        }
        [self PostSaveUI];

//        [self sendMsgToBuyer];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)createButton{
    
    _window = [UIApplication sharedApplication].windows[0];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_button setTitle:@"xxx" forState:UIControlStateNormal];
    
    float f=self.view.bounds.size.width;
    _button.frame = CGRectMake(self.view.bounds.size.width -80, self.view.bounds.size.height - 100, 40, 40);
    
    _button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    
    //    [_button setBackgroundColor:DGColor];
    
    _button.layer.cornerRadius = 20;
    
    _button.layer.masksToBounds = YES;
    
    [_button addTarget:self action:@selector(resignButton) forControlEvents:UIControlEventTouchUpInside];
    
    [_button setImage:[UIImage imageNamed:@"cart_分组 2"] forState:UIControlStateNormal];
    
    [_window.rootViewController.view addSubview:_button];
    
    //放一个拖动手势，用来改变控件的位置
    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changePostion:)];
//
//    [_button addGestureRecognizer:pan];
    
    _mbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [_mbutton setTitle:@"点击可以发起交易" forState:UIControlStateNormal];
    
    _mbutton.frame = CGRectMake(self.view.bounds.size.width -80 -_button.frame.size.width-10-50, self.view.bounds.size.height - 100+5, 100, 30);
    
    _mbutton.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    
        [_mbutton setBackgroundColor:RGBCOLOR(137, 137, 137)];
    
    _mbutton.layer.cornerRadius = 15;
    
    _mbutton.layer.masksToBounds = YES;
    [_window.rootViewController.view addSubview:_mbutton];

}

- (void)resignButton {
    ETBuyPushViewController *buy =[[ETBuyPushViewController alloc]init];
    buy.product=_products[0];
    ETProductModel* p=_products[0];
    buy.releaseId=p.releaseId;
    [self.navigationController pushViewController:buy animated:YES];
    _button.hidden=YES;
    _mbutton.hidden=YES;
}
- (void)sendMsgToBuyer {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    ETProductModel* p=_products[0];
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    
    NSDictionary *params = @{
                             @"releaseId" : p.releaseId
                             };
    [HttpTool get:[NSString stringWithFormat:@"release/sendMsgToBuyer"] params:params success:^(id responseObj) {
        
        //        NSString* a=responseObj[@"data"][@"result"];
//        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[responseObj dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        //
//        NSDictionary* d=[jsonDict copy];
        NSLog(@"");
//        [MBProgressHUD showMBProgressHud:self.view withText:@"提交成功" withTime:1];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
//小黄车先调接口
- (void)PostSaveUI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    ETProductModel* p=_products[0];
    NSUserDefaults* user=[NSUserDefaults standardUserDefaults];
    
    NSDictionary *params = @{
                             @"releaseId" : p.releaseId,
                             @"forUserId" : [user objectForKey:@"uid"]
                             
                             };
    [HttpTool get:[NSString stringWithFormat:@"pay/saveForUserId"] params:params success:^(id responseObj) {
        
//        NSString* a=responseObj[@"data"][@"result"];
//        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:[responseObj dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:nil];
        //
//        NSDictionary* d=[jsonDict copy];
        NSLog(@"");
//        [MBProgressHUD showMBProgressHud:self.view withText:@"提交成功" withTime:1];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section  {
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ETPhreasTableViewCell*cell=[ETPhreasTableViewCell new];
    NSArray *arr=@[@"标题:",@"详细内容:",@"服务种类",@"发布时间",@"求购区域"];
    cell.titleLab.text=arr[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    ETProductModel* p=[_products objectAtIndex:0];
    if (indexPath.row==0) {
           cell.subtitleLab.text=@"求购丰台食品流通许可证";
        cell.subtitleLab.text=p.title;
    }else if (indexPath.row==1) {
        _stitleLab=[[UILabel alloc]initWithFrame:CGRectMake(80,20, Screen_Width-80, 42)];
        _stitleLab.font=[UIFont systemFontOfSize:15];
        _stitleLab.text=@"公司注册地址不能配合核查，许可范围含冷冻冷藏，预包装食品";
        _stitleLab.textAlignment = NSTextAlignmentLeft;
        _stitleLab.numberOfLines = 0;
        _stitleLab.textColor=[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
        _stitleLab.text=p.detail;
        [cell addSubview:_stitleLab];
        
    }else if (indexPath.row==2) {
        _fuwuBtn=[[UILabel alloc]initWithFrame:CGRectMake(80, 20, 80, 25)];
        _fuwuBtn.layer.borderWidth=1;
        _fuwuBtn.layer.borderColor=[UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0].CGColor;
        _fuwuBtn.font=[UIFont systemFontOfSize:13];
        _fuwuBtn.text=@"行政服务" ;
        if ([p.serviceId isEqualToString:@"1"]) {
            _fuwuBtn.text=@"工商服务";
        }
        else if ([p.serviceId isEqualToString:@"2"]) {
            _fuwuBtn.text=@"纳税服务";
        }
        else if ([p.serviceId isEqualToString:@"3"]) {
            _fuwuBtn.text=@"行政服务";
        }
        else if ([p.serviceId isEqualToString:@"4"]) {
            _fuwuBtn.text=@"金融服务";
        }
        else if ([p.serviceId isEqualToString:@"5"]) {
            _fuwuBtn.text=@"资质服务";
        }
        else if ([p.serviceId isEqualToString:@"6"]) {
            _fuwuBtn.text=@"疑难服务";
        }
        if (!p.serviceId) {
            _fuwuBtn.text=@"无";
            _fuwuBtn.layer.borderColor=[UIColor clearColor].CGColor;
        }
        _fuwuBtn.textColor=[UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
        _fuwuBtn.textAlignment = NSTextAlignmentCenter;
        _fuwuBtn.layer.cornerRadius = 5;
        [cell addSubview:_fuwuBtn];
      
    }else if (indexPath.row==3) {
         cell.subtitleLab.text=@"2019-06-19";
        cell.subtitleLab.text=p.releaseTime;
    }else if (indexPath.row==4) {
         cell.subtitleLab.text=@"北京";
        cell.subtitleLab.text=p.cityName;
    }
 
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==1) {
        return 100;
    }
    return 60;
}



- (void)PostUI {
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDictionary *params = @{
                             @"releaseId" : _releaseId
                             };
    [HttpTool get:[NSString stringWithFormat:@"release/releaseDetail"] params:params success:^(id responseObj) {
        if ([responseObj[@"msg"] containsString:@"次数已用尽"]) {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"提示" message:@"免费查看次数已用尽！您可以选择充值会员来开启无限查看权限！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alter.delegate=self;
            [alter show];
            return;
        }
        _products=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        for (NSDictionary* prod in responseObj[@"data"]) {
            ETProductModel* p=[ETProductModel mj_objectWithKeyValues:prod];
            //            [_products addObject:p];
            
        }
        //        NSLog(@"");
        ETProductModel* p=[ETProductModel mj_objectWithKeyValues:a];

        NSLog(@"");
        [_products addObject:p];

        [self PostInfoUI];
        [_Tab reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
-(void)PostInfoUI
{
    ETProductModel* p=[_products objectAtIndex:0];
    
    NSDictionary *params = @{
                             @"uid" : p.userId
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"user/info"] params:params success:^(id responseObj) {
        if ([responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            return;
        }
        //        _products=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        UserInfoModel* info=[UserInfoModel mj_objectWithKeyValues:responseObj[@"data"][@"userInfo"]];
        _toUser=info;
        NSLog(@"");
        [self xinxi];

//        dispatch_async(dispatch_get_main_queue(), ^{
//            //                [self showError:@"微信授权失败"];
//            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:5];
//            [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
//        });
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end
