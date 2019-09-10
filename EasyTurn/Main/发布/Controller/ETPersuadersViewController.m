//
//  ETPersuadersViewController.m
//  EasyTurn
//
//  Created by 王翔 on 2019/7/30.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETPersuadersViewController.h"
#import "PopView.h"
#import "PopTableListView.h"
#import "LQCityPicker.h"
#import "LQPickerView.h"
#import "LZCPickerView.h"

@interface ETPersuadersViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,PopTableListViewDelegate>

@property (nonatomic,strong)UITableView *tab;
@property (nonatomic,strong)UITextField *titleText;
@property (nonatomic,strong)UITextView *detailText;
@property (nonatomic,strong)UIButton *photoImageView;
@property (nonatomic,strong)UILabel *pointLab;
@property (nonatomic,strong)UILabel *classificationLabel;
@property (nonatomic,strong)UIButton *classificationBtn;
@property (nonatomic,strong)UILabel *addressLabel;
@property (nonatomic,strong)UIView *effectiveTimeView;
@property (nonatomic,strong)UILabel *effectiveTimeLabel;
@property (nonatomic,strong)UITextField *priceText;
@property (nonatomic,strong)UITextField *priceRangeLeftText;
@property (nonatomic,strong)UITextField *priceRangeRightText;
@property (nonatomic,strong)UIView *priceRangeLeftView;
@property (nonatomic,strong)UIView *priceRangeRightView;
@property (nonatomic,strong)UITextField *contactText;
@property (nonatomic,strong)UITextField *phoneText;
@property (nonatomic,strong)UIButton *publishBtn;
@property (nonatomic ,strong)PopTableListView *popListView;
@property (nonatomic ,strong)PopTableListView *popEffectiveTimeListView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIImage *photoImg;
@property (nonatomic, copy) NSString *photoUrl;
@property (nonatomic, assign) int serviceid;
@property (nonatomic,strong) UIView * maskTheView;
@property (nonatomic,strong) UIView * shareView;
@property (nonatomic,strong)UILabel *lab1;
@property (nonatomic,strong)UIButton *surebtn;

@end

@implementation ETPersuadersViewController
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

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

}

- (UITableView *) tab {
    if (!_tab) {
        _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) style:UITableViewStyleGrouped];
        if (_product) {
            _tab=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height-20) style:UITableViewStyleGrouped];
            
        }
        _tab.bounces=NO;
        _tab.showsVerticalScrollIndicator = NO;
        _tab.delegate=self;
        _tab.dataSource=self;
        _tab.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0,0,0,0.01)];
        _tab.sectionFooterHeight = 0;
        _tab.sectionHeaderHeight = 10;
    }
    return _tab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadAddressData];
    
    self.title=@"发布服务";
    [self enableLeftBackWhiteButton];
    [self.view addSubview:self.tab];
    self.tab.contentInsetAdjustmentBehavior = NO;
    
    //添加取消按钮->
//    [self addCancelBtn];
    
    [self shareView];
    [self shareViewController];
}

