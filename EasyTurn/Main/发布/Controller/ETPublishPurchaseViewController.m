//
//  ETPublishPurchaseViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/30.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETPublishPurchaseViewController.h"
#import "YHDetailsTabController.h"
#import "YHSegmentView.h"
#import "PopView.h"
#import "PopTableListView.h"
#import "LQCityPicker.h"
#import "LQPickerView.h"
#import "LZCPickerView.h"

@interface ETPublishPurchaseViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,PopTableListViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UISegmentedControl *segment;

@property (nonatomic,strong)UITextField *titleText;
@property (nonatomic,strong)UITextView *detailText;
@property (nonatomic,strong)UITextField *titleText1;
@property (nonatomic,strong)UITextView *detailText1;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UIView *effectiveTimeView;
@property (nonatomic,strong)UIView *effectiveTimeView1;
@property (nonatomic,strong)UILabel *effectiveTimeLabel;
@property (nonatomic,strong)UILabel *effectiveTimeLabel1;
@property (nonatomic,strong)UITextField *priceRangeLeftText;
@property (nonatomic,strong)UITextField *priceRangeRightText;
@property (nonatomic,strong)UIView *priceRangeLeftView;
@property (nonatomic,strong)UIView *priceRangeRightView;
@property (nonatomic,strong)UITextField *priceRangeLeftText1;
@property (nonatomic,strong)UITextField *priceRangeRightText1;
@property (nonatomic,strong)UIView *priceRangeLeftView1;
@property (nonatomic,strong)UIView *priceRangeRightView1;
@property (nonatomic,strong)UISwitch *serviceSwitch;
@property (nonatomic,strong)UISwitch *companySwitch;
@property (nonatomic,strong)UISwitch *serviceSwitch1;
@property (nonatomic,strong)UISwitch *companySwitch1;
@property (nonatomic,strong)UITextField *contactText;
@property (nonatomic,strong)UITextField *phoneText;
@property (nonatomic,strong)UITextField *contactText1;
@property (nonatomic,strong)UITextField *phoneText1;
@property (nonatomic ,strong)PopTableListView *popEffectiveTimeListView;
@property (nonatomic ,strong)PopTableListView *popEffectiveTimeListView1;
@property (nonatomic ,strong)PopTableListView *popListView;
@property (nonatomic ,strong)PopTableListView *popListView1;
@property (nonatomic,strong)UIButton *publishBtn;
@property (nonatomic,strong)UIButton *publishBtn1;
@property (nonatomic,strong)UILabel *serviceTypeLabel;
@property (nonatomic,strong)UIButton *serviceTypeBtn;
@property (nonatomic,strong)UILabel *serviceTypeLabel1;
@property (nonatomic,strong)UIButton *serviceTypeBtn1;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic,strong)UIView *headerView;
@property (nonatomic, strong) UIImage *photoImg;
@property (nonatomic, copy) NSString *photoUrl;
@property (nonatomic, assign) int serviceid;
@property (nonatomic, assign) int swith;
@property (nonatomic, assign) int swith1;


@property (nonatomic,strong) UIView * maskTheView;
@property (nonatomic,strong) UIView * shareView;
@property (nonatomic,strong)UILabel *lab1;
@property (nonatomic, assign) int myindex;
@property (nonatomic,strong)UIButton *surebtn;
@property (nonatomic,assign) BOOL chooseClassify1;
@property (nonatomic,strong)UIButton *leftButton;
@end

@implementation ETPublishPurchaseViewController
- (UIView *)maskTheView{
    if (!_maskTheView) {
        _maskTheView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _maskTheView.backgroundColor = [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:0.5];
        //添加一个点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(maskClickGesture)];
        [_maskTheView addGestureRecognizer:tap];//让header去检测点击手势
    }
    return _maskTheView;
}

- (void)maskClickGesture {
    [self.maskTheView removeFromSuperview];
    [self.shareView removeFromSuperview];
    
}

- (UIView *)shareView{
    if (!_shareView) {
        _shareView = [[UIView alloc]initWithFrame:CGRectMake(30, Screen_Height/2-100, Screen_Width-60,200)];
        //        _shareView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
        _shareView.layer.cornerRadius=20;
        _shareView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        
    }
    return _shareView;
}
//添加提示框
- (void)shareViewController {
    UIImageView *returnImage=[[UIImageView alloc]initWithFrame:CGRectMake(20, 23, 50, 50)];
    returnImage.image=[UIImage imageNamed:@"dropdown_loading_01"];
    returnImage.userInteractionEnabled = YES;
    [_shareView addSubview:returnImage];
    
    UILabel *lab=[[UILabel alloc]initWithFrame:CGRectMake(80, 25, Screen_Width, 45)];
    lab.text=@"确认发布";
    lab.textColor=[UIColor blackColor];
    lab.font =[UIFont systemFontOfSize:20];
    [_shareView addSubview:lab];
    
    _lab1=[[UILabel alloc]initWithFrame:CGRectMake(20, 75, Screen_Width-90, 70)];
    
    _lab1.numberOfLines=0;
    _lab1.textColor=[UIColor blackColor];
    _lab1.font =[UIFont systemFontOfSize:14];
    [_shareView addSubview:_lab1];
    
    UIButton *returnbtn =[[UIButton alloc]initWithFrame:CGRectMake(_shareView.size.width-150, 155, 50, 21)];
    [returnbtn setTitle:@"关闭" forState:UIControlStateNormal];
    returnbtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [returnbtn addTarget:self action:@selector(clickImage) forControlEvents:UIControlEventTouchUpInside];
    [returnbtn setTitleColor:[UIColor colorWithRed:243/255.0 green:22/255.0 blue:22/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_shareView addSubview:returnbtn];
    
    UIButton *surebtn =[[UIButton alloc]initWithFrame:CGRectMake(_shareView.size.width-100, 155, 50, 21)];
    [surebtn setTitle:@"确定" forState:UIControlStateNormal];
    surebtn.titleLabel.font=[UIFont systemFontOfSize:15];
    [surebtn setTitleColor:[UIColor colorWithRed:243/255.0 green:22/255.0 blue:22/255.0 alpha:1.0] forState:UIControlStateNormal];
    [surebtn addTarget:self action:@selector(PostUI) forControlEvents:UIControlEventTouchUpInside];
    _surebtn=surebtn;
    [_shareView addSubview:surebtn];
    
}

- (void)clickImage {
    [self.maskTheView removeFromSuperview];
    [self.shareView removeFromSuperview];
}
- (NSMutableArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray arrayWithCapacity:0];
    }
    
    return _dataSource;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *retView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,Screen_Width,kNavBarHeight_StateBarH)];
    retView.backgroundColor = kACColorBlue_Theme;
    [self.navigationController.view addSubview:retView];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(7, StatusBarHeight+7, 44, 44);
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateSelected];
    _leftButton=btn;
    [_leftButton addTarget:self action:@selector(cancelClick) forControlEvents:(UIControlEventTouchUpInside)];
    [retView addSubview:_leftButton];
    
    UILabel *headtitle=[[UILabel alloc]initWithFrame:CGRectMake(Screen_Width/2-36, 30, 72, 25)];
    headtitle.textColor=kACColorWhite;
    headtitle.text=@"发布求购";
    [retView addSubview:headtitle];
    
    self.title=@"发布求购";
    [self enableLeftBackWhiteButton];
    self.view.backgroundColor=[UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    [self loadAddressData];
    
    
    //添加取消按钮->
//    [self addCancelBtn];
    
    [self setUI];
    _swith=0;
    _swith1=0;
    
    [self shareView];
    [self shareViewController];
}

