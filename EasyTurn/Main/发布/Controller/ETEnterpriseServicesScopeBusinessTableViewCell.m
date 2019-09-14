//
//  ETEnterpriseServicesScopeBusinessTableViewCell.m
//  EasyTurn
//
//  Created by 程立 on 2019/9/7.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETEnterpriseServicesScopeBusinessTableViewCell.h"
#import "ETEnterpriseServicesViewModel.h"
#import "ETEnterpriseServicesScopeBusinessSectionHeaderView.h"
#import "ETEnterpriseServicesScopeBusinessItemTableViewCell.h"
#import "ETEnterpriseServicesBusinessScopeModel.h"

static NSString * const kETEnterpriseServicesScopeBusinessItemTableViewCellReuseID = @"ETEnterpriseServicesScopeBusinessItemTableViewCell";
static NSString * const kETEnterpriseServicesScopeBusinessSectionHeaderViewReuseID = @"ETEnterpriseServicesScopeBusinessSectionHeaderView";

@interface ETEnterpriseServicesScopeBusinessTableViewCell ()<UITableViewDataSource, UITableViewDelegate, ETEnterpriseServicesScopeBusinessSectionHeaderViewDelegate, ETEnterpriseServicesScopeBusinessItemTableViewCellDelegate>
@property (nonatomic, strong) UIView *vContainer;
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UILabel *lbContent;
@property (nonatomic, strong) UIButton *btn_confirm;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrMuBusiness;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) ETEnterpriseServicesViewItemModel *mItem;
@end

@implementation ETEnterpriseServicesScopeBusinessTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self createSubViewsAndConstraints];
        _arrMuBusiness = [NSMutableArray array];
//        _arrMuSelected = [NSMutableArray array];
    }
    return self;
}

- (void)makeETEnterpriseServicesScopeBusinessTableViewCell:(ETEnterpriseServicesViewItemModel *)mItem indexPath:(NSIndexPath *)indexPath {
    WeakSelf(self)
    _mItem = mItem;
    _indexPath = indexPath;
    _labTitle.text = mItem.title;
    [self updateContentInfo];
    CGFloat titlewWidth = [_labTitle.text ak_sizeWithFontEX:_labTitle.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 15)].width;
    titlewWidth = titlewWidth > 100 ? 100 : titlewWidth;
    [_labTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(titlewWidth);
    }];
    
    [_arrMuBusiness removeAllObjects];
    [_arrMuBusiness addObjectsFromArray:mItem.businessScopeList];
    
    [self.tableView reloadData];
    
    CGFloat default_height = 50;
    if ([MySingleton sharedMySingleton].scopes.count) {
        default_height = [self.lbContent sizeThatFits:CGSizeMake(SCREEN_WIDTH - 170, MAXFLOAT)].height;
    }
    
    [self.vContainer mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.width.mas_equalTo(Screen_Width);
        make.top.equalTo(weakself.contentView);
        make.height.mas_equalTo(default_height);
    }];
    
    if (_mItem.isOpen) {
        __block CGFloat height = 0;
        [_arrMuBusiness enumerateObjectsUsingBlock:^(ETEnterpriseServicesBusinessScopeModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.isOpen) {
                height += obj.cellheight;
            } else {
                height += 45;
            }
            if (obj.isOpen) {
                [obj.list enumerateObjectsUsingBlock:^(ETEnterpriseServicesBusinessScopeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    height += obj.cellheight;
                }];
            }
        }];
        _mItem.cellheight = height + default_height;
    } else {
        _mItem.cellheight = default_height;
    }
    [self updateImgvSelectedIsOpen:_mItem.isOpen];
}

#pragma mark - createSubViewsAndConstraints
- (void)createSubViewsAndConstraints {
    WeakSelf(self)
    
    _vContainer = [[UIView alloc] init];
    [self.contentView addSubview:_vContainer];
    [_vContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.width.mas_equalTo(Screen_Width);
        make.top.equalTo(weakself.contentView);
        make.height.mas_equalTo(50);
    }];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickSectionView:)];
    [_vContainer addGestureRecognizer:tap];
    
    _labTitle = [[UILabel alloc] init];
    _labTitle.textColor = kACColorRGB(51, 51, 51);
    _labTitle.font = kFontSize(15);
    [_vContainer addSubview:_labTitle];
    [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.width.mas_equalTo(60);
        make.centerY.equalTo(weakself.vContainer);
        make.height.mas_equalTo(15);
    }];
    
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakself.vContainer.mas_bottom);
        make.leading.trailing.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    _btn_confirm = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [_btn_confirm setTitle:@"确定" forState:(UIControlStateNormal)];
    _btn_confirm.titleLabel.font = [UIFont systemFontOfSize:16];
    [_btn_confirm setTitleColor:[UIColor darkGrayColor] forState:(UIControlStateNormal)];
    [_btn_confirm addTarget:self action:@selector(confirm:) forControlEvents:(UIControlEventTouchUpInside)];
    [_vContainer addSubview:_btn_confirm];
    [_btn_confirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-15);
        make.centerY.equalTo(weakself.vContainer);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    _lbContent = [UILabel new];
    _lbContent.numberOfLines = 0;
    _lbContent.font = [UIFont systemFontOfSize:15];
    _lbContent.textColor = [UIColor lightGrayColor];
    _lbContent.text = @"点击进行选择";
    [_vContainer addSubview:_lbContent];
    [_lbContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.labTitle.mas_right).offset(15);
        make.right.equalTo(weakself.btn_confirm.mas_left).offset(-15);
        make.top.bottom.equalTo(weakself.vContainer);
    }];
    
    [self.tableView registerClass:[ETEnterpriseServicesScopeBusinessItemTableViewCell class] forCellReuseIdentifier:kETEnterpriseServicesScopeBusinessItemTableViewCellReuseID];
    [self.tableView registerClass:[ETEnterpriseServicesScopeBusinessSectionHeaderView class] forHeaderFooterViewReuseIdentifier:kETEnterpriseServicesScopeBusinessSectionHeaderViewReuseID];
}