- (void)onClickBtnBack:(UIButton *)btn {
    [self finishPublish];
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 2;
    }else if (section==1) {
        return 0;
    }else if (section==2) {
        return 2;
    }else if (section==3) {
        return 1;
    }else {
        return 3;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            return 60;
        }else if (indexPath.row==1) {
            return 110;
        }
    }else if (indexPath.section==1) {
        return 100;
    }else if (indexPath.section==2) {
        return 60;
    }else if (indexPath.section==3) {
        if (indexPath.row==0) {
            return 50;
        }else if (indexPath.row==1) {
            return 70;
        }
    }else if (indexPath.section==4) {
        if (indexPath.row==0) {
            return 50;
        }else if (indexPath.row==1) {
            return 50;
        }else if (indexPath.row==2) {
            return 100;
        }
    }
    return YES;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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
        
        [cell.contentView addSubview:self.photoImageView];
        [cell.contentView addSubview:self.pointLab];
        
    }else if (indexPath.section==2) {
        if (indexPath.row==0) {
            UILabel *titlelab=[[UILabel alloc]init];
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"分类选择"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
            
            
            titlelab.attributedText = string;
            titlelab.textAlignment = NSTextAlignmentLeft;
            titlelab.alpha = 1.0;
            [cell addSubview:titlelab];
            
            [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(76, 60));
            }];
            
            [cell.contentView addSubview:self.classificationLabel];
            [cell.contentView addSubview:self.classificationBtn];
            
            if (_product) {
                
                if ([_product.serviceId isEqualToString:@"1"])
                {
                    self.classificationLabel.text= @"工商服务";
                }
                else if ([_product.serviceId isEqualToString:@"2"])
                {
                    self.classificationLabel.text=@"财税服务";
                }
                else if ([_product.serviceId isEqualToString:@"3"])
                {
                    self.classificationLabel.text=@"行政服务";
                }
                else if ([_product.serviceId isEqualToString:@"4"])
                {
                    self.classificationLabel.text=@"金融服务";
                }
                else if ([_product.serviceId isEqualToString:@"5"])
                {
                    self.classificationLabel.text=@"资质服务";
                }
                else if ([_product.serviceId isEqualToString:@"6"])
                {
                    self.classificationLabel.text=@"综合服务";
                }
                else if ([_product.serviceId isEqualToString:@"7"])
                {
                    self.classificationLabel.text=@"知产服务";
                }
                else if ([_product.serviceId isEqualToString:@"8"])
                {
                    self.classificationLabel.text=@"法律服务";
                }

            }
            
        }else if (indexPath.row==1) {
            UILabel *titlelab=[[UILabel alloc]init];
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"地址"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
            titlelab.attributedText = string;
            titlelab.textAlignment = NSTextAlignmentLeft;
            titlelab.alpha = 1.0;
            [cell addSubview:titlelab];
            
            [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(76, 60));
            }];
            
            [cell.contentView addSubview:self.addressLabel];
            _addressLabel.text=@"北京";
            if (_product) {
                _addressLabel.text=_product.cityName;
            }
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        }else if (indexPath.row==2) {
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
    }else if (indexPath.section==3) {
        if (indexPath.row==0) {
            UILabel *titlelab=[[UILabel alloc]init];
            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"价格"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
            titlelab.attributedText = string;
            titlelab.textAlignment = NSTextAlignmentLeft;
            titlelab.alpha = 1.0;
            [cell addSubview:titlelab];
            
            [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(0);
                make.left.mas_equalTo(15);
                make.size.mas_equalTo(CGSizeMake(30, 50));
            }];
            
            [cell.contentView addSubview:self.priceText];
            
        }
        //        else if (indexPath.row==1) {
        //            UILabel *titlelab=[[UILabel alloc]init];
        //            NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"价格范围"attributes: @{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 15],NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0]}];
        //            titlelab.attributedText = string;
        //            titlelab.textAlignment = NSTextAlignmentLeft;
        //            titlelab.alpha = 1.0;
        //            [cell addSubview:titlelab];
        //
        //            [titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
        //                make.top.mas_equalTo(0);
        //                make.left.mas_equalTo(15);
        //                make.size.mas_equalTo(CGSizeMake(62, 70));
        //            }];
        //
        //            [cell.contentView addSubview:self.priceRangeLeftView];
        //
        //            UILabel *symbol = [[UILabel alloc]initWithFrame:CGRectMake(90+80, 31, 40, 6)];
        //            symbol.text = @"~";
        //            symbol.textColor = RGBACOLOR(180, 180, 180, 1);
        //            symbol.textAlignment = NSTextAlignmentCenter;
        //            [cell.contentView addSubview:symbol];
        //
        //            [cell.contentView addSubview:self.priceRangeRightView];
        //        }
    }else if (indexPath.section==4) {
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
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_tab deselectRowAtIndexPath:indexPath animated:YES];
    
#pragma mark - 地址定位
    if (indexPath.section == 2 && indexPath.row == 1) {
        __weak typeof(self)ws = self;
        [LQCityPicker showInView:self.view datas:self.dataSource didSelectWithBlock:^(NSArray *objs, NSString *dsc) {
            NSLog(@"%@\n%@", objs, dsc);
            ws.addressLabel.text = dsc;
        } cancelBlock:^{
            NSLog(@"cancel");
        }];
    }
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

- (UITextField *)titleText{
    if (!_titleText) {
        _titleText = [[UITextField alloc]initWithFrame:CGRectMake(65, 0, Screen_Width-80, 60)];
        _titleText.font = [UIFont systemFontOfSize:15];
        _titleText.placeholder = @"请输入您要发布的标题(标题有利于推送搜索)";
        if (_product) {
            _titleText.text=_product.title;
        }
    }
    return _titleText;
}

