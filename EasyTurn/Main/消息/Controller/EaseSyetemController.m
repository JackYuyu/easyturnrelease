//
//  EaseSyetemController.m
//  AFNetworking
//
//  Created by 程立 on 2019/8/17.
//

#import "EaseSyetemController.h"
#import "EaseMessageModel.h"
@interface EaseSyetemController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *tab;
@property (nonatomic,strong) NSArray *list;
@property (nonatomic,strong) UIView *navigationView;
@property (nonatomic,strong) UIButton *leftButton;

@end

@implementation EaseSyetemController
- (UITableView *)tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, TopHeight, [[UIScreen mainScreen]bounds].size.width, Screen_Height) style:UITableViewStylePlain];
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.bounces=NO;
        _tab.rowHeight=60;
        _tab.showsVerticalScrollIndicator = NO;
        _tab.tableFooterView = [[UIView alloc]init];
    }
    return _tab;
}
-(void)viewWillAppear:(BOOL)animated
{
    _list=[EaseMessageModel bg_findAll:@"EaseMessageModel"];
    [super.navigationController setNavigationBarHidden:NO animated:TRUE];
    [_tab reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:NO animated:TRUE];    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"易转官方消息";
    self.view.backgroundColor=[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self.view addSubview:self.tab];
    
//    _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, TopHeight)];
//    _navigationView.backgroundColor = kACColorClear;
//    [self.navigationController.view addSubview:_navigationView];
//    _leftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    _leftButton.frame = CGRectMake(15, StatusBarHeight, 55, 45);
//    //    [_leftButton setBackgroundColor:[UIColor blueColor]];
//    [_leftButton setImage:[UIImage imageNamed:@"navigation_back_hl"] forState:(UIControlStateNormal)];
//    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(7, StatusBarHeight+7, 44, 44);
//    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateNormal];
//    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateHighlighted];
//    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateSelected];
//    _leftButton=btn;
//    [_leftButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
//    [_navigationView addSubview:_leftButton];
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!_list) {
        return 1;
    }
    else
        return _list.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 64;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray*arr=@[@"姓名",@"支付宝账号"];
    EaseMessageModel* m=[_list objectAtIndex:indexPath.row];
    cell.imageView.image=[UIImage imageNamed:@"dropdown_loading_01"];
    if (m.address)
    {
        cell.textLabel.text=m.address;
        if (_index==0) {
            cell.textLabel.text=@"很高兴为你服务!!";
        }
    }
    else
    {
        if (_index==0) {
            cell.textLabel.text=@"很高兴为你服务!!";
        }
        else{
        cell.textLabel.text=@"欢迎来到易转!";
        }
    }
//    cell.detailTextLabel.text=m.address;
    [cell.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(30);
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(cell.contentView);
    }];
//    if (indexPath.row==0) {
//        _nameText=[[UITextField alloc]init];
//        _nameText.placeholder=@"请输入您的真实姓名";
//        _nameText.font=[UIFont systemFontOfSize:13];
//        [cell addSubview:self.nameText];
//        [_nameText mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(20);
//            make.left.mas_equalTo(113);
//            make.size.mas_equalTo(CGSizeMake(120, 21));
//        }];
//    }else if (indexPath.row==1) {
//
//        _alipayText=[[UITextField alloc]init];
//        _alipayText.font=[UIFont systemFontOfSize:13];
//        _alipayText.placeholder=@"请输入您本人的支付宝账号";
//        [cell addSubview:self.alipayText];
//        [_alipayText mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(20);
//            make.left.mas_equalTo(113);
//            make.size.mas_equalTo(CGSizeMake(160, 21));
//        }];
//    }
    return cell;
}

@end
