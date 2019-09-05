//
//  ETAuthenticateViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/20.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import "ETAuthenticateViewController.h"
#import "MCPageView.h"
#import "PersonalVC.h"
#import "StaffVC.h"
#import "LegalPersonVC.h"
@interface ETAuthenticateViewController ()
@property (nonatomic , strong) MCPageView * PageView;
@end

@implementation ETAuthenticateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden=NO;
    self.navigationItem.title = @"身份验证";
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    NSMutableArray *titles = [NSMutableArray array];
    NSMutableArray *controllers = [NSMutableArray array];
    
    [controllers addObject:[PersonalVC new]];
    [titles addObject:@"个人认证"];
    
    [controllers addObject:[StaffVC new]];
    [titles addObject:@"员工认证"];
    
    [controllers addObject:[LegalPersonVC new]];
    [titles addObject:@"法人认证"];
    
    self.PageView = [[MCPageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height) titles:titles controllers:controllers];
    self.PageView.titleButtonWidth = 60;
    self.PageView.lineWitdhScale = 0.2;
    self.PageView.selectTitleFont = [UIFont boldSystemFontOfSize:13];
    self.PageView.defaultTitleFont = [UIFont boldSystemFontOfSize:13];
    self.PageView.defaultTitleColor = [UIColor lightGrayColor];
    self.PageView.selectTitleColor = [UIColor blackColor];
    [self.PageView setBadgeWithIndex:3 badge:0];
    //    [self.PageView setBadgeWithIndex:1 badge:58];
    //    [self.PageView setBadgeWithIndex:5 badge:-1];
    //    [self.PageView setBadgeWithIndex:2 badge:1000];
    [self.view addSubview:self.PageView];
}

@end
