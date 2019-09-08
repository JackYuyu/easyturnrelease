#import "UserMegViewController.h"
#import "UserSaleView.h"
#import "UserServeView.h"
#import "UserInfoModel.h"
#import "ETProductModel.h"

#define selfW self.view.frame.size.width
#define selfH self.view.frame.size.height

@interface UserMegViewController () <UINavigationControllerDelegate,UIScrollViewDelegate>
@property(nonatomic , strong)UIView *topView;
@property(nonatomic , strong)UIButton *backBtn;
@property(nonatomic , strong)UIImageView *iconBtn;
@property(nonatomic , strong)UILabel *userNameLab ,* corpLab;
@property(nonatomic , strong)UIImageView *corpImg;
@property(nonatomic , strong)UIView *topView_2;
@property(nonatomic , strong)UIView *contentView;
@property(nonatomic , strong)UIButton *contentBtn_1,*contentBtn_2;
@property(nonatomic , strong)UIScrollView *contentScroll;
@property(nonatomic , strong)NSMutableArray *products;
@property(nonatomic , strong)UILabel *comp;


@end

@implementation UserMegViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    self.navigationController.navigationBarHidden=NO;
    [self.view addSubview:self.topView];
    [self.view addSubview:self.topView_2];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.contentScroll];
//    [self PostCorpUI];
    [self PostInfoUI];
}

