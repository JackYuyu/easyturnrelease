//
//  ETRKongViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/25.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import "ETRKongViewController.h"
#import "PublishMenuButton.h"

#import "ETIssueViewController.h"
#import "ETPublishPurchaseViewController.h"
#import "ETPersuadersViewController.h"

#import "ETPublishPurchaseSegmentViewController.h"
//自定义颜色rgba
#define ColorWithRGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/1.0] //<<< 用10进制表示颜色，例如（255,255,255）黑色

//屏幕尺寸
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ETRKongViewController ()

@property (nonatomic,strong) UIImageView *publishImg;
@property (nonatomic,strong) UILabel *publishLab;
@property (nonatomic,strong) UIButton *publishBtn;

@property (nonatomic,strong) UIImageView *purchaseImg;
@property (nonatomic,strong) UILabel *purchaseLab;
@property (nonatomic,strong) UIButton *purchaseBtn;

@property (nonatomic,strong) UIImageView *businessImg;
@property (nonatomic,strong) UILabel *businessLab;
@property (nonatomic,strong) UIButton *businessBtn;

@property (nonatomic,strong) UIButton *fanhuiBtn;

//added by zhichao.li
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, strong) NSMutableArray *itemButtons;

@property(assign,nonatomic)NSUInteger upIndex;

@property(assign,nonatomic)NSUInteger downIndex;

@property(strong,nonatomic)UIImageView *closeImgView;

@property(strong,nonatomic)NSArray *ary;

@end

@implementation ETRKongViewController

- (NSMutableArray *)itemButtons
{
    if (_itemButtons == nil) {
        _itemButtons = [NSMutableArray array];
    }
    return _itemButtons;
}

-(NSArray *)ary{
    
    if (_ary==nil) {
        
        _ary = [NSArray array];
        
        _ary = @[@"shangpin",@"biaoqian",@"huangguan"];
    }
    
    return _ary;
}

//重新初始化主视图样式 透明->
-(void)loadView{
    
    UIView *view = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [view setBackgroundColor:[UIColor whiteColor]];
    
    //获取截取的背景图片，便于达到模糊背景效果
    UIImageView *imgView = [[UIImageView alloc]initWithImage:_backImg];
    
    //模糊效果层
    UIView *blurView =[[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    [blurView setBackgroundColor:ColorWithRGBA(255, 255, 255, 0.9)];// [UIColor colorWithWhite:0.9 alpha:0.8]];
    
    [imgView addSubview:blurView];
    
    [view addSubview:imgView];
    
    self.view = view;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加菜单按钮
    [self setMenu];
    //添加底部关闭按钮
    [self insertCloseImg];
    
    //定时器控制每个按钮弹出的时间
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(popupBtn) userInfo:nil repeats:YES];
    
    //添加手势点击事件
    UITapGestureRecognizer *touch = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchesBegan:)];
    [self.view addGestureRecognizer:touch];
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [UIView animateWithDuration:0.6 animations:^{
        
        _closeImgView.transform = CGAffineTransformRotate(_closeImgView.transform, M_PI);
    }];
}

//关闭图片
- (void)insertCloseImg{
    
    UIImage *img = [UIImage imageNamed:@"关闭"];
    
    UIImageView *imgView = [[UIImageView alloc]initWithImage:img];
    
    imgView.frame = CGRectMake(self.view.center.x-15, self.view.frame.size.height-45, 30, 30);
    
    [self.view addSubview:imgView];
    
    _closeImgView = imgView;
    
}

- (void)popupBtn{
    
    if (_upIndex == self.itemButtons.count) {
        
        [self.timer invalidate];
        
        _upIndex = 0;
        
        return;
    }
    
    PublishMenuButton *btn = self.itemButtons[_upIndex];
    
    [self setUpOneBtnAnim:btn];
    
    _upIndex++;
}

//设置按钮从第一个开始向上滑动显示
- (void)setUpOneBtnAnim:(UIButton *)btn
{
    
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        btn.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished){
        
        //获取当前显示的菜单控件的索引
        _downIndex = self.itemButtons.count - 1;
    }];
    
}


