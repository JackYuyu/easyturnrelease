//
//  ETHomeLocationController.m
//  EasyTurn
//
//  Created by 程立 on 2019/7/27.
//  Copyright © 2019 EasyTurn. All rights reserved.
//

#import "ETHomeLocationController.h"
#import "ETHomeTopView.h"
#import "ETHomeHeaderView1.h"
#import "JMColumnMenuCell.h"
#import "JMColumnMenuHeaderView.h"
#import "JMColumnMenuFooterView.h"
#import "AticleMenu.h"

#define CELLID @"CollectionViewCell"
#define HEADERID @"headerId"
#define FOOTERID @"footerId"
@interface ETHomeLocationController ()<UITableViewDelegate, UITableViewDataSource, ETHomeHeaderViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) ETHomeTopView *vHomeTop;
@property (nonatomic, strong) ETHomeHeaderView1 *vHomeHeader;
@property (nonatomic, strong) UITableView *tbHome;

/** 导航栏的view */
@property (nonatomic, weak) UIView *navView;
/** navTitle */
@property (nonatomic, weak) UILabel *navTitle;
/** navColseBtn */
@property (nonatomic, weak) UIButton *navCloseBtn;
/** tags */
@property (nonatomic, strong) NSMutableArray *tagsArrM;
/** others */
@property (nonatomic, strong) NSMutableArray *otherArrM;
/** CollectionView */
@property (nonatomic, weak) UICollectionView *collectionView;
/** 头部视图 */
@property (nonatomic, weak) JMColumnMenuHeaderView *headerView;
/** 头部视图1 */
@property (nonatomic, weak) JMColumnMenuFooterView *footerView;
/** 长按手势 */
@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;
/** 引用headView编辑字符串 */
@property (nonatomic, copy) NSString *editBtnStr;
@end

@implementation ETHomeLocationController

- (NSMutableArray *)tagsArrM {
    if (!_tagsArrM) {
        _tagsArrM = [NSMutableArray array];
    }
    return _tagsArrM;
}

- (NSMutableArray *)otherArrM {
    if (!_otherArrM) {
        _otherArrM = [NSMutableArray array];
    }
    return _otherArrM;
}
- (UITableView *)tbHome {
    if (!_tbHome) {
        _tbHome = [[UITableView alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + 65, Screen_Width, Screen_Height - kStatusBarHeight - 65) style:UITableViewStylePlain];
        _tbHome.showsVerticalScrollIndicator = NO;
        _tbHome.backgroundColor = kACColorRed;
//        _tbHome.delegate = self;
//        _tbHome.dataSource = self;
        _vHomeHeader = [[ETHomeHeaderView1 alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 327)];
        _vHomeHeader.delegate = self;
        _tbHome.tableHeaderView = _vHomeHeader;
        _tbHome.tableFooterView = [[UIView alloc]init];
    }
    return _tbHome;
}

- (void)viewWillAppear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:YES animated:TRUE];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:NO animated:TRUE];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray* a= @[@"上海市",@"杭州市",@"北京市",@"广州市",@"天津市",@"南京市"];
    NSArray* b= @[@"鞍山",@"阿拉善盟",@"安达",@"安庆",@"安丘",@"安阳"];

    NSMutableArray *arr1 = [NSMutableArray new];
    NSMutableArray *arr2 = [NSMutableArray new];
    for (int i=0; i<6; i++) {
        AticleMenu* memu=[AticleMenu new];
        memu.Text=[a objectAtIndex:i];
        [arr1 addObject:memu];
    }
    
    for (int i=0; i<6; i++) {
        AticleMenu* memu=[AticleMenu new];
        memu.Text=[b objectAtIndex:i];
        [arr2 addObject:memu];
    }
    self.type = JMColumnMenuTypeTouTiao1;
//    self.delegate = delegate;
    self.editBtnStr = @"编辑";
    self.tagsArrM = arr1;
    self.otherArrM = arr2;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor xm_colorFromRGB:0xf6f6f6];
    
    [self createSubViewsAndConstraints];
    
    [self initColumnMenuUI];
}

