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
@property (nonatomic, strong) UILabel *labTitle;
@property (nonatomic, strong) UIImageView *imgvArrow;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *arrMuBusiness;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) ETEnterpriseServicesViewItemModel *mItem;
//@property (nonatomic, strong) NSMutableArray *arrMuSelected;

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
    
    _mItem = mItem;
    _indexPath = indexPath;
    _labTitle.text = mItem.title;
    CGFloat titlewWidth = [_labTitle.text ak_sizeWithFontEX:_labTitle.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, 15)].width;
    titlewWidth = titlewWidth > 100 ? 100 : titlewWidth;
    [_labTitle mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(titlewWidth);
    }];
    
    [_arrMuBusiness removeAllObjects];
    [_arrMuBusiness addObjectsFromArray:mItem.businessScopeList];
    
    [self.tableView reloadData];
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
        _mItem.cellheight = height + 50;
    } else {
        _mItem.cellheight = 50;
    }
    [self updateImgvSelectedIsOpen:_mItem.isOpen];
}

#pragma mark - createSubViewsAndConstraints
- (void)createSubViewsAndConstraints {
    
    UIView *vContainer = [[UIView alloc] init];
    [self.contentView addSubview:vContainer];
    [vContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(0);
        make.width.mas_equalTo(Screen_Width);
        make.top.equalTo(self.contentView);
        make.height.mas_equalTo(50);
    }];
    
    _imgvArrow = [[UIImageView alloc] init];
    UIImage *imgArrow = [UIImage imageNamed:@"arrow_right"];
    _imgvArrow.image = imgArrow;
    [vContainer addSubview:_imgvArrow];
    [_imgvArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.trailing.mas_equalTo(-15);
        make.centerY.equalTo(vContainer);
        make.size.mas_equalTo(imgArrow.size);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onClickSectionView:)];
    [vContainer addGestureRecognizer:tap];
    
    _labTitle = [[UILabel alloc] init];
    _labTitle.textColor = kACColorRGB(51, 51, 51);
    _labTitle.font = kFontSize(15);
    [vContainer addSubview:_labTitle];
    [_labTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(15);
        make.width.mas_equalTo(60);
        make.centerY.equalTo(vContainer);
        make.height.mas_equalTo(15);
    }];
    
    [self.contentView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(vContainer.mas_bottom);
        make.leading.trailing.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    
    [self.tableView registerClass:[ETEnterpriseServicesScopeBusinessItemTableViewCell class] forCellReuseIdentifier:kETEnterpriseServicesScopeBusinessItemTableViewCellReuseID];
    [self.tableView registerClass:[ETEnterpriseServicesScopeBusinessSectionHeaderView class] forHeaderFooterViewReuseIdentifier:kETEnterpriseServicesScopeBusinessSectionHeaderViewReuseID];
}



- (void)updateImgvSelectedIsOpen:(BOOL)isOpen {
    UIImage *imgArrow = nil;
    if (isOpen) {
        imgArrow = [UIImage imageNamed:@"arrow_top"];
    } else {
        imgArrow = [UIImage imageNamed:@"arrow_right"];
    }
    _imgvArrow.image = imgArrow;
    [_imgvArrow mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(imgArrow.size);
    }];
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
