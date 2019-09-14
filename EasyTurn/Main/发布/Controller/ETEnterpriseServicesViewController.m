//
//  ETEnterpriseServicesViewController.m
//  EasyTurn
//
//  Created by 程立 on 2019/9/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETEnterpriseServicesViewController.h"
#import "ETEnterpriseServicesViewModel.h"
#import "ETEnterpriseServicesViewDataModel.h"

#import "ETEnterpriseServicesTitleTableViewCell.h"
#import "ETEnterpriseServicesPopListTableViewCell.h"
#import "ETEnterpriseServicesScopeBusinessTableViewCell.h"
#import "ETEnterpriseServicesSelectTableViewCell.h"
#import "ETEnterpriseServicesAddressTableViewCell.h"
#import "ETEnterpriseServicesSwitchTableViewCell.h"
#import "ETEnterpriseServicesCheckTableViewCell.h"
#import "LQCityPicker.h"
#import "LQPickerView.h"
#import "ETEnterpriseServicesBusinessScopeModel.h"
#import "ETEnterpriseServicesViewRequestModel.h"

static NSString * const kETEnterpriseServicesTitleTableViewCellReuseID = @"ETEnterpriseServicesTitleTableViewCell";
static NSString * const kETEnterpriseServicesPopListTableViewCellReuseID = @"ETEnterpriseServicesPopListTableViewCell";
static NSString * const kETEnterpriseServicesScopeBusinessTableViewCellReuseID = @"ETEnterpriseServicesScopeBusinessTableViewCell";
static NSString * const kETEnterpriseServicesSelectTableViewCellReuseID = @"ETEnterpriseServicesSelectTableViewCell";
static NSString * const kETEnterpriseServicesAddressTableViewCellReuseID = @"ETEnterpriseServicesAddressTableViewCell";
static NSString * const kETEnterpriseServicesSwitchTableViewCellReuseID = @"ETEnterpriseServicesSwitchTableViewCell";
static NSString * const kETEnterpriseServicesCheckTableViewCellReuseID = @"ETEnterpriseServicesCheckTableViewCell";


@interface ETEnterpriseServicesViewController ()<UITableViewDataSource, UITableViewDelegate, ETEnterpriseServicesPopListTableViewCellDelegate, ETEnterpriseServicesScopeBusinessTableViewCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrMuSection;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) ETEnterpriseServicesViewRequestModel *mRequest;
@property (nonatomic,strong) NSDictionary* dics;
@end

@implementation ETEnterpriseServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWithDefaultValue];
    [self createSubViews];
    [self requestBusinessScope];
    [MySingleton sharedMySingleton].scopes=[NSMutableArray array];
}

- (void)initWithDefaultValue {
    _arrMuSection = [NSMutableArray array];
    ETEnterpriseServicesViewDataModel *mEnterprise = [ETEnterpriseServicesViewDataModel loadDataSourceETEnterpriseServicesViewDataModel];
    [_arrMuSection addObjectsFromArray:mEnterprise.arrEnterpriseServicesViewData];
}

- (void)createSubViews {
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.tableView.tableFooterView = self.footerView;
    
    [self.tableView registerClass:[ETEnterpriseServicesTitleTableViewCell class] forCellReuseIdentifier:kETEnterpriseServicesTitleTableViewCellReuseID];
    [self.tableView registerClass:[ETEnterpriseServicesPopListTableViewCell class] forCellReuseIdentifier:kETEnterpriseServicesPopListTableViewCellReuseID];
    [self.tableView registerClass:[ETEnterpriseServicesScopeBusinessTableViewCell class] forCellReuseIdentifier:kETEnterpriseServicesScopeBusinessTableViewCellReuseID];
    [self.tableView registerClass:[ETEnterpriseServicesSelectTableViewCell class] forCellReuseIdentifier:kETEnterpriseServicesSelectTableViewCellReuseID];
    [self.tableView registerClass:[ETEnterpriseServicesAddressTableViewCell class] forCellReuseIdentifier:kETEnterpriseServicesAddressTableViewCellReuseID];
    [self.tableView registerClass:[ETEnterpriseServicesSwitchTableViewCell class] forCellReuseIdentifier:kETEnterpriseServicesSwitchTableViewCellReuseID];
    [self.tableView registerClass:[ETEnterpriseServicesCheckTableViewCell class] forCellReuseIdentifier:kETEnterpriseServicesCheckTableViewCellReuseID];
    
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            [_tableView setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
        }
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.estimatedRowHeight = 0;
    }
    return _tableView;
}