#pragma mark - createSubViewsAndConstraints
- (void)createSubViewsAndConstraints {
    
    _vHomeTop = [[ETHomeTopView alloc]init];
    _vHomeTop.block = ^{
        NSLog(@"");
    };
    [self.view addSubview:_vHomeTop];
    [_vHomeTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(kStatusBarHeight + 75);
    }];
    
//    [self.view addSubview:self.tbHome];
    
}
#pragma mark - 初始化UI
- (void)initColumnMenuUI {
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, kNavigationBarHeight)];
    navView.backgroundColor = [UIColor whiteColor];
    self.navView = navView;
//    [self.view addSubview:navView];
    
    UILabel *navTitle = [[UILabel alloc] initWithFrame:CGRectMake(self.navView.centerX - 100, kStatusBarHeight, 200, 44)];
    navTitle.text = @"频道定制";
    navTitle.textAlignment = NSTextAlignmentCenter;
    navTitle.textColor = [UIColor xm_jetblackColor];
    navTitle.font = [UIFont systemFontOfSize:17.0];
    self.navTitle = navTitle;
//    [self.navView addSubview:navTitle];
    
    UIButton *navCloseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    navCloseBtn.frame = CGRectMake(self.navView.width - 44, kStatusBarHeight, 44, 44);
    
    [navCloseBtn setImage:[UIImage imageNamed:@"filter_delete"] forState:UIControlStateNormal];
    self.navCloseBtn = navCloseBtn;
    [navCloseBtn addTarget:self action:@selector(navCloseBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    [self.navView addSubview:navCloseBtn];
    
    CGFloat f=CGRectGetMaxY(self.vHomeTop.frame);
    _vHomeHeader = [[ETHomeHeaderView1 alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + 75-kStatusBarHeight, self.view.width, 127)];
    _vHomeHeader.delegate = self;
    [self.view addSubview:_vHomeHeader];
    
    //视图布局对象
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 10, 0);
    
    //UICollectionView
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.vHomeHeader.frame), self.view.width, self.view.height - self.vHomeTop.height - self.vHomeHeader.height) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor xm_colorFromRGB:0xf6f6f6];
    self.collectionView = collectionView;
    [self.view addSubview:self.collectionView];
    
    //注册cell
    [self.collectionView registerClass:[JMColumnMenuCell class] forCellWithReuseIdentifier:CELLID];
    [self.collectionView registerClass:[JMColumnMenuHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HEADERID];
    [self.collectionView registerClass:[JMColumnMenuFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:FOOTERID];
    
    //添加长按的手势
    self.longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPress:)];
    //    if (self.type == JMColumnMenuTypeTencent) {
    [self.collectionView addGestureRecognizer:self.longPress];
    //    }
    
}

#pragma mark - 手势识别
- (void)longPress:(UIGestureRecognizer *)longPress {
    if ([self.editBtnStr containsString:@"编辑"] && self.type == JMColumnMenuTypeTouTiao1) {
        self.editBtnStr = @"完成";
        for (int i = 0; i < self.tagsArrM.count; i++) {
            AticleMenu *model = self.tagsArrM[i];
            if (i != 0 && i != 1) {
                model.isEditing = YES;
            }
        }
        //        NSIndexPath *indexPath = [NSIndexPath]
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:0];
        [self.collectionView reloadSections:indexSet];
        //        [self.collectionView reloadData];
    }
    //    NSLog(@"长按手势开始");
    //获取点击在collectionView的坐标
    CGPoint point=[longPress locationInView:self.collectionView];
    //从长按开始
    NSIndexPath *indexPath=[self.collectionView indexPathForItemAtPoint:point];
    //判断是否可以移动
    //    if (indexPath.item == 0) {
    //        return;
    //    }
    
    
    if (longPress.state == UIGestureRecognizerStateBegan) {
        if (indexPath.section == 0 && (indexPath.item == 0 ||indexPath.item == 1)) {
            return;
        }
        [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
        //长按手势状态改变
        //        NSLog(@"开始");
    } else if(longPress.state==UIGestureRecognizerStateChanged) {
        if (indexPath.section == 0 && (indexPath.item == 0 || indexPath.item == 1)) {
            return;
        }
        //        NSLog(@"改变");
        [self.collectionView updateInteractiveMovementTargetPosition:point];
        //长按手势结束
    } else if (longPress.state==UIGestureRecognizerStateEnded) {
        //        NSLog(@"结束");
        [self.collectionView endInteractiveMovement];
        //其他情况
    } else {
        [self.collectionView cancelInteractiveMovement];
    }
}