- (UITextView *)detailText{
    if (!_detailText) {
        _detailText = [[UITextView alloc]initWithFrame:CGRectMake(90, 15, Screen_Width-110, 80)];
        _detailText.font = [UIFont systemFontOfSize:15];
        _detailText.textColor = RGBACOLOR(100, 100, 100, 1);
        // _placeholderLabel
        UILabel *placeHolderLabel = [[UILabel alloc] init];
        placeHolderLabel.text = @"请输入服务详细内容";
        placeHolderLabel.numberOfLines = 0;
        placeHolderLabel.textColor = RGBACOLOR(200, 200, 200, 1);
        [placeHolderLabel sizeToFit];
        [_detailText addSubview:placeHolderLabel];
        
        placeHolderLabel.font = [UIFont systemFontOfSize:15];
        [_detailText setValue:placeHolderLabel forKey:@"_placeholderLabel"];
        if (_product) {
            _detailText.text=_product.business;
            if ([_product.serviceId isEqualToString:@"0"]||[_product.serviceId isEqualToString:@"2"]) {
                _detailText.text=_product.detail;
            }
            if ([_product.business isEqualToString:@""]) {
                _detailText.text=_product.detail;

            }
        }
    }
    return _detailText;
}

- (UIButton *)photoImageView{
    if (!_photoImageView) {
        _photoImageView = [[UIButton alloc]initWithFrame:CGRectMake(15, 10, 80, 80)];
        [_photoImageView setBackgroundImage:[UIImage imageNamed:@"出售_分组 2"] forState:UIControlStateNormal];
        [_photoImageView addTarget:self action:@selector(chooseImage) forControlEvents:UIControlEventTouchUpInside];
        if (_product) {
            UIImage * result;
            
            NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:_product.imageList]];
            
            result = [UIImage imageWithData:data];
            [_photoImageView setBackgroundImage:result forState:UIControlStateNormal];
        }
    }
    return _photoImageView;
}

- (UILabel *)pointLab {
    if (!_pointLab) {
        _pointLab =[[UILabel alloc]initWithFrame:CGRectMake(135, 30, 150, 30)];
        _pointLab.text=@"点击选择图片上传";
        _pointLab.textColor=[UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    }
    return _pointLab;
}

- (UILabel *)classificationLabel{
    if (!_classificationLabel) {
        _classificationLabel = [[UILabel alloc]initWithFrame:CGRectMake(90, 0, 80, 60)];
        _classificationLabel.text = @"";
        _classificationLabel.textColor = RGBCOLOR(0.21*255, 0.54*255, 0.97*255);
        _classificationLabel.font = [UIFont systemFontOfSize:15];
        _classificationLabel.textAlignment = NSTextAlignmentRight;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseClassify)];
        [_classificationLabel addGestureRecognizer:tap];
        _classificationLabel.userInteractionEnabled = YES;
        self.classificationLabel.text=@"工商服务";
    }
    return _classificationLabel;
}

- (UIButton *)classificationBtn{
    if (!_classificationBtn) {
        _classificationBtn = [[UIButton alloc]initWithFrame:CGRectMake(90+85, 25, 12, 8)];
        [_classificationBtn setBackgroundImage:[UIImage imageNamed:@"出售_下拉 copy"] forState:UIControlStateNormal];
        [_classificationBtn addTarget:self action:@selector(chooseClassify) forControlEvents:UIControlEventTouchUpInside];
    }
    return _classificationBtn;
}