- (UIView *)footerView {
    if (!_footerView) {
        CGFloat footerViewHeight = 140;
        _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, footerViewHeight)];
        _footerView.backgroundColor = kACColorRGBA(242, 242, 242, 1);
        CGFloat btnPublicHeight = 45;
        UIButton *btnPublic = [[UIButton alloc] initWithFrame:CGRectMake(15, (footerViewHeight - btnPublicHeight) * 0.5, Screen_Width - 30, btnPublicHeight)];
        [btnPublic setTitle:@"发布" forState:UIControlStateNormal];
        [btnPublic setTitleColor:kACColorWhite forState:UIControlStateNormal];
        btnPublic.backgroundColor = kACColorRGBA(47, 134, 251, 1);
        btnPublic.titleLabel.font = kFontSize(15);
        [btnPublic addTarget:self action:@selector(onClickBtnPublic:) forControlEvents:UIControlEventTouchUpInside];
        btnPublic.layer.masksToBounds = YES;
        btnPublic.layer.cornerRadius = 5;
        [_footerView addSubview:btnPublic];
    }
    return _footerView;
}

#pragma mark - onClickBtn
- (void)onClickBtnPublic:(UIButton *)sender {
    if (![SSJewelryCore isValidClick]) {
        return;
    }
    NSMutableDictionary *muDict = [NSMutableDictionary dictionary];
    [_arrMuSection enumerateObjectsUsingBlock:^(ETEnterpriseServicesViewModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableArray *arrCheckValue = [NSMutableArray array];
        [obj.list enumerateObjectsUsingBlock:^(ETEnterpriseServicesViewItemModel * _Nonnull mItem, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([mItem.key isEqualToString:@"serviceId"]) {
                NSNumber *trueValue = [ETEnterpriseServicesViewRequestModel serviceIdFromServiesKey:mItem.value];
                [muDict setValue:trueValue forKey:@"serviceId"];
            } else if ([mItem.key isEqualToString:@"taxId"]) {
                NSNumber *trueValue = [ETEnterpriseServicesViewRequestModel taxIdFromTaxKey:mItem.value];
                 [muDict setValue:trueValue forKey:@"taxId"];
            } else if ([mItem.key isEqualToString:@"PurchasingCity"]) {
                [muDict setValue:mItem.value forKey:@"cityId"];
                [muDict setValue:mItem.content forKey:@"cityName"];
                
            } else if ([mItem.key isEqualToString:@"accuratePush"]) {
                NSNumber *isopen = mItem.isOpen ? @(1) : @(0);
                [muDict setValue:isopen forKey:@"accuratePush"];
            } else if ([mItem.key isEqualToString:@"bank"]) {
                NSNumber *trueValue = [ETEnterpriseServicesViewRequestModel bankFromBankKey:mItem.value];
                [muDict setValue:trueValue forKey:@"bank"];
            } else if ([mItem.key isEqualToString:@"regUrl"]) {
                 NSNumber *trueValue = [ETEnterpriseServicesViewRequestModel remarksFromRemarkKey:mItem.value];
                [muDict setValue:trueValue forKey:@"regUrl"];
            } else if ([mItem.key isEqualToString:@"business"]) {
                if (mItem.isSelected) {
                    [arrCheckValue addObject:mItem.title];
                }
                NSLog(@"");
            } else if (mItem.cellType ==  ETEnterpriseServicesViewItemModelTypeCheck) {
                NSMutableArray *arrValue = [NSMutableArray array];
                [mItem.businessScopeList enumerateObjectsUsingBlock:^(ETEnterpriseServicesBusinessScopeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    [obj.list enumerateObjectsUsingBlock:^(ETEnterpriseServicesBusinessScopeModel * _Nonnull mItem, NSUInteger idx, BOOL * _Nonnull stop) {
                        if (mItem.isSelected) {
                            [arrValue addObject:mItem.name];
                        }
                    }];
                    
                }];
                NSString *trueValue = [arrValue componentsJoinedByString:@","];
                [muDict setValue:trueValue forKey:@"business"];
            }
            else {
                [muDict setValue:mItem.value forKey:mItem.key];
            }
            
        }];
        // 变更赋值
        if (arrCheckValue.count > 0) {
            NSString *trueValue = [arrCheckValue componentsJoinedByString:@","];
            [muDict setValue:trueValue forKey:@"detail"];
        }
        
    }];
    NSString *trueValue = [[MySingleton sharedMySingleton].scopes componentsJoinedByString:@","];
    [muDict setValue:trueValue forKey:@"scope"];
    [muDict setValue:@(2) forKey:@"releaseTypeId"];
    _dics=[NSDictionary new];
    _dics=[muDict mutableCopy];
    
    _mRequest = [ETEnterpriseServicesViewRequestModel mj_objectWithKeyValues:muDict];
    _mRequest.releaseTypeId = @(2);
    [self requestBusinessPublicWithModel:_mRequest];
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _arrMuSection.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ETEnterpriseServicesViewModel *mSeciton = _arrMuSection[section];
    return mSeciton.list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ETEnterpriseServicesViewModel *mSeciton = _arrMuSection[indexPath.section];
    ETEnterpriseServicesViewItemModel *mItem = mSeciton.list[indexPath.row];
    if (mItem.cellType == ETEnterpriseServicesViewItemModelTypeTitle) {
        ETEnterpriseServicesTitleTableViewCell *cell = (ETEnterpriseServicesTitleTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kETEnterpriseServicesTitleTableViewCellReuseID];
        [cell makeETEnterpriseServicesTitleTableViewCellWithModel:mItem];
        return cell;
    } else if (mItem.cellType == ETEnterpriseServicesViewItemModelTypePopList) {
        ETEnterpriseServicesPopListTableViewCell *cell = (ETEnterpriseServicesPopListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kETEnterpriseServicesPopListTableViewCellReuseID];
        cell.delegate = self;
        [cell makeETEnterpriseServicesPopListTableViewCellWithModel:mItem];
        return cell;
    } else if (mItem.cellType == ETEnterpriseServicesViewItemModelTypeScopeBusiness) {
        ETEnterpriseServicesScopeBusinessTableViewCell *cell = (ETEnterpriseServicesScopeBusinessTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kETEnterpriseServicesScopeBusinessTableViewCellReuseID];
        cell.delegate = self;
        [cell makeETEnterpriseServicesScopeBusinessTableViewCell:mItem indexPath:indexPath];
        return cell;
    } else if (mItem.cellType == ETEnterpriseServicesViewItemModelTypeSelect) {
        ETEnterpriseServicesSelectTableViewCell *cell = (ETEnterpriseServicesSelectTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kETEnterpriseServicesSelectTableViewCellReuseID];
        [cell makeETEnterpriseServicesSelectTableViewCellWithModel:mItem];
        return cell;
    } else if (mItem.cellType == ETEnterpriseServicesViewItemModelTypeAddress) {
        ETEnterpriseServicesAddressTableViewCell *cell = (ETEnterpriseServicesAddressTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kETEnterpriseServicesAddressTableViewCellReuseID];
        [cell makeETEnterpriseServicesAddressTableViewCellWithModel:mItem];
        return cell;
    } else if (mItem.cellType == ETEnterpriseServicesViewItemModelTypeSwitch) {
        ETEnterpriseServicesSwitchTableViewCell *cell = (ETEnterpriseServicesSwitchTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kETEnterpriseServicesSwitchTableViewCellReuseID];
        [cell makeETEnterpriseServicesSwitchTableViewCellWithModel:mItem];
        return cell;
    } else if (mItem.cellType == ETEnterpriseServicesViewItemModelTypeCheck) {
        ETEnterpriseServicesCheckTableViewCell *cell = (ETEnterpriseServicesCheckTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kETEnterpriseServicesCheckTableViewCellReuseID];
        [cell makeETEnterpriseServicesCheckTableViewCellWithModel:mItem];
        return cell;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ETEnterpriseServicesViewModel *mSeciton = _arrMuSection[indexPath.section];
    ETEnterpriseServicesViewItemModel *mItem = mSeciton.list[indexPath.row];
    if (mItem.cellheight == 0) {
        return 50;
    }
    if (mItem.cellType == ETEnterpriseServicesViewItemModelTypeScopeBusiness) {
        NSLog(@"businessHeight:%.2lf",mItem.cellheight);
    }
    return mItem.cellheight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ETEnterpriseServicesViewModel *mSeciton = _arrMuSection[indexPath.section];
    ETEnterpriseServicesViewItemModel *mItem = mSeciton.list[indexPath.row];
    WEAKSELF
    if (mItem.cellType == ETEnterpriseServicesViewItemModelTypeAddress) {
        [LQCityPicker showInView:self.view datas:[self loadAddressData] didSelectWithBlock:^(NSArray *objs, NSString *dsc) {
            mItem.content = dsc;
            ////获取cityid
            LQPickerItem* item=objs.lastObject;
            mItem.value = item.cid;
            [weakSelf.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        } cancelBlock:^{
            NSLog(@"cancel");
        }];
    }
}

- (NSArray*)loadAddressData {
   NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"dynamic_city.plist" ofType:nil]];
    NSArray *provinces = dic[@"data"][@"list"];
    NSMutableArray *arrMuProvince = [NSMutableArray array];
    for (NSDictionary *tmp in provinces) {
        // 创建第一级数据
        LQPickerItem *itemProvince = [[LQPickerItem alloc]init];
        NSString *provinceName = tmp[@"name"];
        itemProvince.name = provinceName;
        NSArray *arr = tmp[@"list"];
        // 配置第二级数据
        [itemProvince loadData:arr.count config:^(LQPickerItem *item, NSInteger index) {
            NSDictionary *cidDict = arr[index];
            item.name = cidDict[@"name"];
            item.cid = cidDict[@"cid"];
        }];
        
        [arrMuProvince addObject:itemProvince];
    }
    return arrMuProvince;
}

