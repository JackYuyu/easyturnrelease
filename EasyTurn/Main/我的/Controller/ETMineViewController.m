//
//  ETMineViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/9/1.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETMineViewController.h"
#import "ETMineHeaderView.h"
#import "ETMineViewCell.h"
static NSString *const kETMineViewCell = @"ETMineViewCell";
@interface ETMineViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tbMine;
@end

@implementation ETMineViewController

- (UITableView *)tbMine {
    if (!_tbMine) {
        _tbMine = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
        _tbMine.delegate = self;
        _tbMine.dataSource = self;
        _tbMine.separatorStyle = UITableViewCellSelectionStyleNone;
        _tbMine.showsHorizontalScrollIndicator = NO;
        [_tbMine registerClass:[ETMineViewCell class] forCellReuseIdentifier:kETMineViewCell];
    }
    return _tbMine;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createSubViewsAndConstraints];
}


#pragma mark - createSubViewsAndConstraints
- (void)createSubViewsAndConstraints {
    [self.view addSubview:self.tbMine];
}

#pragma mark - UITableviewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ETMineViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kETMineViewCell];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 51;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 
}



@end
