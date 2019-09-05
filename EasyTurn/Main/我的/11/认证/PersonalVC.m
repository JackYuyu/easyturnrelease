//
//  PersonalVC.m
//  product
//
//  Created by 安离夕 on 2019/7/20.
//  Copyright © 2019年 liuzhuang. All rights reserved.
//

#import "PersonalVC.h"

@interface PersonalVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView * table;
@property(nonatomic,strong)UILabel * NameLabel;
@property(nonatomic,strong)UILabel * IDCardLabel;
@property(nonatomic,strong)UIButton * btn;
@end

@implementation PersonalVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.table];
}

-(UITableView *)table{
    if (_table == nil) {
        
        _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _table.delegate = self;
        _table.dataSource = self;
        _table.bounces = NO;
        _table.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0,0,0,0.01)];
        _table.sectionFooterHeight =0;
        
        _table.sectionHeaderHeight =0;
    }
    return _table;
}

//-(UIButton *)btn{
//    if (_btn == nil) {
//
//        _btn = [[UIButton alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)];
//
//    }
//}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 2;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            _NameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 50, 20)];
            _NameLabel.font = [UIFont systemFontOfSize:15];
            _NameLabel.text = @"姓名";
            [cell addSubview:self.NameLabel];
            
            UITextField * ed = [[UITextField alloc]initWithFrame:CGRectMake(60, 20, cell.frame.size.width-60, 20)];
            
            ed.placeholder = @"请输入您的真实姓名";
            
            ed.textAlignment = NSTextAlignmentCenter;
            
            [cell addSubview:ed];
            
        }else{
            _IDCardLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, 80, 20)];
            _IDCardLabel.font = [UIFont systemFontOfSize:15];
            _IDCardLabel.text = @"身份证号";
            [cell addSubview:self.IDCardLabel];
            
            UITextField * ed = [[UITextField alloc]initWithFrame:CGRectMake(90, 20, cell.frame.size.width-90, 20)];
            
            ed.placeholder = @"请输入您本人的身份证号";
            
            
            ed.textAlignment = NSTextAlignmentCenter;
            
            [cell addSubview:ed];
        }
    }else{
        UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, self.view.frame.size.width-10*2, 210)];
        
        img.image = [UIImage imageNamed:@"分组 2"];
        
        img.backgroundColor = [UIColor lightGrayColor];
        
        [cell addSubview:img];
        
        if (indexPath.row == 1) {
            
            UILabel * label =[[UILabel alloc]initWithFrame:CGRectMake(10, 230, 400, 60)];
            label.font = [UIFont systemFontOfSize:15];
            label.textColor = [UIColor lightGrayColor];
            label.numberOfLines = 0;
            label.text = @"注：上传图片仅支持JPG、JPEG、PNG格式，图片大小不超过5M";
            [cell addSubview:label];
        }
    }
    
   
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        
        return 60;
        
    }else{
        if (indexPath.row == 0) {
            return 230;
        }else{
            return 290;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_table deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 2
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    // 3点击没有颜色改变
    cell.selected = NO;
}

@end