#pragma mark - ETEnterpriseServicesPopListTableViewCell
- (void)enterpriseServicesPopListTableViewCell:(ETEnterpriseServicesPopListTableViewCell *)enterpriseServicesPopListTableViewCell selectPopViewListWithModel:(ETEnterpriseServicesViewItemModel *)mItem {
    if ([mItem.key isEqualToString:ServicesTypeKey]) {
        
        ETEnterpriseServicesViewDataModel *mEnterprise = [ETEnterpriseServicesViewDataModel loadDataSourceETEnterpriseServicesViewDataModelWithServiceTypeKey:mItem.value arrOldData:_arrMuSection];
        [_arrMuSection removeAllObjects];
        [_arrMuSection addObjectsFromArray:mEnterprise.arrEnterpriseServicesViewData];
        
    } if ([mItem.key isEqualToString:PurchasingTypeKey]) {
        
        ETEnterpriseServicesViewModel *mSection = _arrMuSection.firstObject;
        __block NSString *serviceTypeKey = nil;
        [mSection.list enumerateObjectsUsingBlock:^(ETEnterpriseServicesViewItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.key isEqualToString:ServicesTypeKey]) {
                serviceTypeKey = obj.content;
                *stop = YES;
            }
        }];
        ETEnterpriseServicesViewDataModel *mEnterprise = [ETEnterpriseServicesViewDataModel loadDataSourceETEnterpriseServicesViewDataModelWithServiceTypeKey:serviceTypeKey purchaseMattersKey:mItem.value arrOldData:_arrMuSection];
        [_arrMuSection removeAllObjects];
        [_arrMuSection addObjectsFromArray:mEnterprise.arrEnterpriseServicesViewData];
    }
    
   
   
    WEAKSELF
    [weakSelf.arrMuSection enumerateObjectsUsingBlock:^(ETEnterpriseServicesViewModel*  _Nonnull sectionModel, NSUInteger idx, BOOL * _Nonnull stop) {
        [sectionModel.list enumerateObjectsUsingBlock:^(ETEnterpriseServicesViewItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.cellType == ETEnterpriseServicesViewItemModelTypeScopeBusiness) {
                if (!obj.businessScopeList) {
                    [weakSelf requestBusinessScope];
                }
                else{
                    NSArray * sectionArrList = obj.businessScopeList;
                    NSMutableArray *arruMuModel = [NSMutableArray array];
                    [sectionArrList enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        ETEnterpriseServicesBusinessScopeModel *section = [ETEnterpriseServicesBusinessScopeModel mj_objectWithKeyValues:obj];
                        NSMutableArray *arruMuItemModel = [NSMutableArray array];
                        [section.list enumerateObjectsUsingBlock:^(ETEnterpriseServicesBusinessScopeModel * _Nonnull mItemDict, NSUInteger idx, BOOL * _Nonnull stop) {
                            if ([mItemDict isKindOfClass:[NSDictionary class]]) {
                                ETEnterpriseServicesBusinessScopeModel *mItem = [ETEnterpriseServicesBusinessScopeModel mj_objectWithKeyValues:mItemDict];
                                [arruMuItemModel addObject:mItem];
                            }
                        }];
                        section.list = arruMuItemModel;
                        [arruMuModel addObject:section];
                    }];
                    obj.businessScopeList = arruMuModel;
                    *stop = YES;
                }
                
            }
        }];
    }];
    
    [_tableView reloadData];
}