- (void)loadAddressData{
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Address" ofType:@"plist"];
    
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:path];
    
    NSArray *provinces = [dic allKeys];
    
    for (NSString *tmp in provinces) {
        
        // 创建第一级数据
        LQPickerItem *item1 = [[LQPickerItem alloc]init];
        item1.name = tmp;
        
        NSArray *arr = [dic objectForKey:tmp];
        NSDictionary *cityDic = [arr firstObject];
        
        NSArray *keys = cityDic.allKeys;
        // 配置第二级数据
        [item1 loadData:keys.count config:^(LQPickerItem *item, NSInteger index) {
            
            item.name = keys[index];
            NSArray *area = [cityDic objectForKey:item.name];
            //            // 配置第三极数据
            //            [item loadData:area.count config:^(LQPickerItem *item, NSInteger index) {
            //                item.name = area[index];
            //            }];
        }];
        
        [self.dataSource addObject:item1];
    }
}

//添加取消按钮->
-(void)addCancelBtn{
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_leftBack"] style:UIBarButtonItemStylePlain target:self action:@selector(cancelClick)];
    self.navigationItem.leftBarButtonItem = backBtn;
}

- (void)setUI{
    
    [self.view addSubview:self.tableView];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = NO;
    } else {
        // Fallback on earlier versions
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.segment.selectedSegmentIndex == 0) {
        return 4;
    }
    return 3;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.segment.selectedSegmentIndex == 0) {
        if (section==0) {
            return 2;
        }else if (section==1) {
            return 1;
        }else if (section==2) {
            return 1;
        }else {
            return 3;
        }
    }else{
        if (section==0) {
            if (_chooseClassify1) {
                return 8;
            }
            else{
            return 5;
            }
        }else if (section==1) {
            return 2;
        }else {
            return 3;
        }
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.segment.selectedSegmentIndex == 0) {
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                return 60;
            }else {
                return 110;
            }
        }else if (indexPath.section==1) {
            if (indexPath.row==0) {
                return 50;
            }else if (indexPath.row==1) {
                return 70;
            }else{
                return 70;
            }
        }else if (indexPath.section==2) {
            return 60;
        }else {
            if (indexPath.row==0) {
                return 50;
            }else if (indexPath.row==1) {
                return 50;
            }else {
                return 100;
            }
        }
    }else{
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                return 60;
            }else if (indexPath.row==1) {
                return 110;
            }else if (indexPath.row==6&&_chooseClassify1){
                return 300;
            }
            else{
                return 60;
            }
        }else if (indexPath.section==1) {
            
            return 50;
            
        }else {
            if (indexPath.row==0) {
                return 50;
            }else if (indexPath.row==1) {
                return 50;
            }else {
                return 100;
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.segment.selectedSegmentIndex == 0) {
        UITableViewCell* cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                UILabel *titlelab=[[UILabel alloc]init];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"标题："attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
                
                [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.000000]} range:NSMakeRange(0, 3)];
                
                [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.000000]} range:NSMakeRange(0, 3)];
                
                titlelab.attributedText = string;
                titlelab.textAlignment = NSTextAlignmentLeft;
                titlelab.alpha = 1.0;
                [cell addSubview:titlelab];
                
                [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(60, 60));
                }];
                
                [cell.contentView addSubview:self.titleText];
                
            }else if (indexPath.row==1) {
                UILabel *titlelab=[[UILabel alloc]init];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"详细内容："attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
                
                
                titlelab.attributedText = string;
                titlelab.textAlignment = NSTextAlignmentLeft;
                titlelab.alpha = 1.0;
                [cell addSubview:titlelab];
                
                [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(20);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(76, 22));
                }];
                
                [cell.contentView addSubview:self.detailText];
            }
        }else if (indexPath.section==1) {
            
            if (indexPath.row == 0) {
                UILabel *titlelab=[[UILabel alloc]init];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"求购区域"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                titlelab.attributedText = string;
                titlelab.textAlignment = NSTextAlignmentLeft;
                titlelab.alpha = 1.0;
                [cell addSubview:titlelab];
                
                [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(76, 50));
                }];
                
                [cell.contentView addSubview:self.addressLabel];
                
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                
            }
            else if (indexPath.row == 1){
                UILabel *titlelab=[[UILabel alloc]init];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"有效时间"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                titlelab.attributedText = string;
                titlelab.textAlignment = NSTextAlignmentLeft;
                titlelab.alpha = 1.0;
                titlelab.text=@"1";
                [cell addSubview:titlelab];
                
                [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(76, 60));
                }];
                
                [cell.contentView addSubview:self.effectiveTimeView];
            }
            //            else{
            //                UILabel *titlelab=[[UILabel alloc]init];
            //                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"价格范围"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
            //                titlelab.attributedText = string;
            //                titlelab.textAlignment = NSTextAlignmentLeft;
            //                titlelab.alpha = 1.0;
            //                [cell addSubview:titlelab];
            //
            //                [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
            //                    make.top.mas_equalTo(0);
            //                    make.left.mas_equalTo(15);
            //                    make.size.mas_equalTo(CGSizeMake(62, 60));
            //                }];
            //
            //                [cell.contentView addSubview:self.priceRangeLeftView];
            //
            //                UILabel *symbol = [[UILabel alloc]initWithFrame:CGRectMake(90+80, 31, 40, 6)];
            //                symbol.text = @"~";
            //                symbol.textColor = RGBACOLOR(180, 180, 180, 1);
            //                symbol.textAlignment = NSTextAlignmentCenter;
            //                [cell.contentView addSubview:symbol];
            //
            //                [cell.contentView addSubview:self.priceRangeRightView];
            //            }
            
        }else if (indexPath.section==2) {
            if (indexPath.row==0) {
                UILabel *titlelab=[[UILabel alloc]init];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"精准推送平台企服者"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                
                
                titlelab.attributedText = string;
                titlelab.textAlignment = NSTextAlignmentLeft;
                titlelab.alpha = 1.0;
                [cell addSubview:titlelab];
                
                [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(150, 30));
                }];
                [cell.contentView addSubview:self.companySwitch];
                cell.detailTextLabel.text=@"(平台精准推送一次消耗10次刷新次数)";
                [cell.detailTextLabel setTextColor:kACColorRed];
                [cell.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(0);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(220, 20));
                }];
                
            }
        } else if (indexPath.section==3) {
            if (indexPath.row==0) {
                UILabel *titlelab=[[UILabel alloc]init];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"联系人"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                titlelab.attributedText = string;
                titlelab.textAlignment = NSTextAlignmentLeft;
                titlelab.alpha = 1.0;
                [cell addSubview:titlelab];
                
                [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(46, 50));
                }];
                
                [cell.contentView addSubview:self.contactText];
                
            }else if (indexPath.row==1) {
                UILabel *titlelab=[[UILabel alloc]init];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"联系电话"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                titlelab.attributedText = string;
                titlelab.textAlignment = NSTextAlignmentLeft;
                titlelab.alpha = 1.0;
                [cell addSubview:titlelab];
                
                [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(62, 50));
                }];
                
                [cell.contentView addSubview:self.phoneText];
                
            }else if (indexPath.row==2) {
                
                [cell.contentView addSubview:self.publishBtn];
            }
        }
        
        return cell;
        
    }else{
        UITableViewCell* cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        if (indexPath.section==0) {
            if (indexPath.row==0) {
                UILabel *titlelab=[[UILabel alloc]init];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"标题："attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Medium" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
                
                [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.000000]} range:NSMakeRange(0, 3)];
                
                [string addAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.000000]} range:NSMakeRange(0, 3)];
                
                titlelab.attributedText = string;
                titlelab.textAlignment = NSTextAlignmentLeft;
                titlelab.alpha = 1.0;
                [cell addSubview:titlelab];
                
                [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(60, 60));
                }];
                
                [cell.contentView addSubview:self.titleText1];
                
            }else if (indexPath.row==1) {
                UILabel *titlelab=[[UILabel alloc]init];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"详细内容："attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
                
                
                titlelab.attributedText = string;
                titlelab.textAlignment = NSTextAlignmentLeft;
                titlelab.alpha = 1.0;
                [cell addSubview:titlelab];
                
                [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(20);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(76, 22));
                }];
                
                [cell.contentView addSubview:self.detailText1];
            }else if (indexPath.row == 2){
                UILabel *titlelab=[[UILabel alloc]init];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"服务种类"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                
                
                titlelab.attributedText = string;
                titlelab.textAlignment = NSTextAlignmentLeft;
                titlelab.alpha = 1.0;
                [cell.contentView addSubview:titlelab];
                
                [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(76, 60));
                }];
                
                [cell.contentView addSubview:self.serviceTypeLabel];
                [cell.contentView addSubview:self.serviceTypeBtn];
                
            }else if (indexPath.row == 3){
                UILabel *titlelab=[[UILabel alloc]init];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"求购事项"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                
                
                titlelab.attributedText = string;
                titlelab.textAlignment = NSTextAlignmentLeft;
                titlelab.alpha = 1.0;
                [cell.contentView addSubview:titlelab];
                
                [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(76, 60));
                }];
                
                [cell.contentView addSubview:self.serviceTypeLabel1];
                [cell.contentView addSubview:self.serviceTypeBtn1];
                
            }
