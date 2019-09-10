//
//  MCPageViewViewController.m
//  QQFoundation
//
//  Created by qinmuqiao on 2018/9/19.
//  Copyright © 2018年 慕纯. All rights reserved.
//

#import "MCPageViewViewController.h"
#import "MCPageView.h"
#import "MCPageViewSub1ViewController.h"
#import "MCPageViewSub2ViewController.h"
#import "MCPageViewSub3ViewController.h"

@interface MCPageViewViewController ()
@property (nonatomic , strong) MCPageView * PageView;
@end

@implementation MCPageViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor=[UIColor blueColor];
    self.title = @"企业认证";
    NSMutableArray *titles = [NSMutableArray array];
    NSMutableArray *controllers = [NSMutableArray array];
    MCPageViewSub1ViewController* sub1=[MCPageViewSub1ViewController new];
    [controllers addObject:sub1];
    [titles addObject:@"企业信息"];
    MCPageViewSub2ViewController* sub2=[MCPageViewSub2ViewController new];
    sub2.owner=self;
    [controllers addObject:sub2];
    [titles addObject:@"员工管理"];
    MCPageViewSub3ViewController* sub3=[MCPageViewSub3ViewController new];
    sub3.owner=self;
    [controllers addObject:sub3];
    [titles addObject:@"订单管理"];
    self.PageView = [[MCPageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height) titles:titles controllers:controllers];
    self.PageView.titleButtonWidth = 60;
    self.PageView.lineWitdhScale = 0.2;
    self.PageView.selectTitleFont = [UIFont boldSystemFontOfSize:16];
    self.PageView.defaultTitleFont = [UIFont boldSystemFontOfSize:16];
    self.PageView.defaultTitleColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    self.PageView.selectTitleColor = [UIColor colorWithRed:47/255.0 green:134/255.0 blue:251/255.0 alpha:1.0];
    [self.PageView setBadgeWithIndex:3 badge:0];
    [self.PageView setBadgeWithIndex:1 badge:0];
    [self.PageView setBadgeWithIndex:5 badge:-1];
    [self.PageView setBadgeWithIndex:2 badge:1000];
    [self.view addSubview:self.PageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