//按九宫格计算方式排列按钮
- (void)setMenu{
    
    int cols = 3;
    int col = 0;
    int row = 0;
    
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat wh = 100;
    
    CGFloat margin = ([UIScreen mainScreen].bounds.size.width - cols * wh) / (cols + 1);
    
    //此处按照不同屏幕尺寸适配
    CGFloat oriY = 500;
    CGFloat xx=kScreenHeight;
    if (kScreenHeight == 480) {
        //4/4s
        oriY = 313;
    }else if (kScreenHeight == 568){
        //5/5s
        oriY = 400;
    }else if (kScreenHeight == 667){
        //6/6S
        oriY = 500;
    }else if (kScreenHeight==896){
        oriY= 680;
    }else{
        //6P 736
        oriY = 569;
    }
    
    for (int i = 0; i < self.ary.count; i++) {
        
        
        NSArray *arrTitle = @[@"发布出售",@"发布求购",@"企服者"];
        
        
        PublishMenuButton *btn = [PublishMenuButton buttonWithType:UIButtonTypeCustom];
        
        //图标图片和文本
        UIImage *img = [UIImage imageNamed:self.ary[i]];
        NSString *title = arrTitle[i];
        
        [btn setImage:img forState:UIControlStateNormal];
        [btn setTitle:title forState:UIControlStateNormal];
        
        //列数(个数除总列数取余)
        col = i % cols;
        //行数(个数除总列数取整)
        row = i / cols;
        //x 平均间隔 + 前图标宽度
        x = margin + col * (margin + wh);
        //y 起始y + 前宽度
        y = row * (margin + wh) + oriY;
        
        //added by zhichao.li 高度要调整
        if (i == 0) {
            y = y+20;
        }else if (i == 1){
            y=y-30;
        }else if (i==2){
            y = y+20;
        }
        
        btn.frame = CGRectMake(x, y, wh, wh);
        
        btn.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
        
        btn.tag = 1000 + i;
        
        [btn addTarget:self action:@selector(touchDownBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.itemButtons addObject:btn];
        
        [self.view addSubview:btn];
        
    }
    
}

//点击按钮进行放大动画效果直到消失
- (void)touchDownBtn:(PublishMenuButton *)btn{
    
    //根据选中的不同按钮的tag判断进入相应的界面->
    
    if (btn.tag == 1000) {

        //发布出售
        ETIssueViewController *vc = [[ETIssueViewController alloc]init];
        [vc toDissmissSelf:^{
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(returnUpVC) userInfo:nil repeats:YES];
            [UIView animateWithDuration:0 animations:^{
                self->_closeImgView.transform = CGAffineTransformRotate(self->_closeImgView.transform, -M_PI_2*1.5);
            }];
        }];
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:nvc animated:YES completion:nil];
//        [self.navigationController pushViewController:vc animated:YES];
       
    }else if(btn.tag == 1001){
        ETPublishPurchaseSegmentViewController *vcPublishPurchaseSegment = [[ETPublishPurchaseSegmentViewController alloc] init];
        UINavigationController *naviRoot = [[UINavigationController alloc]initWithRootViewController:vcPublishPurchaseSegment];
        [self presentViewController:naviRoot animated:YES completion:nil];
        return;
        #warning geweiTestCode
        //发布求购
        ETPublishPurchaseViewController *vc = [[ETPublishPurchaseViewController alloc]init];
        [vc toDissmissSelf:^{
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(returnUpVC) userInfo:nil repeats:YES];
            [UIView animateWithDuration:0 animations:^{
                self->_closeImgView.transform = CGAffineTransformRotate(self->_closeImgView.transform, -M_PI_2*1.5);
            }];
        }];
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:nvc animated:YES completion:nil];
    }else{
  
        //企服者
        ETPersuadersViewController *vc = [[ETPersuadersViewController alloc]init];
        [vc toDissmissSelf:^{
            self.timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(returnUpVC) userInfo:nil repeats:YES];
            [UIView animateWithDuration:0 animations:^{
                self->_closeImgView.transform = CGAffineTransformRotate(self->_closeImgView.transform, -M_PI_2*1.5);
            }];
        }];
        UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:nvc animated:YES completion:nil];
    }
    
    
    [UIView animateWithDuration:0.5 animations:^{
        btn.transform = CGAffineTransformMakeScale(2.0, 2.0);
        btn.alpha = 0;
    }];
    
}


//设置按钮从后往前下落
- (void)returnUpVC{
    
    if (_downIndex == -1) {
        
        [self.timer invalidate];
        
        return;
    }
    
    PublishMenuButton *btn = self.itemButtons[_downIndex];
    
    [self setDownOneBtnAnim:btn];
    
    _downIndex--;
}

//按钮下滑并返回上一个控制器
- (void)setDownOneBtnAnim:(UIButton *)btn
{
    
    [UIView animateWithDuration:0.6 animations:^{
        
        btn.transform = CGAffineTransformMakeTranslation(0, self.view.bounds.size.height);
        
    } completion:^(BOOL finished) {
        
        [self dismissViewControllerAnimated:NO completion:nil];
        
    }];
    
}

//点击事件返回上一控制器,并且旋转145弧度关闭按钮
-(void)touchesBegan:(UITapGestureRecognizer *)touches{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(returnUpVC) userInfo:nil repeats:YES];
    
    [UIView animateWithDuration:0.3 animations:^{self->
        
        _closeImgView.transform = CGAffineTransformRotate(_closeImgView.transform, -M_PI_2*1.5);
    }];
    
}


@end
