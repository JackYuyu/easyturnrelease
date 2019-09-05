//
//  ETBindViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/8/9.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETBindViewController.h"
@interface ETBindViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tab;
@property (nonatomic,strong) UITextField *nameText;
@property (nonatomic,strong) UITextField *alipayText;

@property (nonatomic,strong) UIView * maskTheView;
@property (nonatomic,strong) UIView * shareView;
@property(nonatomic,strong) NSString *alipay;
@property (nonatomic,strong)UILabel *lab1;
@end

@implementation ETBindViewController

- (UIView *)maskTheView{
    if (!_maskTheView) {
        _maskTheView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _maskTheView.backgroundColor = [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:0.5];
        //添加一个点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskClickGesture)];
        [_maskTheView addGestureRecognizer:tap];//让header去检测点击手势
    }
    return _maskTheView;
}

- (void)maskClickGesture {
    [self.maskTheView removeFromSuperview];
    [self.shareView removeFromSuperview];
    
}

- (UIView *)shareView{
    if (!_shareView) {
        _shareView = [[UIView alloc]initWithFrame:CGRectMake(30, Screen_Height/2-200, Screen_Width-60,200)];
        //        _shareView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        _shareView.layer.cornerRadius=20;
        _shareView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
    }
    return _shareView;
}
//添加提示框
- (void)shareViewController {
    UIImageView *returnImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, 23, 50, 50)];
    returnImage.image=[UIImage imageNamed:@"提现_支付宝"];
    returnImage.userInteractionEnabled = YES;
    [_shareView addSubview:returnImage];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(80, 25, Screen_Width, 45)];
    lab.text=@"支付宝提现";
    lab.textColor=[UIColor blackColor];
    lab.font =[UIFont systemFontOfSize:25];
    [_shareView addSubview:lab];
    
    _lab1=[[UILabel alloc]initWithFrame:CGRectMake(20, 95, Screen_Width-30, 50)];
    
    _lab1.numberOfLines=0;
    _lab1.textColor=[UIColor blackColor];
    _lab1.font =[UIFont systemFontOfSize:20];
    [_shareView addSubview:_lab1];
    
    UIButton *returnbtn =[[UIButton alloc]initWithFrame:CGRectMake(_shareView.size.width-150, 155, 50, 21)];
    [returnbtn setTitle:@"关闭" forState:UIControlStateNormal];
    returnbtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [returnbtn addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [returnbtn setTitleColor:[UIColor colorWithRed:243/255.0 green:22/255.0 blue:22/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_shareView addSubview:returnbtn];
    
    UIButton *surebtn =[[UIButton alloc]initWithFrame:CGRectMake(_shareView.size.width-100, 155, 50, 21)];
    [surebtn setTitle:@"确定" forState:UIControlStateNormal];
    surebtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [surebtn setTitleColor:[UIColor colorWithRed:243/255.0 green:22/255.0 blue:22/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_shareView addSubview:surebtn];
    
}

- (void)clickImage {
    [self.maskTheView removeFromSuperview];
    [self.shareView removeFromSuperview];
}

- (UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 120) style:UITableViewStylePlain];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.bounces=NO;
        _tab.rowHeight=60;
        _tab.showsVerticalScrollIndicator = NO;
        _tab.tableFooterView = [[UIView alloc]init];
    }
    return _tab;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"绑定账号";
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.view addSubview:self.tab];
    UIImageView *imgImg=[[UIImageView alloc]init];
    imgImg.image=[UIImage imageNamed:@"jinggao-2"];
    [self.view addSubview:imgImg];
    [imgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(150);
        make.left.mas_equalTo(15);
        make.size.mas_equalTo(CGSizeMake(13, 13));
    }];
    
    UILabel *imgLab=[[UILabel alloc]init];
    imgLab.text=@"该操作不可逆，请确认账号输入正确";
    imgLab.font=[UIFont systemFontOfSize:13];
    imgLab.textColor=[UIColor colorWithRed:243/255.0 green:22/255.0 blue:22/255.0 alpha:1.0];
    [self.view addSubview:imgLab];
    [imgLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(150);
        make.left.mas_equalTo(33);
        make.size.mas_equalTo(CGSizeMake(215, 15));
    }];
    
    UIButton *tureBtn =[[UIButton alloc]init];
    tureBtn.backgroundColor= [UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
    tureBtn.layer.cornerRadius = 10;
    [tureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [tureBtn addTarget:self action:@selector(bind) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:tureBtn];
    [tureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(230);
        make.left.mas_equalTo(44);
        make.right.mas_equalTo(-44);
        make.height.mas_equalTo(39);
    }];
    [self shareView];
    [self shareViewController];
}

-(void)bind
{
    [self.view addSubview:self.maskTheView];
    [self.view addSubview:self.shareView];
    if ( [_nameText.text isEqualToString:@""]  || _nameText.text == nil ||
        [_alipayText.text isEqualToString:@""]  || _alipayText.text == nil) {
        [MBProgressHUD showMBProgressHud:self.view withText:@"请输入正确的账号信息" withTime:1];
        return;
    }
    if (self.block) {
        self.block(_nameText.text, _alipayText.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[UITableViewCell new];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray*arr=@[@"姓名",@"支付宝账号"];
    cell.textLabel.text=arr[indexPath.row];
    if (indexPath.row==0) {
        _nameText=[[UITextField alloc]init];
        _nameText.placeholder=@"请输入您的真实姓名";
        _nameText.font=[UIFont systemFontOfSize:13];
        [cell addSubview:self.nameText];
        [_nameText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(113);
            make.size.mas_equalTo(CGSizeMake(120, 21));
        }];
    }else if (indexPath.row==1) {
        
        _alipayText=[[UITextField alloc]init];
        _alipayText.font=[UIFont systemFontOfSize:13];
        _alipayText.placeholder=@"请输入您本人的支付宝账号";
        _lab1.text=[NSString stringWithFormat:@"您确定要提现到%@账户吗？",_alipayText.text];
        [cell addSubview:self.alipayText];
        [_alipayText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(20);
            make.left.mas_equalTo(113);
            make.size.mas_equalTo(CGSizeMake(160, 21));
        }];
    }
        return cell;
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