#pragma mark - UICollectionViewDataSource
//一共有多少组
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.otherArrM) {
        return 2;
    } else {
        return 1;
    }
}

//每一组有多少个cell
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return self.tagsArrM.count;
    } else {
        return self.otherArrM.count;
    }
}

//每一个cell的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    JMColumnMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CELLID forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        cell.model = self.tagsArrM[indexPath.item];
        if (indexPath.item == 0 || indexPath.item == 1) { //第一个按钮样式区别
            cell.title.textColor = [UIColor xm_MainColor];
        }else{
            cell.title.textColor = [UIColor xm_middleColor];
        }
    } else {
        cell.title.textColor = [UIColor xm_middleColor];
        cell.model = self.otherArrM[indexPath.item];
    }
    
    //关闭按钮点击事件
    cell.closeBtn.tag = indexPath.item;
    [cell.closeBtn addTarget:self action:@selector(colseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

//和tableView差不多, 可设置头部和尾部
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        JMColumnMenuHeaderView *headerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:HEADERID forIndexPath:indexPath];
        if (indexPath.section == 0) {
            headerView.titleStr = @"热门城市";
            headerView.detailStr = @"长按可拖动排序";
            if (self.type == JMColumnMenuTypeTouTiao1) {
                [headerView.editBtn setTitle:self.editBtnStr forState:UIControlStateNormal];
                headerView.editBtn.hidden = NO;
                [headerView.editBtn addTarget:self action:@selector(headViewEditBtnClick) forControlEvents:UIControlEventTouchUpInside];
            }
        }
        self.headerView = headerView;
        return headerView;
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        JMColumnMenuFooterView *footerView = [self.collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:FOOTERID forIndexPath:indexPath];
        if (indexPath.section == 0) {
            footerView.titleStr = @"未选频道";
            footerView.detailStr = @"点击添加至已选频道";
        }
        self.footerView = footerView;
        return footerView;
    }
    return nil;
}

#pragma mark - 头部编辑按钮点击事件
- (void)headViewEditBtnClick {
    if ([self.editBtnStr containsString:@"编辑"]) {
        self.editBtnStr = @"完成";
        [self.headerView.editBtn setTitle:@"完成" forState:UIControlStateNormal];
        
        //        [self.collectionView addGestureRecognizer:self.longPress];
        
        for (int i = 0; i < self.tagsArrM.count; i++) {
            AticleMenu *model = self.tagsArrM[i];
            if (i == 0 || i == 1) {
                model.isEditing = NO;
            } else {
                model.isEditing = YES;
            }
        }
    } else {
        self.editBtnStr = @"编辑";
        [self.headerView.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
        
        //        [self.collectionView removeGestureRecognizer:self.longPress];
        
        for (int i = 0; i < self.tagsArrM.count; i++) {
            AticleMenu *model = self.tagsArrM[i];
            if (i == 0 || i == 1) {
                model.isEditing = NO;
            } else {
                model.isEditing = NO;
            }
        }
    }
    [self.collectionView reloadData];
}

//每一个分组的上左下右间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 10, 4, 10);
}

//头部视图的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return CGSizeMake(self.view.width, 40);
    } else {
        return CGSizeMake(0, 0);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(self.view.width, 40);
    } else {
        return CGSizeMake(0, 0);
    }
}

//定义每一个cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(self.collectionView.width * 0.25 - 10, 53);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 4;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}