//            else if (indexPath.row == 4) {
//                UILabel *titlelab=[[UILabel alloc]init];
//                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"求购区域"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
//                titlelab.attributedText = string;
//                titlelab.textAlignment = NSTextAlignmentLeft;
//                titlelab.alpha = 1.0;
//                [cell addSubview:titlelab];
//
//                [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
//                    make.top.mas_equalTo(0);
//                    make.left.mas_equalTo(15);
//                    make.size.mas_equalTo(CGSizeMake(76, 50));
//                }];
//
//                [cell.contentView addSubview:self.addressLabel];
//
//                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
//
//            }
            else if (indexPath.row == 4){
                UILabel *titlelab=[[UILabel alloc]init];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"有效时间"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                titlelab.attributedText = string;
                titlelab.textAlignment = NSTextAlignmentLeft;
                titlelab.alpha = 1.0;
                titlelab.text=@"1";
                [cell addSubview:titlelab];
                
                [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(76, 60));
                }];
                
                [cell.contentView addSubview:self.effectiveTimeView1];
            }
            else{
                UILabel *titlelab=[[UILabel alloc]init];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"有效时间"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                titlelab.attributedText = string;
                titlelab.textAlignment = NSTextAlignmentLeft;
                titlelab.alpha = 1.0;
                titlelab.text=@"有效时间";
                [cell addSubview:titlelab];
                
                [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(76, 60));
                }];
                
                [cell.contentView addSubview:self.effectiveTimeView1];
            }
        }else if (indexPath.section==1) {
            if (indexPath.row == 0) {
                UILabel *titlelab=[[UILabel alloc]init];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"求购区域"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                titlelab.attributedText = string;
                titlelab.textAlignment = NSTextAlignmentLeft;
                titlelab.alpha = 1.0;
                [cell addSubview:titlelab];
                
                [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(76, 50));
                }];
                
                [cell.contentView addSubview:self.addressLabel];
                
                cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
                
            }else if (indexPath.row==1) {
                UILabel *titlelab=[[UILabel alloc]init];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"精准推送平台企服者"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                
                
                titlelab.attributedText = string;
                titlelab.textAlignment = NSTextAlignmentLeft;
                titlelab.alpha = 1.0;
                [cell addSubview:titlelab];
                
                [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(150, 50));
                }];
                
                [cell.contentView addSubview:self.companySwitch1];
                cell.detailTextLabel.text=@"(平台精准推送一次消耗10次刷新次数)";
                [cell.detailTextLabel setTextColor:kACColorRed];
                [cell.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_equalTo(0);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(220, 20));
                }];
                
            }
        } else if (indexPath.section==2) {
            if (indexPath.row==0) {
                UILabel *titlelab=[[UILabel alloc]init];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"联系人"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                titlelab.attributedText = string;
                titlelab.textAlignment = NSTextAlignmentLeft;
                titlelab.alpha = 1.0;
                [cell addSubview:titlelab];
                
                [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(46, 50));
                }];
                
                [cell.contentView addSubview:self.contactText1];
                
            }else if (indexPath.row==1) {
                UILabel *titlelab=[[UILabel alloc]init];
                NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"联系电话"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
                titlelab.attributedText = string;
                titlelab.textAlignment = NSTextAlignmentLeft;
                titlelab.alpha = 1.0;
                [cell addSubview:titlelab];
                
                [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.mas_equalTo(0);
                    make.left.mas_equalTo(15);
                    make.size.mas_equalTo(CGSizeMake(62, 50));
                }];
                
                [cell.contentView addSubview:self.phoneText1];
                
            }else if (indexPath.row==2) {
                
                [cell.contentView addSubview:self.publishBtn1];
            }
        }
        
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.segment.selectedSegmentIndex == 0) {
#pragma mark - 地址定位
        if (indexPath.section == 1 && indexPath.row == 0) {
            __weak typeof(self)ws = self;
            [LQCityPicker showInView:self.view datas:self.dataSource didSelectWithBlock:^(NSArray *objs, NSString *dsc) {
                NSLog(@"%@\n%@", objs, dsc);
                ws.addressLabel.text = dsc;
            } cancelBlock:^{
                NSLog(@"cancel");
            }];
        }
    }
    if (self.segment.selectedSegmentIndex != 0) {
        if (indexPath.section==0) {
            if (indexPath.row==4) {
                __weak typeof(self)ws = self;
                [LQCityPicker showInView:self.view datas:self.dataSource didSelectWithBlock:^(NSArray *objs, NSString *dsc) {
                    NSLog(@"%@\n%@", objs, dsc);
                    ws.addressLabel.text = dsc;
                } cancelBlock:^{
                    NSLog(@"cancel");
                }];
                
            }
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//取消按钮点击方法
-(void)cancelClick{
    [self finishPublish];
}

#pragma mark - 完成发布
//完成发布
-(void)finishPublish{
    //2.block传值
    if (self.mDismissBlock != nil) {
        self.mDismissBlock();
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    if (_product) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

//block声明方法
-(void)toDissmissSelf:(dismissBlock)block{
    self.mDismissBlock = block;
}

- (UISegmentedControl *)segment{
    if(!_segment){
        NSMutableArray *array = [NSMutableArray arrayWithObjects:@"企业流转",@"企业服务", nil];
        _segment = [[UISegmentedControl alloc] initWithItems:array];
        
        _segment.frame = CGRectMake(Screen_Width/4, 10, Screen_Width/2, 40);
        _segment.layer.cornerRadius = 10;
        _segment.layer.masksToBounds = YES;
        
        _segment.selectedSegmentIndex = 0;
        if (_product) {
            if (_product.serviceId) {
                _segment.selectedSegmentIndex = 1;
            }
        }
        _segment.tintColor = [UIColor clearColor];
        NSDictionary *selectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                 NSForegroundColorAttributeName:[UIColor whiteColor]};
        //设置文字属性
        [_segment setTitleTextAttributes:selectedTextAttributes forState:UIControlStateSelected];
        NSDictionary* unselectedTextAttributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17],
                                                   NSForegroundColorAttributeName:RGBCOLOR(0.21*255, 0.54*255, 0.97*255)};
        [_segment setTitleTextAttributes:unselectedTextAttributes forState:UIControlStateNormal];
        
        [_segment setBackgroundImage:[PublicFunc imageWithColor:[UIColor whiteColor]]
                            forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        
        [_segment setBackgroundImage:[PublicFunc imageWithColor:RGBCOLOR(0.21*255, 0.54*255, 0.97*255)]
                            forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        
        [_segment addTarget:self action:@selector(topSegmentChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _segment;
}

#pragma mark 分段控件点击事件
- (void)topSegmentChanged:(UISegmentedControl *)sender{
    
    [self.tableView reloadData];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, self.view.height) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.bounces=NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.sectionFooterHeight = 0;
        _tableView.sectionHeaderHeight = 10;
    }
    return _tableView;
}

- (UITextField *)titleText{
    if (!_titleText) {
        _titleText = [[UITextField alloc]initWithFrame:CGRectMake(65, 0, Screen_Width-80, 60)];
        _titleText.font = [UIFont systemFontOfSize:15];
        _titleText.placeholder = @"请输入您要发布的标题(公司名称、商品类型)";
        if (_product) {
            _titleText.text=_product.title;
        }
    }
    return _titleText;
}

- (UITextField *)titleText1{
    if (!_titleText1) {
        _titleText1 = [[UITextField alloc]initWithFrame:CGRectMake(65, 0, Screen_Width-80, 60)];
        _titleText1.font = [UIFont systemFontOfSize:15];
        _titleText1.placeholder = @"请输入您要发布的标题(公司名称、商品类型)";
        if (_product) {
            _titleText1.text=_product.title;
        }
    }
    return _titleText1;
}

- (UITextView *)detailText{
    if (!_detailText) {
        _detailText = [[UITextView alloc]initWithFrame:CGRectMake(90, 15, Screen_Width-110, 80)];
        _detailText.font = [UIFont systemFontOfSize:15];
        _detailText.textColor = RGBACOLOR(100, 100, 100, 1);
        // _placeholderLabel
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = @"请在这里输入求购详细需求";
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor = RGBACOLOR(200, 200, 200, 1);
        [placeHolderLabel sizeToFit];
        [_detailText addSubview:placeHolderLabel];
        
        placeHolderLabel.font = [UIFont systemFontOfSize:15];
        [_detailText setValue:placeHolderLabel forKey:@"_placeholderLabel"];
        if (_product) {
            _detailText.text=_product.detail;
        }
        
    }
    return _detailText;
}

- (UITextView *)detailText1{
    if (!_detailText1) {
        _detailText1 = [[UITextView alloc]initWithFrame:CGRectMake(90, 15, Screen_Width-110, 80)];
        _detailText1.font = [UIFont systemFontOfSize:15];
        _detailText1.textColor = RGBACOLOR(100, 100, 100, 1);
        // _placeholderLabel
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = @"请在这里输入求购详细需求";
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor = RGBACOLOR(200, 200, 200, 1);
        [placeHolderLabel sizeToFit];
        [_detailText1 addSubview:placeHolderLabel];
        
        placeHolderLabel.font = [UIFont systemFontOfSize:15];
        [_detailText1 setValue:placeHolderLabel forKey:@"_placeholderLabel"];
        if (_product) {
            _detailText1.text=_product.detail;
        }
        
    }
    return _detailText1;
}

- (UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 0, Screen_Width-150, 60)];
        _addressLabel.textColor = RGBACOLOR(100, 100, 100, 1);
        _addressLabel.font = [UIFont systemFontOfSize:15];
        if (_product) {
            _addressLabel.text=_product.cityName;
        }
    }
    return _addressLabel;
}

- (UIView *)effectiveTimeView{
    if (!_effectiveTimeView) {
        _effectiveTimeView = [[UIView alloc]initWithFrame:CGRectMake(90, 15, 80, 30)];
        _effectiveTimeView.backgroundColor = RGBCOLOR(0.95*255, 0.95*255, 0.95*255);
        _effectiveTimeView.layer.cornerRadius = 2;
        _effectiveTimeView.layer.masksToBounds = YES;
        _effectiveTimeView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(effectiveTime)];
        [_effectiveTimeView addGestureRecognizer:tap];
        
        [_effectiveTimeView addSubview:self.effectiveTimeLabel];
        UIImageView *downImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 10, 12, 8)];
        downImageView.image = [UIImage imageNamed:@"出售_下拉 copy"];
        [_effectiveTimeView addSubview:downImageView];
    }
    return _effectiveTimeView;
}

