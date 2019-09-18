//
//  BorrowCardViewController.m
//  XingHou
//
//  Created by mbp on 16/7/21.
//  Copyright © 2016年 CYX. All rights reserved.
//

#import "BorrowCardViewController.h"

@interface BorrowCardViewController ()<UIWebViewDelegate>

@end

@implementation BorrowCardViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, XH_SCREEN_WIDTH, XH_SCREEN_HEIGHT-64)];
    webView.backgroundColor = [UIColor clearColor];
    webView.scalesPageToFit=YES;
    webView.delegate = self;
//    if (self.index==1) {
    
    
    [self.view addSubview:webView];
    
    NSURL* url = [NSURL URLWithString:self.url];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
//    }
//    else{
//        UIScrollView* sv=[[UIScrollView alloc] init];
//        sv.contentSize=CGSizeMake(XH_SCREEN_WIDTH, XH_SCREEN_HEIGHT*3);
//        sv.pagingEnabled=YES;
//        sv.scrollEnabled=YES;
//    UIImageView* img=[[UIImageView alloc] init];
//    img.contentMode = UIViewContentModeScaleToFill;
//
////    [img sd_setImageWithURL:[NSURL URLWithString:self.url]];
//    [img setImage:[UIImage imageNamed:@"41568449629_.pic_hd1"]];
//    [sv addSubview:img];
//        [self.view addSubview:sv];
//    [img mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(Screen_Width);
//        make.top.mas_equalTo(self.view.mas_top).mas_offset(0);
//        make.height.mas_equalTo(Screen_Height);
//    }];
//
//
//    [sv mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(Screen_Width);
//        make.top.mas_equalTo(self.view.mas_top).mas_offset(0);
//                make.height.mas_equalTo(Screen_Height);
//    }];
//}
    
}

- (void)backClick {

    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    UINavigationBar *navigationBar = self.navigationController.navigationBar;
//    [navigationBar setShadowImage:[UIImage new]];
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navi_bg"] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];

}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(nonnull NSError *)error {
    [MBProgressHUD hideAllHUDsForView:self.view animated:NO];
}


@end