//cell的点击事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AticleMenu *model;
    if (indexPath.section == 0) {
        model = self.tagsArrM[indexPath.item];
        //判断是否是编辑状态
        if ([self.editBtnStr containsString:@"编辑"]) {
            //判断是否是头条,是就直接回调出去
//            if ([self.delegate respondsToSelector:@selector(columnMenuDidSelectTitle:Index:)]) {
//                [self.delegate columnMenuDidSelectTitle:model.Text Index:indexPath.item];
//            }
//            [self navCloseBtnClick];
            return;
        }
        
        //判断是否可以删除
        if (model.resident) {
            return;
        }
        model.selected = NO;
        model.isEditing = NO;
        model.showAdd = YES;
        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        
        [self.tagsArrM removeObjectAtIndex:indexPath.item];
        [self.otherArrM insertObject:model atIndex:0];
        
        NSIndexPath *targetIndexPage = [NSIndexPath indexPathForItem:0 inSection:1];
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:targetIndexPage];
    } else if (indexPath.section == 1) {
        JMColumnMenuCell *cell = (JMColumnMenuCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.closeBtn.hidden = YES;
        model  = self.otherArrM[indexPath.item];
        
        if ([self.editBtnStr containsString:@"编辑"]) {
            model.isEditing = NO;
        } else {
            model.isEditing = YES;
        }
        model.showAdd = NO;
        model.selected = YES;
        model.isEditing = YES;
        [collectionView reloadItemsAtIndexPaths:@[indexPath]];
        [self.otherArrM removeObjectAtIndex:indexPath.item];
        [self.tagsArrM addObject:model];
        
        NSIndexPath *targetIndexPage = [NSIndexPath indexPathForItem:self.tagsArrM.count-1 inSection:0];
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:targetIndexPage];
    }
    
    [self refreshDelBtnsTag];
//    [self updateBlockArr];
}

#pragma mark - item关闭按钮点击事件
- (void)colseBtnClick:(UIButton *)sender {
    AticleMenu *model = self.tagsArrM[sender.tag];
    model.selected = NO;
    model.isEditing = NO;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
    [self.tagsArrM removeObjectAtIndex:sender.tag];
    [self.otherArrM insertObject:model atIndex:0];
    
    NSIndexPath *targetIndexPage = [NSIndexPath indexPathForItem:0 inSection:1];
    [self.collectionView moveItemAtIndexPath:indexPath toIndexPath:targetIndexPage];
    
    [self refreshDelBtnsTag];
//    [self updateBlockArr];
}

//在开始移动是调动此代理方法
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
    //    NSLog(@"开始移动");
    if (indexPath.section == 0) {
        if (indexPath.row == 0 || indexPath.row == 1) {
            return NO;
        }
    }
    return YES;
}

//在移动结束的时候调用此代理方法
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    //    NSLog(@"结束移动");
    
    AticleMenu *model;
    if (sourceIndexPath.section == 0) {
        model = self.tagsArrM[sourceIndexPath.item];
        [self.tagsArrM removeObjectAtIndex:sourceIndexPath.item];
    } else {
        model = self.otherArrM[sourceIndexPath.item];
        [self.otherArrM removeObjectAtIndex:sourceIndexPath.item];
    }
    
    if (destinationIndexPath.section == 0) {
        model.isEditing = YES;
        [self.tagsArrM insertObject:model atIndex:destinationIndexPath.item];
        NSLog(@"destinationIndexPath.item == %ld",(long)destinationIndexPath.item);
    } else if (destinationIndexPath.section == 1) {
        model.isEditing = NO;
        [self.otherArrM insertObject:model atIndex:destinationIndexPath.item];
    }
    
    [collectionView reloadItemsAtIndexPaths:@[destinationIndexPath]];
    
    [self refreshDelBtnsTag];
//    [self updateBlockArr];
}

#pragma mark - 刷新tag
- (void)refreshDelBtnsTag {
    for (JMColumnMenuCell *cell in self.collectionView.visibleCells) {
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
        cell.closeBtn.tag = indexPath.item;
    }
}
@end