- (UILabel *)effectiveTimeLabel{
    if (!_effectiveTimeLabel) {
        _effectiveTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        _effectiveTimeLabel.textAlignment = NSTextAlignmentCenter;
        _effectiveTimeLabel.font = [UIFont systemFontOfSize:15];
        self.effectiveTimeLabel.text=@"7天";
    }
    return _effectiveTimeLabel;
}

#pragma mark - 有效时间
- (void)effectiveTime{
    PopView *popView = [PopView popUpContentView:self.popEffectiveTimeListView direct:PopViewDirection_PopUpBottom onView:self.effectiveTimeView];
    popView.backgroundColor = [UIColor clearColor];
}

//- (UIView *)priceRangeLeftView{
//    if (!_priceRangeLeftView) {
//        _priceRangeLeftView = [[UIView alloc]initWithFrame:CGRectMake(90, 15, 80, 40)];
//        _priceRangeLeftView.backgroundColor = RGBCOLOR(0.95*255, 0.95*255, 0.95*255);
//        [_priceRangeLeftView addSubview:self.priceRangeLeftText];
//    }
//    return _priceRangeLeftView;
//}
//
//
//- (UITextField *)priceRangeLeftText{
//    if (!_priceRangeLeftText) {
//
//        _priceRangeLeftText = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, 70, 40)];
//        _priceRangeLeftText.placeholder = @"¥ 0.00";
//        _priceRangeLeftText.keyboardType= UIKeyboardTypeDecimalPad;
//        _priceRangeLeftText.font = [UIFont systemFontOfSize:15];
//        _priceRangeLeftText.textColor = [UIColor orangeColor];
//    }
//    return _priceRangeLeftText;
//}
//
//- (UIView *)priceRangeRightView{
//    if (!_priceRangeRightView) {
//        _priceRangeRightView = [[UIView alloc]initWithFrame:CGRectMake(90+80+40, 15, 80, 40)];
//        _priceRangeRightView.backgroundColor = RGBCOLOR(0.95*255, 0.95*255, 0.95*255);
//        [_priceRangeRightView addSubview:self.priceRangeRightText];
//    }
//    return _priceRangeRightView;
//}
//
//- (UITextField *)priceRangeRightText{
//    if (!_priceRangeRightText) {
//        _priceRangeRightText = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, 70, 40)];
//        _priceRangeRightText.placeholder = @"¥ 0.00";
//        _priceRangeRightText.keyboardType= UIKeyboardTypeDecimalPad;
//        _priceRangeRightText.font = [UIFont systemFontOfSize:15];
//        _priceRangeRightText.textColor = [UIColor orangeColor];
//    }
//    return _priceRangeRightText;
//}