#pragma mark - UINavigationControllerDelegate
// 将要显示控制器
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
    
    
    
}
//中间的滚动视图
-(UIScrollView *)contentScroll{
    if (!_contentScroll) {
        _contentScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0,322, selfW, selfH - 322)];
        _contentScroll.contentSize = CGSizeMake(selfW * 2, 0);
        _contentScroll.pagingEnabled = YES;
        _contentScroll.delegate = self;
        UserSaleView *saleView = [[UserSaleView alloc]initWithFrame:CGRectMake(0, 0, _contentScroll.frame.size.width, _contentScroll.frame.size.height)];
        saleView.owner=self;
        UserServeView *serveView = [[UserServeView alloc]initWithFrame:CGRectMake(selfW, 0, _contentScroll.frame.size.width, _contentScroll.frame.size.height)];
        serveView.owner=self;
        [_contentScroll addSubview:serveView];
        [_contentScroll addSubview:saleView];
    }
    return _contentScroll;
}
//中间的View
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 280, selfW, 50)];
        _contentView.layer.borderWidth = 0.0;
        _contentView.backgroundColor=[UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        _contentBtn_1 = [[UIButton alloc]initWithFrame:CGRectMake((selfW - (selfW - 80)), 10, 50, 25)];
        [_contentBtn_1 setTitle:@"出售" forState:UIControlStateNormal];
        [_contentBtn_1 setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
        _contentBtn_1.titleLabel.font = [UIFont systemFontOfSize:15 weight:12];
        _contentBtn_1.tag = 0;
        
        _contentBtn_2 = [[UIButton alloc]initWithFrame:CGRectMake((selfW - 120), 10, 50, 25)];
        [_contentBtn_2 setTitle:@"服务" forState:UIControlStateNormal];
        [_contentBtn_2 setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
        _contentBtn_2.titleLabel.font = [UIFont systemFontOfSize:15 weight:12];
        _contentBtn_2.tag = 1;
        
        [_contentBtn_1 addTarget:self action:@selector(contentViewMethod:) forControlEvents:UIControlEventTouchUpInside];
        
        [_contentBtn_2 addTarget:self action:@selector(contentViewMethod:) forControlEvents:UIControlEventTouchUpInside];
        
        [_contentBtn_1 setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [_contentBtn_2 setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        _contentBtn_1.selected = YES;
        [_contentView addSubview:_contentBtn_1];
        [_contentView addSubview:_contentBtn_2];
    }
    return _contentView;
}
//头部中间的视图
-(UIView *)topView_2{
    if (!_topView_2) {
        _topView_2 = [[UIView alloc]initWithFrame:CGRectMake((selfW - (selfW - 30))/2, 220, selfW - 30, 50)];
        _topView_2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        _topView_2.layer.cornerRadius = 5;
        UILabel *lable_1 = [[UILabel alloc]initWithFrame:CGRectMake(_topView_2.frame.origin.x + 5, 5, 90, 25)];
        lable_1.text = @"所属公司";
        lable_1.font = [UIFont systemFontOfSize:15];
        UILabel *lable_2 = [[UILabel alloc]initWithFrame:CGRectMake(lable_1.frame.origin.x + lable_1.frame.size.width, 5, _topView_2.frame.size.width / 2 - 10, 25)];
        lable_2.text = @"易转公司";
        UserInfoModel* info=[UserInfoModel loadUserInfoModel];
        lable_2.font=[UIFont systemFontOfSize:15];
        UIButton *btn_1 = [[UIButton alloc]initWithFrame:CGRectMake(lable_2.frame.origin.x + lable_2.frame.size.width + 5, 5, _topView_2.frame.size.width - (lable_2.frame.origin.x + lable_2.frame.size.width) - 10, 30)];
        lable_2.textAlignment=UITextAlignmentCenter;
        _comp=lable_2;
        
        btn_1.layer.cornerRadius = 15;
        btn_1.clipsToBounds = YES;
        [btn_1 setTitle:@"营业执照" forState:UIControlStateNormal];
        [btn_1 setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        btn_1.titleLabel.font=[UIFont systemFontOfSize:10];
        btn_1.layer.borderWidth=1;
        btn_1.layer.borderColor=[UIColor colorWithRed:226/255.0 green:226/255.0 blue:226/255.0 alpha:1.0].CGColor;
        
        [_topView_2 addSubview:lable_1];
        [_topView_2 addSubview:lable_2];
        [_topView_2 addSubview:btn_1];
    }
    return _topView_2;
}
#pragma mark - 公司
- (void)PostCorpUI {
    ETProductModel* p=[_products objectAtIndex:0];
    long long a=[p.releaseTypeId longLongValue];
    long long b=[p.userId longLongValue];
    NSDictionary *params = @{
                             @"id" : @(b)
                             };
    [HttpTool get:[NSString stringWithFormat:@"user/getCompanyInfo"] params:params success:^(id responseObj) {
        //        _products=[NSMutableArray new];
        //        NSDictionary* a=responseObj[@"data"];
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObj options:NSJSONReadingMutableLeaves error:nil];
        _comp.text = responseObj[@"data"][@"companyName"];
        
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
//头部的视图
-(UIView *)topView{
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    if (!_topView) {
        _topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 240)];
        _topView.backgroundColor = [UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
        _topView.userInteractionEnabled = YES;
        self.userNameLab = [[UILabel alloc]initWithFrame:CGRectMake((selfW - (selfW - 30)) + 100 + 10, statusRect.size.height + 10 + 30 + 20, 100, 25)];
        self.userNameLab.textColor = [UIColor whiteColor];
        self.userNameLab.text = self.name;
        self.corpLab = [[UILabel alloc]initWithFrame:CGRectMake((selfW - (selfW - 30)) + 100 + 10, statusRect.size.height + 10 + 30 + 20 + 25 + 5, 100, 25)];
        self.corpLab.textColor = [UIColor whiteColor];
        self.corpLab.text = @"易转公司";
        self.corpImg = [[UIImageView alloc]init];
        self.corpImg.image=[UIImage imageNamed:@"my_企业认证"];;
        self.corpImg.hidden=YES;
        UserInfoModel* info=[UserInfoModel loadUserInfoModel];
        if ([info.isChecked isEqualToString:@"5"]) {
            self.corpImg.hidden=NO;
        }
        [_topView addSubview:self.backBtn];
        [_topView addSubview:self.iconBtn];
        [_topView addSubview:self.userNameLab];
        [_topView addSubview:self.corpLab];
        [_topView addSubview:self.corpImg];
        [self.corpImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.userNameLab.mas_right).offset(20);
            make.centerY.mas_equalTo(self.userNameLab);
            make.size.mas_equalTo(25,25);
        }];
    }
    return _topView;
}


///头像按钮
-(UIImageView *)iconBtn{
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    if (!_iconBtn) {
        _iconBtn = [[UIImageView alloc]initWithFrame:CGRectMake((selfW - (selfW - 60)), statusRect.size.height + 10 + 30 + 25, 50, 50)];
        _iconBtn.layer.cornerRadius = 25;
        _iconBtn.clipsToBounds = YES;
        [_iconBtn sd_setImageWithURL:[NSURL URLWithString:_photoImg]];
    }
    return _iconBtn;
}
-(UIButton *)backBtn{
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    
    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake((selfW - (selfW - 30)), statusRect.size.height + 10, 30, 30)];
        [_backBtn setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(onclickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

-(void)onclickBackBtn{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)dealloc {
    self.navigationController.delegate = nil;
}
-(void)contentViewMethod:(UIButton *)sender{
    switch (sender.tag) {
        case 0:{
            [self yonghuxinxi];
            _contentBtn_1.selected = YES;
            _contentBtn_2.selected = NO;
            self.contentScroll.contentOffset = CGPointMake(0, 0);
            
        }
            break;
        case 1:{
            _contentBtn_1.selected = NO;
            _contentBtn_2.selected = YES;
            self.contentScroll.contentOffset = CGPointMake(selfW, 0);
            
            
        }
            break;
        default:
            break;
    }
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.contentScroll.contentOffset.x < selfW) {
        _contentBtn_1.selected = YES;
        _contentBtn_2.selected = NO;
    }else{
        _contentBtn_1.selected = NO;
        _contentBtn_2.selected = YES;
    }
}

-(void)yonghuxinxi
{
    //    NSMutableDictionary* dic=[NSMutableDictionary new];
    ETProductModel* p=[_products objectAtIndex:0];
    long long a=[p.releaseTypeId longLongValue];
    long long b=[p.userId longLongValue];
    NSDictionary *params = @{
                             @"releaseTypeId" : @(a),
                             @"userId" :@(b)
                             };
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    
    [HttpTool get:[NSString stringWithFormat:@"/release/userOrders"] params:params success:^(NSDictionary *response) {
//                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        NSString *str=response[@"data"];
        NSLog(@"%@",str);
        [self PostInfoUI];
//        [self PostCorpUI];
    } failure:^(NSError *error) {
        NSLog(@"");
        
    }];
}

-(void)PostInfoUI
{
//    ETProductModel* p=[_products objectAtIndex:0];
    if (![MySingleton sharedMySingleton].toUserid) {
        return;
    }
    NSDictionary *params = @{
                             @"uid" : [MySingleton sharedMySingleton].toUserid
                             };
    
    [HttpTool get:[NSString stringWithFormat:@"user/info"] params:params success:^(id responseObj) {
        if ([responseObj[@"data"] isKindOfClass:[NSNull class]]) {
            return;
        }
        //        _products=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
        UserInfoModel* info=[UserInfoModel mj_objectWithKeyValues:responseObj[@"data"][@"userInfo"]];
        _comp.text=info.company;
        if ([info.isChecked isEqualToString:@"5"]) {
            self.corpImg.hidden=NO;
        }
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
@end

