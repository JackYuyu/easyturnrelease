//
//  WelcomeController.m
//  XingHou
//
//  Created by 陈林 on 16/7/24.
//  Copyright © 2016年 CYX. All rights reserved.
//

#import "WelcomeController.h"
#import "AppDelegate.h"
#import <Masonry.h>
@interface WelcomeController () <UIScrollViewDelegate>
{
    UIPageControl *_control;
    NSString *_keyName;
    UIButton *_btn;
}
@end

@implementation WelcomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
}

- (void)setupUI {
    NSArray *strArr = @[@"wel1", @"wel2", @"wel3", @"wel4"];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, XH_SCREEN_WIDTH, XH_SCREEN_HEIGHT)];
    scrollView.contentSize = CGSizeMake(XH_SCREEN_WIDTH*strArr.count, XH_SCREEN_HEIGHT);
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.bounces = NO;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    
    for (int i=0; i<strArr.count; i++) {
        UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(i*XH_SCREEN_WIDTH, 0, XH_SCREEN_WIDTH, scrollView.height)];
        iv.image = [UIImage imageNamed:strArr[i]];
        [scrollView addSubview:iv];
    }
    
    UIPageControl *control = [[UIPageControl alloc] initWithFrame:CGRectMake(0, XH_SCREEN_HEIGHT-90, XH_SCREEN_WIDTH, 5)];
    _control = control;
    control.currentPageIndicatorTintColor = [UIColor redColor];
    control.pageIndicatorTintColor = [UIColor lightGrayColor];
    control.numberOfPages = strArr.count;
//    [self.view addSubview:control];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake((XH_SCREEN_WIDTH-120)/2, XH_SCREEN_HEIGHT-90-15, 120, 36)];
    _btn = btn;
    if (IS_IPHONE_5) {
        btn.y = XH_SCREEN_HEIGHT-90+28;
    }
    [btn setTitle:@"立即体验" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.layer.cornerRadius = 3;
    btn.layer.masksToBounds = YES;
    btn.alpha = 0;
    [self.view addSubview:btn];
    
    [btn addTarget:self action:@selector(inToApp) forControlEvents:UIControlEventTouchUpInside];
}

- (void)inToApp {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setBool:YES forKey:kIsWelcomeKey];
    [(AppDelegate *)[UIApplication sharedApplication].delegate returnback];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x/XH_SCREEN_WIDTH;
    if (index == 3) {
        [UIView animateWithDuration:1 animations:^{
            _btn.alpha = 1;
        }];
    }else {
        _btn.alpha = 0;
    }
    _control.currentPage = index;
}

@end