- (UITextField *)contactText{
    if (!_contactText) {
        _contactText = [[UITextField alloc]initWithFrame:CGRectMake(Screen_Width-20-100, 0, 100, 50)];
        _contactText.placeholder = @"点击输入姓名";
        _contactText.textAlignment = NSTextAlignmentRight;
        _contactText.font = [UIFont systemFontOfSize:15];
        if (_product) {
            _contactText.text=_product.linkmanName;
        }
    }
    return _contactText;
}

- (UITextField *)phoneText{
    if (!_phoneText) {
        _phoneText = [[UITextField alloc]initWithFrame:CGRectMake(Screen_Width-20-120, 0, 120, 50)];
        _phoneText.placeholder = @"点击输入手机号";
        _phoneText.font = [UIFont systemFontOfSize:15];
        _phoneText.textAlignment = NSTextAlignmentRight;
        _phoneText.textColor = [UIColor orangeColor];
        if (_product) {
            _phoneText.text=_product.linkmanMobil;
        }
    }
    return _phoneText;
}

- (UIButton *)publishBtn{
    if (!_publishBtn) {
        _publishBtn=[[UIButton alloc]initWithFrame:CGRectMake(60, 30, Screen_Width-120, 40)];
        _publishBtn.layer.cornerRadius = 6;
        _publishBtn.backgroundColor=[UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
        [_publishBtn setTitle:@"确认发布" forState:UIControlStateNormal];
        [_publishBtn addTarget:self action:@selector(publish) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _publishBtn;
}

- (UIButton *)publishBtn1{
    if (!_publishBtn1) {
        _publishBtn1=[[UIButton alloc]initWithFrame:CGRectMake(60, 30, Screen_Width-120, 40)];
        _publishBtn1.layer.cornerRadius = 6;
        _publishBtn1.backgroundColor=[UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
        [_publishBtn1 setTitle:@"确认发布" forState:UIControlStateNormal];
        [_publishBtn1 addTarget:self action:@selector(publish1) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishBtn1;
}

- (UILabel *)serviceTypeLabel{
    if (!_serviceTypeLabel) {
        _serviceTypeLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 0, 80, 60)];
        _serviceTypeLabel.text = @"";
        _serviceTypeLabel.textColor = RGBCOLOR(0.21*255, 0.54*255, 0.97*255);
        _serviceTypeLabel.font = [UIFont systemFontOfSize:15];
        _serviceTypeLabel.textAlignment = NSTextAlignmentRight;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseClassify)];
        [_serviceTypeLabel addGestureRecognizer:tap];
        _serviceTypeLabel.userInteractionEnabled = YES;
        _serviceTypeLabel.text=@"工商服务";
    }
    return _serviceTypeLabel;
}

- (UIButton *)serviceTypeBtn{
    if (!_serviceTypeBtn) {
        _serviceTypeBtn = [[UIButton alloc]initWithFrame:CGRectMake(90+85, 25, 12, 8)];
        [_serviceTypeBtn setBackgroundImage:[UIImage imageNamed:@"出售_下拉 copy"] forState:UIControlStateNormal];
        [_serviceTypeBtn addTarget:self action:@selector(chooseClassify) forControlEvents:UIControlEventTouchUpInside];
    }
    return _serviceTypeBtn;
}

- (UILabel *)serviceTypeLabel1{
    if (!_serviceTypeLabel1) {
        _serviceTypeLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(90, 0, 80, 60)];
        _serviceTypeLabel1.text = @"";
        _serviceTypeLabel1.textColor = RGBCOLOR(0.21*255, 0.54*255, 0.97*255);
        _serviceTypeLabel1.font = [UIFont systemFontOfSize:15];
        _serviceTypeLabel1.textAlignment = NSTextAlignmentRight;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseClassify1)];
        [_serviceTypeLabel1 addGestureRecognizer:tap];
        _serviceTypeLabel1.userInteractionEnabled = YES;
        _serviceTypeLabel1.text=@"工商服务1";
    }
    return _serviceTypeLabel1;
}

- (UIButton *)serviceTypeBtn1{
    if (!_serviceTypeBtn1) {
        _serviceTypeBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(90+85, 25, 12, 8)];
        [_serviceTypeBtn1 setBackgroundImage:[UIImage imageNamed:@"出售_下拉 copy"] forState:UIControlStateNormal];
        [_serviceTypeBtn1 addTarget:self action:@selector(chooseClassify1) forControlEvents:UIControlEventTouchUpInside];
    }
    return _serviceTypeBtn1;
}
#pragma mark - 服务种类
- (void)chooseClassify{
    PopView *popView = [PopView popUpContentView:self.popListView direct:PopViewDirection_PopUpBottom onView:self.serviceTypeBtn];
    //    popView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    popView.backgroundColor = [UIColor clearColor];
}
- (void)chooseClassify1{
    PopView *popView = [PopView popUpContentView:self.popListView1 direct:PopViewDirection_PopUpBottom onView:self.serviceTypeBtn1];
    //    popView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    popView.backgroundColor = [UIColor clearColor];
    _chooseClassify1=YES;
    [_tableView reloadData];
}
- (UIView *)effectiveTimeView1{
    if (!_effectiveTimeView1) {
        _effectiveTimeView1 = [[UIView alloc]initWithFrame:CGRectMake(90, 15, 80, 30)];
        _effectiveTimeView1.backgroundColor = RGBCOLOR(0.95*255, 0.95*255, 0.95*255);
        _effectiveTimeView1.layer.cornerRadius = 2;
        _effectiveTimeView1.layer.masksToBounds = YES;
        _effectiveTimeView1.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(effectiveTime1)];
        [_effectiveTimeView1 addGestureRecognizer:tap];
        
        [_effectiveTimeView1 addSubview:self.effectiveTimeLabel1];
        UIImageView *downImageView = [[UIImageView alloc]initWithFrame:CGRectMake(60, 10, 12, 8)];
        downImageView.image = [UIImage imageNamed:@"出售_下拉 copy"];
        [_effectiveTimeView1 addSubview:downImageView];
    }
    return _effectiveTimeView1;
}

