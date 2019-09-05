//
//  PopTableListView.m
//  PopView
//
//  Created by 李志超 on 2019/8/3.
//  Copyright © 2019年 李志超. All rights reserved.
//

#import "PopTableListView.h"


@interface PopTableListView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,copy) NSArray *titles;
@property (nonatomic ,copy) NSArray *imgNames;
@property (nonatomic ,copy) NSString *type;

@end
@implementation PopTableListView
- (instancetype)initWithTitles:(NSArray <NSString *>*)titles imgNames:(NSArray <NSString *>*)imgNames type:(NSString *)type
{
    CGRect frame = CGRectMake(0, 0, 80, titles.count*44);
    if ([type isEqualToString:@"1"]) {
        frame = CGRectMake(0, 0, 110, titles.count*44);
    }
    self = [super initWithFrame:frame];
    if (self) {
        self.titles = titles;
        self.imgNames = imgNames;
        self.type = type;
        self.layer.borderColor = RGBCOLOR(0.21*255, 0.54*255, 0.97*255).CGColor;
        self.layer.borderWidth = 1.0f;
        self.layer.masksToBounds = YES;
        
        [self addSubview:self.tableView];
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor darkTextColor];
//        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 43.5, 150, .5)];
//        lineView.backgroundColor = [UIColor lightGrayColor];
//        [cell.contentView addSubview:lineView];
    }
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    if (self.imgNames.count>indexPath.row) {
        cell.imageView.image = [UIImage imageNamed:self.imgNames[indexPath.row]];
    }
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    
    if (self.delegate) {
        if ([self.type isEqualToString:@"1"]) {
            [self.delegate selectType:self.titles[indexPath.row] type:@"1"];
        }else{
            [self.delegate selectEffetiveTimeType:self.titles[indexPath.row] type:@"2"];
        }
        
    }
}




- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.scrollEnabled = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}

@end