#pragma mark - 点击进行选择
- (void)confirm:(UIButton *)btn{
    [self updateContentInfo];
    _mItem.isOpen = !_mItem.isOpen;
    if ([_delegate respondsToSelector:@selector(enterpriseServicesScopeBusinessTableViewCell:model:indexPath:)]) {
        [_delegate enterpriseServicesScopeBusinessTableViewCell:self model:_mItem indexPath:_indexPath];
    }
}

- (void)updateContentInfo{
    if ([MySingleton sharedMySingleton].scopes.count) {
        self.lbContent.textColor = [UIColor blackColor];
        self.lbContent.text = [[MySingleton sharedMySingleton].scopes componentsJoinedByString:@";"];
    }else{
        self.lbContent.textColor = [UIColor lightGrayColor];
        self.lbContent.text = @"点击进行选择";
    }
    self.btn_confirm.hidden = !_mItem.isOpen;
}

- (void)updateImgvSelectedIsOpen:(BOOL)isOpen {
    NSLog(@"%@",isOpen ? @"打开" : @"关闭");
}
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _arrMuBusiness.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ETEnterpriseServicesBusinessScopeModel *mSection = _arrMuBusiness[section];
    if (mSection.isOpen) {
        return mSection.list.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ETEnterpriseServicesScopeBusinessItemTableViewCell *cell = (ETEnterpriseServicesScopeBusinessItemTableViewCell *)[tableView dequeueReusableCellWithIdentifier:kETEnterpriseServicesScopeBusinessItemTableViewCellReuseID];
    ETEnterpriseServicesBusinessScopeModel *mSection = _arrMuBusiness[indexPath.section];
    ETEnterpriseServicesBusinessScopeModel *mItem = mSection.list[indexPath.row];
    cell.delegate = self;
    mItem.isSelected = [[MySingleton sharedMySingleton].scopes containsObject:mItem.name];
    [cell makeETEnterpriseServicesScopeBusinessItemTableViewCellWithModel:mItem];
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    ETEnterpriseServicesBusinessScopeModel *mSection = _arrMuBusiness[section];
    ETEnterpriseServicesScopeBusinessSectionHeaderView *headView = (ETEnterpriseServicesScopeBusinessSectionHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:kETEnterpriseServicesScopeBusinessSectionHeaderViewReuseID];
    headView.delegate = self;
    headView.contentView.backgroundColor = [UIColor whiteColor];
    [headView makeETEnterpriseServicesScopeBusinessSectionHeaderViewWithModel:mSection section:section];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ETEnterpriseServicesBusinessScopeModel *mSection = _arrMuBusiness[indexPath.section];
    ETEnterpriseServicesBusinessScopeModel *mItem = mSection.list[indexPath.row];
    return mItem.cellheight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

#pragma mark - ETEnterpriseServicesScopeBusinessItemTableViewCellDelegate
- (void)enterpriseServicesScopeBusinessItemTableViewCell:(ETEnterpriseServicesScopeBusinessItemTableViewCell *)enterpriseServicesScopeBusinessItemTableViewCell model:(ETEnterpriseServicesBusinessScopeModel *)mItem {
//    if ([_arrMuSelected containsObject:mItem.name]) {
//         [_arrMuSelected removeObject:mItem.name];
//    } else {
//        [_arrMuSelected addObject:mItem.name];
//    }
   
}

#pragma mark - onClickBtn
- (void)onClickSectionView:(UIGestureRecognizer *)gesture {
    if (![SSJewelryCore isValidClick]) {
        return;
    }
    _mItem.isOpen = !_mItem.isOpen;
    if ([_delegate respondsToSelector:@selector(enterpriseServicesScopeBusinessTableViewCell:model:indexPath:)]) {
        [_delegate enterpriseServicesScopeBusinessTableViewCell:self model:_mItem indexPath:_indexPath];
    }
}

#pragma mark - ETEnterpriseServicesBusinessScopeModelDelegate
- (void)enterpriseServicesScopeBusinessSectionHeaderView:(UITableViewHeaderFooterView *)enterpriseServicesScopeBusinessSectionHeaderView model:(ETEnterpriseServicesBusinessScopeModel *)mItem section:(NSInteger)section {
   
    _mItem.reloadSection = section;
    
    if ([_delegate respondsToSelector:@selector(enterpriseServicesScopeBusinessTableViewCell:model:indexPath:)]) {
        [_delegate enterpriseServicesScopeBusinessTableViewCell:self model:_mItem indexPath:_indexPath];
    }
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

@end
