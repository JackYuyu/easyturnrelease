//
//  ETStoreUpViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/23.
//  Copyright © 2019年 EasyTurn. All rights reserved.
//

#import "ETFootViewController.h"
#import "ETEnterpriseServiceTableViewCell1.h"
#import "ETProductModel.h"
@interface ETFootViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tab;
@property(nonatomic,strong)UIButton *loadingBtn;
@property(nonatomic,strong)NSMutableArray*products;
@property(nonatomic,strong)UIButton *deleBtn;
@property(nonatomic,strong)ETProductModel *m;
@end

@implementation ETFootViewController
-  (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_tab reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title=@"访问记录";
    self.view.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tab];
//    [self.view addSubview:self.loadingBtn];
    [self.tab registerClass:[ETEnterpriseServiceTableViewCell1 class] forCellReuseIdentifier:@"cell"];
     [self PostUI:@"1"];
}


- (UITableView *)tab
{
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStylePlain];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.rowHeight=158;
        _tab.tableFooterView=[[UIView alloc]initWithFrame:CGRectZero];
    }
    return _tab;
}

- (UIButton *)loadingBtn {
    if (!_loadingBtn) {
        _loadingBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 400, self.view.frame.size.width, 50)];
        [_loadingBtn setTitle:@"点击加载更多" forState:UIControlStateNormal];
        [_loadingBtn setTitle:@"" forState:UIControlStateSelected];
        _loadingBtn.selected=YES;
        [_loadingBtn setTitleColor:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0] forState:UIControlStateNormal];
        
    }
    return _loadingBtn;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _products.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ETEnterpriseServiceTableViewCell1*cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
     cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_products.count>0) {
        _m=[_products objectAtIndex:indexPath.row];
        cell.serviceLab.text=_m.desc;
        cell.giveserviceLab.text=_m.title;
        if ([_m.releaseId isEqualToString:@"1001"]) {
            cell.serviceLab.text=@"出售";
        }else if ([_m.releaseId isEqualToString:@"1002"]) {
            cell.serviceLab.text=@"求购";
        }else if ([_m.releaseId isEqualToString:@"1003"]) {
            cell.serviceLab.text=@"服务";
        }
        cell.moneyLab.text=[NSString stringWithFormat:@"¥%@",_m.price];
        
        cell.addressLab.text=_m.cityName;
        cell.detailsLab.text=_m.business;
        [cell.comImg sd_setImageWithURL:[NSURL URLWithString:_m.imageList]];
        if ([_m.releaseTypeId isEqualToString:@"1"]) {
            UIImageView* jiao=[UIImageView new];
            [jiao setImage:[UIImage imageNamed:@"首页_出售"]];
            [cell.comImg addSubview:jiao];
            [jiao mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.mas_equalTo(0);
                make.width.mas_equalTo(35);
                make.height.mas_equalTo(35);
            }];
        }
        if ([_m.releaseTypeId isEqualToString:@"3"]) {
            UIImageView* jiao=[UIImageView new];
            [jiao setImage:[UIImage imageNamed:@"首页_企服者"]];
            [cell.comImg addSubview:jiao];
            [jiao mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.mas_equalTo(0);
                make.width.mas_equalTo(35);
                make.height.mas_equalTo(35);
            }];
        }
        if ([_m.releaseTypeId isEqualToString:@"2"]) {
            UIImageView* jiao=[UIImageView new];
            [jiao setImage:[UIImage imageNamed:@"首页_求购"]];
            [cell.comImg addSubview:jiao];
            [jiao mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(0);
                make.top.mas_equalTo(0);
                make.width.mas_equalTo(35);
                make.height.mas_equalTo(35);
            }];
        }
        
    }
    _deleBtn =[[UIButton alloc]init];
    [_deleBtn setTitle:@"删除" forState:UIControlStateNormal];
    [_deleBtn setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
    [cell addSubview:self.deleBtn];
    _deleBtn.layer.borderWidth=1;
    _deleBtn.layer.cornerRadius=4;
    _deleBtn.titleLabel.font=[UIFont systemFontOfSize:13 weight:9];
    _deleBtn.layer.borderColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0].CGColor;
    _deleBtn.tag=indexPath.row;
    [_deleBtn addTarget:self action:@selector(aaaa:) forControlEvents:UIControlEventTouchUpInside];
    [_deleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.right.mas_equalTo(-15);
        make.size.mas_equalTo(CGSizeMake(60, 26));
    }];
    return cell;
}
- (void)aaaa:(UIButton*)sender {
    [self PostUI1:sender.tag];
    NSLog(@"1");
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tab deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    // 2
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    // 3点击没有颜色改变
    cell.selected = NO;
}

- (void)PostUI:(NSString*)head {
    NSDictionary *params = @{
                             };
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    
    [HttpTool get:[NSString stringWithFormat:@"collect/my"] params:params success:^(NSDictionary *response) {
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
        //        NSLog(@"%@",jsonDict);
        _products=[NSMutableArray new];
        NSDictionary* a=response[@"data"];
        for (NSDictionary* prod in response[@"data"]) {
          
            ETProductModel* p=[ETProductModel mj_objectWithKeyValues:prod];
            if (p) {
                [_products addObject:p];
               
            }
        }
        [_tab reloadData];
    } failure:^(NSError *error) {
        
    }];
}
- (void)PostUI1:(NSInteger)b {
//    NSInteger m=_products.count;
    
    NSMutableDictionary* dic=[NSMutableDictionary new];
    ETProductModel* p=[_products objectAtIndex:b];
    
    long long a=[p.releaseId longLongValue];
    NSDictionary *params = @{
                             @"releaseId" : @(a)
                             };
    NSData *data =    [NSJSONSerialization dataWithJSONObject:params options:NSUTF8StringEncoding error:nil];
    
    [HttpTool put:[NSString stringWithFormat:@"collect/myDel"] params:params success:^(NSDictionary *response) {
        //        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:nil];
      
        NSLog(@"");
                [_products removeObjectAtIndex:b];
        [_tab reloadData];
    } failure:^(NSError *error) {
        NSLog(@"");
    }];

}
@end