- (UILabel *)effectiveTimeLabel1{
    if (!_effectiveTimeLabel1) {
        _effectiveTimeLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
        _effectiveTimeLabel1.textAlignment = NSTextAlignmentCenter;
        _effectiveTimeLabel1.font = [UIFont systemFontOfSize:15];
    }
    return _effectiveTimeLabel1;
}

#pragma mark - 有效时间
- (void)effectiveTime1{
    PopView *popView = [PopView popUpContentView:self.popEffectiveTimeListView1 direct:PopViewDirection_PopUpBottom onView:self.effectiveTimeView1];
    //    popView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    popView.backgroundColor = [UIColor clearColor];
}

//- (UIView *)priceRangeLeftView1{
//    if (!_priceRangeLeftView1) {
//        _priceRangeLeftView1 = [[UIView alloc]initWithFrame:CGRectMake(90, 15, 80, 40)];
//        _priceRangeLeftView1.backgroundColor = RGBCOLOR(0.95*255, 0.95*255, 0.95*255);
//        [_priceRangeLeftView1 addSubview:self.priceRangeLeftText1];
//    }
//    return _priceRangeLeftView1;
//}
//
//- (UITextField *)priceRangeLeftText1{
//    if (!_priceRangeLeftText1) {
//
//        _priceRangeLeftText1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, 70, 40)];
//        _priceRangeLeftText1.placeholder = @"¥ 0.00";
//        _priceRangeLeftText1.keyboardType= UIKeyboardTypeDecimalPad;
//        _priceRangeLeftText1.font = [UIFont systemFontOfSize:15];
//        _priceRangeLeftText1.textColor = [UIColor orangeColor];
//    }
//    return _priceRangeLeftText1;
//}
//
//- (UIView *)priceRangeRightView1{
//    if (!_priceRangeRightView1) {
//        _priceRangeRightView1 = [[UIView alloc]initWithFrame:CGRectMake(90+80+40, 15, 80, 40)];
//        _priceRangeRightView1.backgroundColor = RGBCOLOR(0.95*255, 0.95*255, 0.95*255);
//        [_priceRangeRightView1 addSubview:self.priceRangeRightText1];
//    }
//    return _priceRangeRightView1;
//}
//
//- (UITextField *)priceRangeRightText1{
//    if (!_priceRangeRightText1) {
//        _priceRangeRightText1 = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, 70, 40)];
//        _priceRangeRightText1.placeholder = @"¥ 0.00";
//        _priceRangeRightText1.keyboardType= UIKeyboardTypeDecimalPad;
//        _priceRangeRightText1.font = [UIFont systemFontOfSize:15];
//        _priceRangeRightText1.textColor = [UIColor orangeColor];
//    }
//    return _priceRangeRightText1;
//}

- (UITextField *)contactText1{
    if (!_contactText1) {
        _contactText1 = [[UITextField alloc]initWithFrame:CGRectMake(Screen_Width-20-100, 0, 100, 50)];
        _contactText1.placeholder = @"点击输入姓名";
        _contactText1.textAlignment = NSTextAlignmentRight;
        _contactText1.font = [UIFont systemFontOfSize:15];
    }
    return _contactText1;
}

- (UITextField *)phoneText1{
    if (!_phoneText1) {
        _phoneText1 = [[UITextField alloc]initWithFrame:CGRectMake(Screen_Width-20-120, 0, 120, 50)];
        _phoneText1.placeholder = @"点击输入手机号";
        _phoneText1.font = [UIFont systemFontOfSize:15];
        _phoneText1.textAlignment = NSTextAlignmentRight;
        _phoneText1.textColor = [UIColor orangeColor];
    }
    return _phoneText1;
}

- (UISwitch *)serviceSwitch {
    if (!_serviceSwitch) {
        _serviceSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(Screen_Width-80, 15, 60, 20)];
        _serviceSwitch.onTintColor = RGBCOLOR(0.21*255, 0.54*255, 0.97*255);
        _serviceSwitch.on = NO;
        [_serviceSwitch addTarget:self action:@selector(serviceSwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _serviceSwitch;
}

#pragma mark - 免费推送到服务列表
- (void)serviceSwitchValueChanged:(UISwitch *)sender {
    if (sender.isOn) {
        NSLog(@"ON");
    } else {
        NSLog(@"OFF");
    }
}

- (UISwitch *)serviceSwitch1 {
    if (!_serviceSwitch1) {
        _serviceSwitch1 = [[UISwitch alloc] initWithFrame:CGRectMake(Screen_Width-80, 15, 60, 20)];
        _serviceSwitch1.onTintColor = RGBCOLOR(0.21*255, 0.54*255, 0.97*255);
        _serviceSwitch1.on = NO;
        [_serviceSwitch1 addTarget:self action:@selector(serviceSwitchValueChanged1:) forControlEvents:UIControlEventValueChanged];
    }
    return _serviceSwitch1;
}

#pragma mark - 免费推送到服务列表
- (void)serviceSwitchValueChanged1:(UISwitch *)sender {
    if (sender.isOn) {
        NSLog(@"ON");
    } else {
        NSLog(@"OFF");
    }
}

- (UISwitch *)companySwitch {
    if (!_companySwitch) {
        _companySwitch = [[UISwitch alloc] initWithFrame:CGRectMake(Screen_Width-80, 15, 60, 20)];
        _companySwitch.onTintColor = RGBCOLOR(0.21*255, 0.54*255, 0.97*255);
        _companySwitch.on = NO;
        [_companySwitch addTarget:self action:@selector(companySwitchValueChanged:) forControlEvents:UIControlEventValueChanged];
    }
    return _companySwitch;
}

#pragma mark - 精准推送平台企服者
- (void)companySwitchValueChanged:(UISwitch *)sender {
    if (sender.isOn) {
        _swith=1;
        NSLog(@"ON");
    } else {
        _swith=0;
        NSLog(@"OFF");
    }
}

- (UISwitch *)companySwitch1 {
    if (!_companySwitch1) {
        _companySwitch1 = [[UISwitch alloc] initWithFrame:CGRectMake(Screen_Width-80, 15, 60, 20)];
        _companySwitch1.onTintColor = RGBCOLOR(0.21*255, 0.54*255, 0.97*255);
        _companySwitch1.on = NO;
        [_companySwitch1 addTarget:self action:@selector(companySwitchValueChanged1:) forControlEvents:UIControlEventValueChanged];
    }
    return _companySwitch1;
}

#pragma mark - 精准推送平台企服者
- (void)companySwitchValueChanged1:(UISwitch *)sender {
    if (sender.isOn) {
        _swith1=1;
        NSLog(@"ON");
    } else {
        _swith1=0;
        NSLog(@"OFF");
    }
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc]init];
        [_headerView addSubview:self.segment];
    }
    return _headerView;
}

- (PopTableListView *)popListView{
    if (_popListView == nil) {
        _popListView = [[PopTableListView alloc] initWithTitles:@[@"工商服务",@"财税服务",@"行政服务",@"金融服务",@"资质服务",@"综合服务",@"知产服务",@"法律服务"] imgNames:nil type:@"1"];
        _popListView.backgroundColor = [UIColor whiteColor];
        _popListView.layer.cornerRadius = 5;
        _popListView.delegate = self;
    }
    return _popListView;
}

