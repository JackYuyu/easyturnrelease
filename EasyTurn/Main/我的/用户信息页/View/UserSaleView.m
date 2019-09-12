

#import "UserSaleView.h"
#import "UserSaleViewCell.h"
#import "SaleModel.h"
#import "ETProductModel.h"
#import "ETDynamicListCell.h"
#import "ETMeinDynamicListCell.h"
#import "ETBuyFinishViewController.h"
#import "ETForBuyDetailController.h"
#import "ETServiceDetailController.h"
#import "ETSaleDetailController.h"
#import "ETUserListCell.h"
@interface UserSaleView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic , strong)NSMutableArray *array;
@property(nonatomic , strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIButton* refchBtn;

@end
@implementation UserSaleView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.array = [NSMutableArray array];
        self.dataArray = [NSMutableArray array];
//        [self PostUI1:@"1"];
        //        @property (strong, nonatomic)  NSString *imgVStr;
        //        @property (strong, nonatomic)  NSString *titleLStr;
        //        @property (strong, nonatomic)  NSString *fuLStr;
        //        @property (strong, nonatomic)  NSString *loacLStr;
        //        @property (strong, nonatomic)  NSString *moneyLStr;
        //        @property (strong, nonatomic)  NSString *delBtStr;
        //        @property (strong, nonatomic)  NSString *neBtnStr;
//        NSDictionary *dic = @{@"imgVStr":@"aaa",@"titleLStr":@"北京有限公司",@"fuLStr":@"出售",@"loacLStr":@"朝阳",@"moneyLStr":@"1000～3000"};
//        self.array = [NSMutableArray arrayWithObjects: dic,dic,dic,dic,dic, nil];
//        for (int i = 0; i < _array.count; i++) {
//            NSDictionary *dict = self.array[i];
//            SaleModel *model = [[SaleModel alloc]init];
//            [model setValuesForKeysWithDictionary:dict];
//            [self.dataArray addObject:model];
//        }
        
        
        [self addSubview:self.tableView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    [self PostUI1:@"0"];

}

- (void)PostUI1:(NSString*)b {
//    NSMutableDictionary* dic=[NSMutableDictionary new];
//    ETProductModel *p=[_products objectAtIndex:0];
    NSString* touid=[MySingleton sharedMySingleton].toUserid;
    NSDictionary *params = @{
                             @"releaseTypeId" :@(1),
                             @"userId":@([touid longLongValue])
                             };
    [HttpTool get:[NSString stringWithFormat:@"release/userOrders"] params:params success:^(id responseObj) {
        _dataArray=[NSMutableArray new];
        NSDictionary* a=responseObj[@"data"];
//        for (NSDictionary* prod in responseObj[@"data"]) {
//            ETProductModel* p=[ETProductModel mj_objectWithKeyValues:prod];
//            [_dataArray addObject:p];
//        }
//        //        NSLog(@"");
//        [_tableView reloadData];
        
        if (responseObj && [responseObj isKindOfClass:[NSDictionary class]]) {
            NSArray *array = responseObj[@"data"];
            if(array && ![array isKindOfClass:[NSNull class]]){
                [_dataArray addObjectsFromArray:array];
                [_tableView reloadData];
            }
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight=124;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableView registerNib:[UINib nibWithNibName:@"UserSaleViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
        
    }
    return _tableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    UserSaleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
//    SaleModel *model = self.dataArray[indexPath.row];
//    [cell.delBt addTarget:self action:@selector(onTouchBtnInCell:) forControlEvents:(UIControlEventTouchUpInside)];
//    [cell.neBtn addTarget:self action:@selector(onTouchBtnIn:) forControlEvents:UIControlEventTouchUpInside];
//    [cell setSaleModel:model];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    return cell;
    ETUserListCell* cell=[ETUserListCell dynamicListCell:tableView dict:_dataArray[indexPath.row]];
    _refchBtn =[[UIButton alloc]init];
    [_refchBtn setTitle:@"查看" forState:UIControlStateNormal];
    _refchBtn.backgroundColor=kACColorBlue_Theme;
    _refchBtn.tag=indexPath.row;
    [_refchBtn addTarget:self action:@selector(viewdetail:) forControlEvents:UIControlEventTouchUpInside];
    //    [_refchBtn setTitle:@"查看" forState:UIControlStateNormal];
    [cell addSubview:self.refchBtn];
    _refchBtn.layer.borderWidth=1;
    _refchBtn.layer.cornerRadius=4;
    _refchBtn.titleLabel.font=[UIFont systemFontOfSize:13 weight:9];
    _refchBtn.layer.borderColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0].CGColor;
    [_refchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(120);
        make.right.mas_equalTo(-34);
        make.size.mas_equalTo(CGSizeMake(60, 26));
    }];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict =[self.dataArray objectAtIndex:indexPath.row];
    ETProductModel* p=[ETProductModel mj_objectWithKeyValues:dict];
    //    ETCartViewController* pur=[ETCartViewController new];
    
    //    ETPoctoryqgViewController* pur=[ETPoctoryqgViewController new];
    //    ETPoctoryqgServiceViewController* pur=[ETPoctoryqgServiceViewController new];
    if ([p.tradStatus isEqualToString:@"5"]) {
        ETBuyFinishViewController* f=[ETBuyFinishViewController new];
        f.product=p;
        [self.owner.navigationController pushViewController:f animated:YES];
    }
    else{
        if ([p.releaseTypeId isEqualToString:@"3"]) {
            ETServiceDetailController * detail=[ETServiceDetailController serviceDetailController:dict];
            detail.product=p;
            [self.owner.navigationController pushViewController:detail animated:YES];
        }
        else if ([p.releaseTypeId isEqualToString:@"1"]){
            ETSaleDetailController* detail=[ETSaleDetailController saleDetailController:dict];
            detail.product=p;
            [self.owner.navigationController pushViewController:detail animated:YES];
        }
        else{
        ETForBuyDetailController* pur=[ETForBuyDetailController forBuyDetailController:dict];
        pur.releaseId=p.releaseId;
        pur.releaseId = dict[@"releaseId"];
        pur.product = [ETProductModel mj_objectWithKeyValues:dict];
        [self.owner.navigationController pushViewController:pur animated:YES];
        }
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}
-(void)viewdetail:(UIButton*)sender{
    NSDictionary *dict =[self.dataArray objectAtIndex:sender.tag];
    ETProductModel* p=[ETProductModel mj_objectWithKeyValues:dict];
    if ([p.tradStatus isEqualToString:@"5"]) {
        ETBuyFinishViewController* f=[ETBuyFinishViewController new];
        f.product=p;
        [self.owner.navigationController pushViewController:f animated:YES];
    }
    else{
        if ([p.releaseTypeId isEqualToString:@"3"]) {
            ETServiceDetailController * detail=[ETServiceDetailController serviceDetailController:dict];
            detail.product=p;
            [self.owner.navigationController pushViewController:detail animated:YES];
        }
        else if ([p.releaseTypeId isEqualToString:@"1"]){
            ETSaleDetailController* detail=[ETSaleDetailController saleDetailController:dict];
            detail.product=p;
            [self.owner.navigationController pushViewController:detail animated:YES];
        }
        else{
            ETForBuyDetailController* pur=[ETForBuyDetailController forBuyDetailController:dict];
            pur.releaseId=p.releaseId;
            pur.releaseId = dict[@"releaseId"];
            pur.product = [ETProductModel mj_objectWithKeyValues:dict];
            [self.owner.navigationController pushViewController:pur animated:YES];
        }
    }
}
//删除按钮
- (void)onTouchBtnInCell:(UIButton *)sender {
    CGPoint point = sender.center;
    point = [self.tableView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [self.tableView indexPathForRowAtPoint:point];
    NSLog(@"%ld",(long)indexpath.row);
}
//刷新按钮
- (void)onTouchBtnIn:(UIButton *)sender {
    CGPoint point = sender.center;
    point = [self.tableView convertPoint:point fromView:sender.superview];
    NSIndexPath* indexpath = [self.tableView indexPathForRowAtPoint:point];
    NSLog(@"%ld",(long)indexpath.row);
}
@end