#pragma mark - 分类选择
- (void)chooseClassify{
    PopView *popView = [PopView popUpContentView:self.popListView direct:PopViewDirection_PopUpBottom onView:self.classificationBtn];
    //    popView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    popView.backgroundColor = [UIColor clearColor];
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

- (PopTableListView *)popEffectiveTimeListView{
    if (_popEffectiveTimeListView == nil) {
        _popEffectiveTimeListView = [[PopTableListView alloc] initWithTitles:@[@"7天",@"15天",@"30天",] imgNames:nil type:@"2"];
        _popEffectiveTimeListView.backgroundColor = [UIColor whiteColor];
        _popEffectiveTimeListView.layer.cornerRadius = 5;
        _popEffectiveTimeListView.delegate = self;
    }
    return _popEffectiveTimeListView;
}

- (void)selectType:(NSString *)name type:(NSString *)type{
    
    [PopView hidenPopView];
    
    if ([type isEqualToString:@"1"]) {
        self.classificationLabel.text = name;
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
        self.effectiveTimeLabel.text = name;
    }
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

#pragma mark - 有效时间
- (void)effectiveTime{
    PopView *popView = [PopView popUpContentView:self.popEffectiveTimeListView direct:PopViewDirection_PopUpBottom onView:self.effectiveTimeView];
    //    popView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    popView.backgroundColor = [UIColor clearColor];
}


- (UILabel *)effectiveTimeLabel{
    if (!_effectiveTimeLabel) {
        _effectiveTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
        _effectiveTimeLabel.textAlignment = NSTextAlignmentCenter;
        _effectiveTimeLabel.font = [UIFont systemFontOfSize:15];
        self.effectiveTimeLabel.text=@"7天";
        if (_product) {
            //            _effectiveTimeLabel.text=_product.title;
        }
    }
    return _effectiveTimeLabel;
}

- (UITextField *)priceText{
    if (!_priceText) {
        _priceText = [[UITextField alloc]initWithFrame:CGRectMake(90, 0, 100, 50)];
        _priceText.placeholder = @"¥ 0.00";
        _priceText.keyboardType= UIKeyboardTypeDecimalPad;
        _priceText.font = [UIFont systemFontOfSize:15];
        _priceText.textColor = [UIColor orangeColor];
        if (_product) {
            NSString* pri=[_product.price stringByReplacingOccurrencesOfString:@".0000" withString:@""];
            _priceText.text=pri;
        }
    }
    return _priceText;
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
        _publishBtn=[[UIButton alloc]initWithFrame:CGRectMake(60, 20, Screen_Width-120, 40)];
        _publishBtn.layer.cornerRadius = 6;
        _publishBtn.backgroundColor=[UIColor colorWithRed:20/255.0 green:138/255.0 blue:236/255.0 alpha:1.0];
        [_publishBtn setTitle:@"确认发布" forState:UIControlStateNormal];
        [_publishBtn addTarget:self action:@selector(publish) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishBtn;
}

#pragma mark - 选择图片
- (void)chooseImage{
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照", @"从相册获取", nil];
    [choiceSheet showInView:self.view];
}

#pragma mark UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        // 拍照
#pragma mark - 拍照
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                                 //                                 [DataMgr shareInstance].presentVC = controller;
                             }];
        }
        
    } else if (buttonIndex == 1) {
        // 从相册中选取
#pragma mark - 从相册中选取
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                                 //                                 [DataMgr shareInstance].presentVC = controller;
                             }];
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^() {
        UIImage *portraitImg = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        
        [weakSelf.photoImageView setBackgroundImage:portraitImg forState:UIControlStateNormal];
        //oss
        weakSelf.photoImg=portraitImg;
        [weakSelf uploadOSS];
        //        HYClipIconViewController *clipVc = [[HYClipIconViewController alloc] initWithImage:portraitImg clipType:HYClipTypeArc];
        //        //    clipVc.clipRect = CGRectMake(0, 0, 200, 200);
        //        [clipVc didClipImageBlock:^(UIImage *image) {
        //            self.iconImageView.image = image;
        //
        //            NSData *imageData = UIImagePNGRepresentation(image);
        //            [SaveToMemory SaveData:imageData ToMemory:[NSString stringWithFormat:@"%@.png",CUR_MemberID]];
        //            //图片上传至服务器
        //            [self uploadIcon:image];
        //        }];
        //        [clipVc showClipIconViewController:self];
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
        //        [DataMgr shareInstance].presentVC = nil;
    }];
}

