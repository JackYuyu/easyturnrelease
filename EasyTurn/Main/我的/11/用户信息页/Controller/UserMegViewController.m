
#import "UserMegViewController.h"
#import "UserSaleView.h"
#import "UserServeView.h"
#define selfW self.view.frame.size.width
#define selfH self.view.frame.size.height

@interface UserMegViewController () <UINavigationControllerDelegate,UIScrollViewDelegate>
@property(nonatomic , strong)UIView *topView;
@property(nonatomic , strong)UIButton *backBtn;
@property(nonatomic , strong)UIButton *iconBtn;
@property(nonatomic , strong)UILabel *userNameLab ,* corpLab;
@property(nonatomic , strong)UIImageView *corpImg;
@property(nonatomic , strong)UIView *topView_2;
@property(nonatomic , strong)UIView *contentView;
@property(nonatomic , strong)UIButton *contentBtn_1,*contentBtn_2;
@property(nonatomic , strong)UIScrollView *contentScroll;
@end

@implementation UserMegViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // 设置导航控制器的代理为self
    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.topView_2];
    [self.view addSubview:self.contentView];
    [self.view addSubview:self.contentScroll];
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
        UserServeView *serveView = [[UserServeView alloc]initWithFrame:CGRectMake(0, 0, _contentScroll.frame.size.width, _contentScroll.frame.size.height)];
        
        [_contentScroll addSubview:serveView];
        [_contentScroll addSubview:saleView];
    }
    return _contentScroll;
}
//中间的View
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 280, selfW, 50)];
        _contentView.layer.borderWidth = 0.5;
        _contentView.backgroundColor = [UIColor redColor];
        _contentBtn_1 = [[UIButton alloc]initWithFrame:CGRectMake((selfW - (selfW - 80)), 10, 50, 25)];
        [_contentBtn_1 setTitle:@"出售" forState:UIControlStateNormal];
        _contentBtn_1.titleLabel.font = [UIFont systemFontOfSize:22 weight:12];
        _contentBtn_1.tag = 0;
        
        _contentBtn_2 = [[UIButton alloc]initWithFrame:CGRectMake((selfW - 120), 10, 50, 25)];
        [_contentBtn_2 setTitle:@"服务" forState:UIControlStateNormal];
        _contentBtn_2.titleLabel.font = [UIFont systemFontOfSize:22 weight:12];
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
        
        UILabel *lable_1 = [[UILabel alloc]initWithFrame:CGRectMake(_topView_2.frame.origin.x + 5, 5, 90, 25)];
        lable_1.text = @"所属公司";
        lable_1.font = [UIFont systemFontOfSize:18];
        UILabel *lable_2 = [[UILabel alloc]initWithFrame:CGRectMake(lable_1.frame.origin.x + lable_1.frame.size.width, 5, _topView_2.frame.size.width / 2 - 10, 25)];
        lable_2.text = @"寻寻中介服务有限公司";
        UIButton *btn_1 = [[UIButton alloc]initWithFrame:CGRectMake(lable_2.frame.origin.x + lable_2.frame.size.width + 5, 5, _topView_2.frame.size.width - (lable_2.frame.origin.x + lable_2.frame.size.width) - 10, 30)];
        btn_1.layer.cornerRadius = 20;
        btn_1.clipsToBounds = YES;
        btn_1.backgroundColor = [UIColor redColor];
        
        [_topView_2 addSubview:lable_1];
        [_topView_2 addSubview:lable_2];
        [_topView_2 addSubview:btn_1];
    }
    return _topView_2;
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
        self.userNameLab.text = @"虚拟用户";
        self.corpLab = [[UILabel alloc]initWithFrame:CGRectMake((selfW - (selfW - 30)) + 100 + 10, statusRect.size.height + 10 + 30 + 20 + 25 + 5, 100, 25)];
        self.corpLab.textColor = [UIColor whiteColor];
        self.corpLab.text = @"虚拟公司";
        self.corpImg = [[UIImageView alloc]initWithFrame:CGRectMake((selfW - (selfW - 30)) + 100 + 10 + 100 + 10, statusRect.size.height + 10 + 30 + 20 + 5, 20, 20)];
        _corpImg.backgroundColor = [UIColor redColor];
        
        [_topView addSubview:self.backBtn];
        [_topView addSubview:self.iconBtn];
        [_topView addSubview:self.userNameLab];
        [_topView addSubview:self.corpLab];
        [_topView addSubview:self.corpImg];
    }
    return _topView;
}
///头像按钮
-(UIButton *)iconBtn{
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];
    if (!_iconBtn) {
        _iconBtn = [[UIButton alloc]initWithFrame:CGRectMake((selfW - (selfW - 30)), statusRect.size.height + 10 + 30 + 5, 100, 100)];
        _iconBtn.layer.cornerRadius = 50;
        _iconBtn.clipsToBounds = YES;
        _iconBtn.backgroundColor = [UIColor redColor];
    }
    return _iconBtn;
}
-(UIButton *)backBtn{
    CGRect statusRect = [[UIApplication sharedApplication] statusBarFrame];

    if (!_backBtn) {
        _backBtn = [[UIButton alloc]initWithFrame:CGRectMake((selfW - (selfW - 30)), statusRect.size.height + 10, 30, 30)];
        _backBtn.backgroundColor = [UIColor blackColor];
        [_backBtn addTarget:self action:@selector(onclickBackBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

-(void)onclickBackBtn{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc {
    self.navigationController.delegate = nil;
}
-(void)contentViewMethod:(UIButton *)sender{
    switch (sender.tag) {
        case 0:{
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
@end
