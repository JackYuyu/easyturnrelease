//
//  PopTableListView.m
//  PopView
//
//  Created by 李志超 on 2019/8/3.
//  Copyright © 2019年 李志超. All rights reserved.
//

#import "PopTableListView.h"

static NSString * const cellIdentifier = @"cellIdentifier";
@interface PopTableListView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong) UITableView *tableView;
@property (nonatomic ,copy) NSArray *titles;
@property (nonatomic ,copy) NSArray *imgNames;
@property (nonatomic ,copy) NSString *type;

@end
@implementation PopTableListView
- (instancetype)initWithTitles:(NSArray <NSString *>*)titles imgNames:(NSArray <NSString *>*)imgNames type:(NSString *)type {
    CGFloat maxWidth = 80;
    if ([type isEqualToString:@"1"]) {
        maxWidth = 110;
    }
    return [self initWithTitles:titles imgNames:imgNames type:type maxWidth:maxWidth];
}

- (instancetype)initWithTitles:(NSArray <NSString *>*)titles imgNames:(NSArray <NSString *>*)imgNames type:(NSString *)type maxWidth:(CGFloat)maxWidth {
        
        CGRect frame = CGRectMake(0, 0, maxWidth, titles.count*44);
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
    #warning geweiTestCode
    if (self.delegate) {
         [self.delegate selectType:self.titles[indexPath.row] type:@"1"];
        
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
