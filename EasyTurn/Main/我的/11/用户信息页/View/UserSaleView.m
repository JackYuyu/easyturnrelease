

#import "UserSaleView.h"
#import "UserSaleViewCell.h"
#import "SaleModel.h"
@interface UserSaleView()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic , strong)NSMutableArray *array;
@property(nonatomic , strong)NSMutableArray *dataArray;
@end
@implementation UserSaleView
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.array = [NSMutableArray array];
        self.dataArray = [NSMutableArray array];
//        @property (strong, nonatomic)  NSString *imgVStr;
//        @property (strong, nonatomic)  NSString *titleLStr;
//        @property (strong, nonatomic)  NSString *fuLStr;
//        @property (strong, nonatomic)  NSString *loacLStr;
//        @property (strong, nonatomic)  NSString *moneyLStr;
//        @property (strong, nonatomic)  NSString *delBtStr;
//        @property (strong, nonatomic)  NSString *neBtnStr;
        NSDictionary *dic = @{@"imgVStr":@"aaa",@"titleLStr":@"北京有限公司",@"fuLStr":@"出售",@"loacLStr":@"朝阳",@"moneyLStr":@"1000～3000"};
        self.array = [NSMutableArray arrayWithObjects: dic,dic,dic,dic,dic, nil];
        for (int i = 0; i < _array.count; i++) {
            NSDictionary *dict = self.array[i];
            SaleModel *model = [[SaleModel alloc]init];
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray addObject:model];
        }

        
        [self addSubview:self.tableView];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];


}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight=158;
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
    UserSaleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    SaleModel *model = self.dataArray[indexPath.row];
    [cell.delBt addTarget:self action:@selector(onTouchBtnInCell:) forControlEvents:(UIControlEventTouchUpInside)];
    [cell.neBtn addTarget:self action:@selector(onTouchBtnIn:) forControlEvents:UIControlEventTouchUpInside];
    [cell setSaleModel:model];
    return cell;
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