#pragma mark image scale utility
#define ORIGINAL_MAX_WIDTH 640.0f
- (UIImage *)imageByScalingToMaxSize:(UIImage *)sourceImage {
    if (sourceImage.size.width < ORIGINAL_MAX_WIDTH) return sourceImage;
    CGFloat btWidth = 0.0f;
    CGFloat btHeight = 0.0f;
    if (sourceImage.size.width > sourceImage.size.height) {
        btHeight = ORIGINAL_MAX_WIDTH;
        btWidth = sourceImage.size.width * (ORIGINAL_MAX_WIDTH / sourceImage.size.height);
    } else {
        btWidth = ORIGINAL_MAX_WIDTH;
        btHeight = sourceImage.size.height * (ORIGINAL_MAX_WIDTH / sourceImage.size.width);
    }
    //    CGSize targetSize = CGSizeMake(btWidth, btHeight);
    CGSize targetSize = CGSizeMake(150, 150);
    return [self imageByScalingAndCroppingForSourceImage:sourceImage targetSize:targetSize];
}

- (UIImage *)imageByScalingAndCroppingForSourceImage:(UIImage *)sourceImage targetSize:(CGSize)targetSize {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else
            if (widthFactor < heightFactor)
            {
                thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            }
    }
#pragma mark - 修改头像图片尺寸
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil) NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark camera utility
- (BOOL)isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL)isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL)isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL)doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL)isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL)canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL)canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL)cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}
- (void)selectEffetiveTimeType:(NSString *)name type:(NSString *)type{
    [PopView hidenPopView];
    
    self.effectiveTimeLabel.text = name;
    
}
-(void)publish
{
    [self verify];
}
-(void)verify
{
    if ([_addressLabel.text isEqualToString:@""])
    {
        [MBProgressHUD showMBProgressHud:self.view withText:@"亲,请输入地址" withTime:1];
        
        return;
    }
    else if ([_detailText.text isEqualToString:@""])
    {
        [MBProgressHUD showMBProgressHud:self.view withText:@"亲,请输入详情" withTime:1];
        
        return;
    }
    else if ([_priceRangeRightText.text isEqualToString:@""])
    {
        [MBProgressHUD showMBProgressHud:self.view withText:@"亲,请输入价格" withTime:1];
        
        return;
    }
//    else if ([self.photoUrl isEqualToString:@""])
//    {
//        [MBProgressHUD showMBProgressHud:self.view withText:@"亲,请输入图片" withTime:1];
//
//        return;
//    }
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
    else if ([_priceText.text isEqualToString:@""])
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
#pragma mark - 发布
- (void)PostUI {
    //    [self clickImage];
    if (_product) {
        [self PostUpdateUI];
        return;
    }
    _surebtn.enabled=NO;
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    NSDictionary *params = @{
                             @"accuratePush" : @(0),
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
                             @"price" : _priceText.text,
                             @"releaseId" : @(0),
                             @"releaseTime" : strDate,
                             @"releaseTypeId" : @(3),
                             @"selectId" : @(0),
                             @"serviceId" : @(_serviceid),
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
        [MBProgressHUD showSuccess:@"发布成功" toView:self.view];
        [[NSNotificationCenter defaultCenter]postNotificationName:FaBuChengGongRefresh_Mine object:nil];
    });
}
#pragma mark - 发布
- (void)PostUpdateUI {
    //    [self clickImage];

    if (_product) {
        _serviceid=_product.serviceId;
    }
    _surebtn.enabled=NO;
    NSMutableDictionary* dic=[NSMutableDictionary new];
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    NSDictionary *params = @{
                             @"accuratePush" : @(0),
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
                             @"price" : _priceText.text,
                             @"releaseTime" : strDate,
                             @"releaseTypeId" : @(3),
                             @"selectId" : @(0),
                             @"serviceId" : @(_serviceid),
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
        [MBProgressHUD showSuccess:@"发布成功" toView:self.view];
        [[NSNotificationCenter defaultCenter]postNotificationName:FaBuChengGongRefresh_Mine object:nil];
    });;
}
-(void)uploadOSS
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud setObject:@"xh/publish" forKey:@"tmpPath"];
    [ud synchronize];
    __weak typeof(self) weakself = self;
    [OSSImageUploader asyncUploadImage:_photoImg complete:^(NSArray<NSString *> *names, UploadImageState state) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"%@",[NSString stringWithFormat:@"/%@", names.lastObject]);
            NSLog(@"");
            self.photoUrl=[NSString stringWithFormat:@"%@%@",alioss,[NSString stringWithFormat:@"/%@", names.lastObject]];
            //            [weakself postEdit:@{@"headurl" : [NSString stringWithFormat:@"/%@", names.lastObject]}];
        });
    }];
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
@end