- (PopTableListView *)popListView1{
    if (_popListView1 == nil) {
        _popListView1 = [[PopTableListView alloc] initWithTitles:@[@"工商服务1",@"财税服务",@"行政服务",@"金融服务",@"资质服务",@"综合服务",@"知产服务",@"法律服务"] imgNames:nil type:@"1"];
        _popListView1.backgroundColor = [UIColor whiteColor];
        _popListView1.layer.cornerRadius = 5;
        _popListView1.delegate = self;
    }
    return _popListView1;
}
- (PopTableListView *)popEffectiveTimeListView{
    if (_popEffectiveTimeListView == nil) {
        _popEffectiveTimeListView = [[PopTableListView alloc] initWithTitles:@[@"7天",@"15天",@"30天"] imgNames:nil type:@"2"];
        _popEffectiveTimeListView.backgroundColor = [UIColor whiteColor];
        _popEffectiveTimeListView.layer.cornerRadius = 5;
        _popEffectiveTimeListView.delegate = self;
    }
    return _popEffectiveTimeListView;
}

- (PopTableListView *)popEffectiveTimeListView1{
    if (_popEffectiveTimeListView1 == nil) {
        _popEffectiveTimeListView1 = [[PopTableListView alloc] initWithTitles:@[@"7天",@"15天",@"30天"] imgNames:nil type:@"2"];
        _popEffectiveTimeListView1.backgroundColor = [UIColor whiteColor];
        _popEffectiveTimeListView1.layer.cornerRadius = 5;
        _popEffectiveTimeListView1.delegate = self;
    }
    return _popEffectiveTimeListView1;
}

- (void)selectType:(NSString *)name type:(NSString *)type{
    
    [PopView hidenPopView];
    
    if (self.segment.selectedSegmentIndex == 0) {
        self.effectiveTimeLabel.text = name;
    }else{
        if ([type isEqualToString:@"1"]) {
            self.serviceTypeLabel.text = name;
            if ([name isEqualToString:@"工商服务"]) {
                _serviceid=1;
            }
            else if ([name isEqualToString:@"财税服务"])
            {
                _serviceid=2;
            }
            else if ([name isEqualToString:@"行政服务"])
            {
                _serviceid=3;
            }
            else if ([name isEqualToString:@"金融服务"])
            {
                _serviceid=4;
            }
            else if ([name isEqualToString:@"资质服务"])
            {
                _serviceid=5;
            }
            else if ([name isEqualToString:@"综合服务"])
            {
                _serviceid=6;
            }
            else if ([name isEqualToString:@"知产服务"])
            {
                _serviceid=7;
            }
            else if ([name isEqualToString:@"法律服务"])
            {
                _serviceid=8;
            }
        }else{
            self.effectiveTimeLabel1.text = name;
        }
    }
}

