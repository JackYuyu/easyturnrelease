//
//  ETMessageCenterController.m
//  EasyTurn
//
//  Created by 程立 on 2019/7/18.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETMessageCenterController.h"
@interface ETMessageCenterController ()<UITableViewDelegate, UITableViewDataSource>
@property(nonatomic,strong)UITableView*tab;
@end
@implementation ETMessageCenterController

- (UITableView *)tab
{
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0,0, Screen_Width, Screen_Height) style:UITableViewStyleGrouped];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.rowHeight=89;
        _tab.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0,0,0,0.01)];
        _tab.sectionFooterHeight =0;
        _tab.sectionHeaderHeight =10;
    }
    return _tab;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self wr_setNavBarTitleColor:kACColorBlackTypeface];
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:kACColorWhite];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self wr_setNavBarTitleColor:kACColorWhite];
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:kACColorBlue_Theme];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    [self enableLeftBackButton];
    [self.view addSubview:self.tab];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 1;
    }else if (section==1) {
        return 3;
    }
    return YES;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell*cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    cell.imageView.image=[UIImage imageNamed:@"我的_Bitmap"];
    cell.textLabel.text=@"易转平台";
    cell.detailTextLabel.text=@"易转科技";
    return cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
@end