#pragma mark - ETEnterpriseServicesScopeBusinessTableViewCellDelegate
- (void)enterpriseServicesScopeBusinessTableViewCell:(ETEnterpriseServicesScopeBusinessTableViewCell *)enterpriseServicesScopeBusinessTableViewCell model:(ETEnterpriseServicesViewItemModel *)mItem indexPath:(NSIndexPath *)indexPath {
    [_tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - 请求经营范围
- (void)requestBusinessScope {
    [HttpTool get:[NSString stringWithFormat:@"business/getBusinessList"] params:nil success:^(id responseObj) {
        NSString *code = [responseObj objectForKey:@"code"];
        if (code.integerValue == 0) {
            NSDictionary *dataDict = [responseObj objectForKey:@"data"];
            NSArray *firstArrList = [dataDict objectForKey:@"list"];
            NSDictionary *listDict = firstArrList.firstObject;
            NSArray * sectionArrList = [listDict objectForKey:@"list"];
            NSMutableArray *arruMuModel = [NSMutableArray array];
            [sectionArrList enumerateObjectsUsingBlock:^(NSDictionary *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                ETEnterpriseServicesBusinessScopeModel *section = [ETEnterpriseServicesBusinessScopeModel mj_objectWithKeyValues:obj];
                NSMutableArray *arruMuItemModel = [NSMutableArray array];
                [section.list enumerateObjectsUsingBlock:^(ETEnterpriseServicesBusinessScopeModel * _Nonnull mItemDict, NSUInteger idx, BOOL * _Nonnull stop) {
                    if ([mItemDict isKindOfClass:[NSDictionary class]]) {
                        ETEnterpriseServicesBusinessScopeModel *mItem = [ETEnterpriseServicesBusinessScopeModel mj_objectWithKeyValues:mItemDict];
                        [arruMuItemModel addObject:mItem];
                    }
                }];
                section.list = arruMuItemModel;
                [arruMuModel addObject:section];
            }];
            WEAKSELF
            [weakSelf.arrMuSection enumerateObjectsUsingBlock:^(ETEnterpriseServicesViewModel*  _Nonnull sectionModel, NSUInteger idx, BOOL * _Nonnull stop) {
                [sectionModel.list enumerateObjectsUsingBlock:^(ETEnterpriseServicesViewItemModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    if (obj.cellType == ETEnterpriseServicesViewItemModelTypeScopeBusiness) {
                        obj.businessScopeList = arruMuModel;
                        *stop = YES;
                    }
                }];
            }];
            
            [weakSelf.tableView reloadData];
        }
    } failure:^(NSError *error) {
        
    }];
}
#pragma mark - 请求发布的接口
- (void)requestBusinessPublicWithModel:(ETEnterpriseServicesViewRequestModel *)mRequest {
    [HttpTool post:@"release/buyService" params:_dics success:^(id responseObj) {
//        if (code.integerValue == 0) {
//            AMLog(@"发布成功");
//            [MBProgressHUD showSuccess:@"分享成功" toView:[UIApplication sharedApplication].keyWindow.rootViewController.view ];
//        }
        
        NSString *code = responseObj[@"code"];
        if (code.integerValue == 0)  {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self cancelClick];
                [MBProgressHUD showSuccess:@"发布成功" toView:self.view];
                [[NSNotificationCenter defaultCenter]postNotificationName:FaBuChengGongRefresh_Mine object:nil];
            });
        }
        else{
            UIAlertView* alert=[[UIAlertView alloc] initWithTitle:@"提示" message:responseObj[@"msg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    } failure:^(NSError *error) {
        AMLog(@"发布失败");
        [MBProgressHUD showError:@"发布失败" toView:[UIApplication sharedApplication].keyWindow.rootViewController.view ];
    }];
}
//取消按钮点击方法
-(void)cancelClick{
//    [self finishPublish];
    if (self.block) {
        self.block();
    }
}

#pragma mark - 完成发布
//完成发布
-(void)finishPublish{
    //2.block传值
//    if (self.mDismissBlock != nil) {
//        self.mDismissBlock();
//    }
    [self dismissViewControllerAnimated:YES completion:nil];
//    if (_product) {
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }
}

@end