- (void)selectEffetiveTimeType:(NSString *)name type:(NSString *)type{
    [PopView hidenPopView];
    
    if (self.segment.selectedSegmentIndex == 0) {
        self.effectiveTimeLabel.text = name;
    }else{
        self.effectiveTimeLabel1.text = name;
    }
}
-(void)publish
{
    _myindex=0;
    [self verify];
}
-(void)publish1
{
    _myindex=1;
    [self verify1];
}
-(void)verify
{
    
    if ([_addressLabel.text isEqualToString:@""])
    {
        [MBProgressHUD showMBProgressHud:self.view withText:@"亲,请输入地址" withTime:1];
        
        return;
    }
    if ([_detailText.text isEqualToString:@""])
    {
        [MBProgressHUD showMBProgressHud:self.view withText:@"亲,请输入详情" withTime:1];
        
        return;
    }
    else if ([_priceRangeRightText.text isEqualToString:@""])
    {
        [MBProgressHUD showMBProgressHud:self.view withText:@"亲,请输入价格" withTime:1];
        
        return;
    }
    else if ([_phoneText.text isEqualToString:@""])
    {
        [MBProgressHUD showMBProgressHud:self.view withText:@"亲,请输入电话" withTime:1];
        
        return;
    }
    else if (_phoneText.text.length != 11)
    {
        [MBProgressHUD showMBProgressHud:self.view withText:@"您输入的手机号码格式不正确" withTime:1];
        
        return;
    }
    else if ([_contactText.text isEqualToString:@""])
    {
        [MBProgressHUD showMBProgressHud:self.view withText:@"亲,请输入联系人" withTime:1];
        
        return;
    }
    else if ([_priceRangeLeftText.text isEqualToString:@""])
    {
        [MBProgressHUD showMBProgressHud:self.view withText:@"亲,请输入价格" withTime:1];
        
        return;
    }
    else if ([_titleText.text isEqualToString:@""])
    {
        [MBProgressHUD showMBProgressHud:self.view withText:@"亲,请输入标题" withTime:1];
        
        return;
    }
    [self sure];
}
-(void)sure
{
    [self.view addSubview:self.maskTheView];
    [self.view addSubview:self.shareView];
    _lab1.text=@"发布信息的分类应严格按照平台分类填写,否则平台将其视为无效信息并删除,因此造成的一切损失由用户承担.";
}
-(void)verify1
{
    
    if ([_addressLabel.text isEqualToString:@""])
    {
        [MBProgressHUD showMBProgressHud:self.view withText:@"亲,请输入密码" withTime:1];
        
        return;
    }
    if ([_detailText1.text isEqualToString:@""])
    {
        [MBProgressHUD showMBProgressHud:self.view withText:@"亲,请输入详细内容" withTime:1];
        
        return;
    }
    else if ([_priceRangeRightText1.text isEqualToString:@""])
    {
        [MBProgressHUD showMBProgressHud:self.view withText:@"亲,请输入价格" withTime:1];
        
        return;
    }
    else if ([_phoneText1.text isEqualToString:@""])
    {
        [MBProgressHUD showMBProgressHud:self.view withText:@"亲,请输入电话" withTime:1];
        
        return;
    }
    else if (_phoneText1.text.length != 11)
    {
        [MBProgressHUD showMBProgressHud:self.view withText:@"您输入的手机号码格式不正确" withTime:1];
        
        return;
    }
    else if ([_contactText1.text isEqualToString:@""])
    {
        [MBProgressHUD showMBProgressHud:self.view withText:@"亲,请输入联系人" withTime:1];
        
        return;
    }
    else if ([_priceRangeLeftText1.text isEqualToString:@""])
    {
        [MBProgressHUD showMBProgressHud:self.view withText:@"亲,请输入价格" withTime:1];
        
        return;
    }
    else if ([_titleText1.text isEqualToString:@""])
    {
        [MBProgressHUD showMBProgressHud:self.view withText:@"亲,请输入标题" withTime:1];
        
        return;
    }
    [self sure];
}
#pragma mark - 发布
- (void)PostUI {
    if (_product) {
        [self PostUpdateUI];
        return;
    }
    if (_myindex==1) {
        [self PostUI1];
        return;
    }
    //    [self clickImage];
    _surebtn.enabled=NO;
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    NSDictionary *params = @{
                             @"accuratePush" : @(_swith),
                             @"asset": @"",
                             @"browse" : @(0),
                             @"business" : @"",
                             @"buyUserId" : @(0),
                             @"cityId" : @(0),
                             @"cityName" : _addressLabel.text,
                             @"detail" : _detailText.text,
                             @"freePush" : @(0),
                             //                             @"higherPrice" : @([_priceRangeRightText.text intValue]),
                             @"imageList" : @"",
                             @"information" : @"1",
                             @"isDel" : @(0),
                             @"linkmanId" : @(0),
                             @"linkmanMobil" : _phoneText.text,
                             @"linkmanName" : _contactText.text,
                             //                             @"lowerPrice" : @([_priceRangeLeftText.text intValue]),
                             @"price" : @(0),
                             @"releaseId" : @(0),
                             @"releaseTime" : strDate,
                             @"releaseTypeId" : @(2),
                             @"selectId" : @(0),
                             //                             @"serviceId" : @(0),
                             @"taxId" : @(0),
                             @"title" : _titleText.text,
                             @"tradStatus" : @(0),
                             @"userId" : @(0),
                             @"validId" : @(0)
                             };
    
    [HttpTool post:[NSString stringWithFormat:@"release/releaseService"] params:params success:^(id responseObj) {
        NSString *code = responseObj[@"code"];
        if (code.integerValue == 0)  {
            [MBProgressHUD showSuccess:@"发布成功" toView:self.view];
            [[NSNotificationCenter defaultCenter]postNotificationName:FaBuChengGongRefresh_Mine object:nil];
        }
    } failure:^(NSError *error) {
        
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cancelClick];
    });
}
- (void)PostUpdateUI {
    if (_myindex==1) {
        [self PostUI1];
        return;
    }
    //    [self clickImage];
    _surebtn.enabled=NO;
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    NSDictionary *params = @{
                             @"accuratePush" : @(_swith),
                             @"asset": @"",
                             @"browse" : @(0),
                             @"business" : @"",
                             @"buyUserId" : @(0),
                             @"cityId" : @(0),
                             @"cityName" : _addressLabel.text,
                             @"detail" : _detailText.text,
                             @"freePush" : @(0),
                             //                             @"higherPrice" : @([_priceRangeRightText.text intValue]),
                             @"imageList" : @"",
                             @"information" : @"1",
                             @"isDel" : @(0),
                             @"linkmanId" : @(0),
                             @"linkmanMobil" : _phoneText.text,
                             @"linkmanName" : _contactText.text,
                             //                             @"lowerPrice" : @([_priceRangeLeftText.text intValue]),
                             @"price" : @(0),
                             @"releaseTime" : strDate,
                             @"releaseTypeId" : @(2),
                             @"selectId" : @(0),
                             //                             @"serviceId" : @(0),
                             @"taxId" : @(0),
                             @"title" : _titleText.text,
                             @"tradStatus" : @(0),
                             @"userId" : @(0),
                             @"validId" : @(0),
                             @"releaseId" :_product.releaseId,
                             @"userId" : _product.userId

                             };
    
    [HttpTool post:[NSString stringWithFormat:@"release/updateService"] params:params success:^(id responseObj) {
        NSDictionary* a=responseObj[@"data"];
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cancelClick];
    });
}
#pragma mark - 发布
- (void)PostUI1 {
    //    [self clickImage];
    if (_product) {
        [self PostUpdateUI1];
        return;
    }
    _surebtn.enabled=NO;
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    NSDictionary *params = @{
                             @"accuratePush" : @(_swith1),
                             @"asset": @"",
                             @"browse" : @(0),
                             @"business" : @"",
                             @"buyUserId" : @(0),
                             @"cityId" : @(0),
                             @"cityName" : _addressLabel.text,
                             @"detail" : _detailText1.text,
                             @"freePush" : @(0),
                             //                             @"higherPrice" : @([_priceRangeRightText1.text intValue]),
                             @"imageList" : @"",
                             @"information" : @"1",
                             @"isDel" : @(0),
                             @"linkmanId" : @(0),
                             @"linkmanMobil" : _phoneText1.text,
                             @"linkmanName" : _contactText1.text,
                             //                             @"lowerPrice" : @([_priceRangeLeftText1.text intValue]),
                             @"price" : @(0),
                             @"releaseId" : @(0),
                             @"releaseTime" : strDate,
                             @"releaseTypeId" : @(2),
                             @"selectId" : @(0),
                             @"serviceId" : @(_serviceid),
                             @"taxId" : @(0),
                             @"title" : _titleText1.text,
                             @"tradStatus" : @(0),
                             @"userId" : @(0),
                             @"validId" : @(0)
                             };
    
    [HttpTool post:[NSString stringWithFormat:@"release/releaseService"] params:params success:^(id responseObj) {
        NSDictionary* a=responseObj[@"data"];
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cancelClick];
        [MBProgressHUD showSuccess:@"发布成功" toView:self.view];
        [[NSNotificationCenter defaultCenter]postNotificationName:FaBuChengGongRefresh_Mine object:nil];
    });
}
#pragma mark - 发布
- (void)PostUpdateUI1 {
    //    [self clickImage];
    
    if (_product) {
//        _serviceid=_product.serviceId;
    }
    _surebtn.enabled=NO;
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    NSDictionary *params = @{
                             @"accuratePush" : @(_swith1),
                             @"asset": @"",
                             @"browse" : @(0),
                             @"business" : @"",
                             @"buyUserId" : @(0),
                             @"cityId" : @(0),
                             @"cityName" : _addressLabel.text,
                             @"detail" : _detailText1.text,
                             @"freePush" : @(0),
                             //                             @"higherPrice" : @([_priceRangeRightText1.text intValue]),
                             @"imageList" : @"",
                             @"information" : @"1",
                             @"isDel" : @(0),
                             @"linkmanId" : @(0),
                             @"linkmanMobil" : _phoneText1.text,
                             @"linkmanName" : _contactText1.text,
                             //                             @"lowerPrice" : @([_priceRangeLeftText1.text intValue]),
                             @"price" : @(0),
                             @"releaseTime" : strDate,
                             @"releaseTypeId" : @(2),
                             @"selectId" : @(0),
                             @"serviceId" : @(_serviceid),
                             @"taxId" : @(0),
                             @"title" : _titleText1.text,
                             @"tradStatus" : @(0),
                             @"userId" : @(0),
                             @"validId" : @(0),
                             @"releaseId" :_product.releaseId,
                             @"userId" : _product.userId
                             };
    
    [HttpTool post:[NSString stringWithFormat:@"release/updateService"] params:params success:^(id responseObj) {
        NSDictionary* a=responseObj[@"data"];
        NSLog(@"");
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self cancelClick];
        [MBProgressHUD showSuccess:@"发布成功" toView:self.view];
        [[NSNotificationCenter defaultCenter]postNotificationName:FaBuChengGongRefresh_Mine object:nil];
    });;
}
//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    return [self validateNumber:string];
//}
//
//
//- (BOOL)validateNumber:(NSString*)number {
//    BOOL res = YES;
//    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
//    int i = 0;
//    while (i < number.length) {
//        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
//        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
//        if (range.length == 0) {
//            res = NO;
//            break;
//        }
//        i++;
//    }
//    return res;
//}
- (void)onClickBtnBack:(UIButton *)btn {
    [self finishPublish];
}
@end
