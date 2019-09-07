//
//  FBSearchViewController.m
//  Fireball
//
//  Created by 任长平 on 2017/12/8.
//  Copyright © 2017年 任长平. All rights reserved.
//

#import "FBSearchViewController.h"
#import "CXSearchSectionModel.h"
#import "CXSearchModel.h"
#import "CXSearchCollectionViewCell.h"
#import "SelectCollectionReusableView.h"
#import "SelectCollectionLayout.h"
#import "CXDBHandle.h"
#import "SearchResultViewController.h"
#import "ETHomeTopView1.h"
#import "ETHomeHeaderView1.h"
#import "FBBaseModel.h"

static NSString *const cxSearchCollectionViewCell = @"CXSearchCollectionViewCell";

static NSString *const headerViewIden = @"HeadViewIden";

@interface FBSearchViewController ()
<
UICollectionViewDataSource,
UICollectionViewDelegate,
UICollectionViewDelegateFlowLayout,
UITextFieldDelegate,
SelectCollectionCellDelegate,
UICollectionReusableViewButtonDelegate,
ETHomeHeaderViewDelegate
>

/**
 *  存储网络请求的热搜，与本地缓存的历史搜索model数组
 */
@property (nonatomic, strong) NSMutableArray *sectionArray;
/**
 *  存搜索的数组 字典
 */
@property (nonatomic, strong) NSMutableArray *searchArray;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong)UICollectionViewFlowLayout *flowLayout;

@property(nonatomic, strong)UIView *searchView;
@property (nonatomic, strong) UITextField *searchTextField;

@property(nonatomic, strong)NSArray *hotArray;
@property (nonatomic, strong) ETHomeTopView1 *vHomeTop;
@property (nonatomic, strong) ETHomeHeaderView1 *vHomeHeader;

@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) UIButton *leftButton;
@end

@implementation FBSearchViewController
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.searchTextField becomeFirstResponder];
}
- (void)viewWillAppear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:YES animated:TRUE];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super.navigationController setNavigationBarHidden:NO animated:TRUE];
    
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消"
                                                                             style:UIBarButtonItemStylePlain
                                                                            target:self
                                                                            action:@selector(rightBarButtonItemClick)];
    [self getHotSearch];
    [self prepareData];
    
    UIView* back=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 50)];
    back.backgroundColor=kACColorBlue_Theme;
    
    self.searchView = [[UIView alloc]initWithFrame:CGRectMake(20, 0, Screen_Width -20 - 50, 30)];
    self.searchView.backgroundColor = [UIColor redColor];
    self.searchView.clipsToBounds = YES;
    self.searchView.layer.cornerRadius = 15.0;
//    self.navigationItem.titleView = self.searchView;
    
    self.searchTextField = [[UITextField alloc]initWithFrame:CGRectMake(30, 7, Screen_Width -20 - 80, 36)];
    self.searchTextField.placeholder = @"搜索个关键词试试";
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"搜索所需流转资源及专项服务" attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],         NSFontAttributeName:self.searchTextField.font}];
    self.searchTextField.attributedPlaceholder = attrString;

    self.searchTextField.borderStyle=UITextBorderStyleNone;
    self.searchTextField.font = [UIFont systemFontOfSize:13.0];
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchTextField.delegate = self;
    
    [back addSubview:self.searchTextField];
    
    //
    UIView* line=[[UIView alloc] initWithFrame:CGRectMake(30,self.searchTextField.maxY, Screen_Width -20 - 80, 0.5)];
    [line setBackgroundColor:[UIColor whiteColor]];
    //
    UIButton* searchBtn=[UIButton new];
    [searchBtn setBackgroundImage:[UIImage imageNamed:@"search_分组"] forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchAct) forControlEvents:UIControlEventTouchUpInside];
    [back addSubview:searchBtn];
    [searchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(back).offset(-20);
        make.centerY.mas_equalTo(self.searchTextField);
        make.width.height.mas_equalTo(22);
    }];
    
    
    [back addSubview:line];
    
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).offset(10);
        make.right.mas_equalTo(self.view).offset(-10);
        make.top.mas_equalTo(self.view).offset(160);

        make.bottom.mas_equalTo(self.view);
    }];
    
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureRecognizer)];
    [self.collectionView addGestureRecognizer:tapGesture];
    _vHomeHeader = [[ETHomeHeaderView1 alloc]initWithFrame:CGRectMake(0, kStatusBarHeight + 65, Screen_Width, 50)];
    
    _vHomeHeader.delegate = self;
    back.frame=_vHomeHeader.frame;
    [back addSubview:self.searchTextField];
    [self.view addSubview:back];
    [self createSubViewsAndConstraints];
    
    _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, TopHeight)];
    _navigationView.backgroundColor = kACColorClear;
    [self.view addSubview:_navigationView];
    _leftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _leftButton.frame = CGRectMake(15, StatusBarHeight, 55, 45);
    //    [_leftButton setBackgroundColor:[UIColor blueColor]];
    [_leftButton setImage:[UIImage imageNamed:@"navigation_back_hl"] forState:(UIControlStateNormal)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(7, StatusBarHeight+7, 44, 44);
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateHighlighted];
    [btn setImage:[UIImage imageNamed:@"nav_leftBack"] forState:UIControlStateSelected];
    _leftButton=btn;
    [_leftButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_navigationView addSubview:_leftButton];
}
-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)searchAct
{
    bool a=[self textFieldShouldReturn:self.searchTextField];
}
#pragma mark - createSubViewsAndConstraints
- (void)createSubViewsAndConstraints {
    
    _vHomeTop = [[ETHomeTopView1 alloc]init];
    _vHomeTop.btnLocationDown.hidden=YES;
    _vHomeTop.btnLocation.hidden=YES;
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
-(void)tapGestureRecognizer{
    [self.searchTextField endEditing:YES];
}
-(void)rightBarButtonItemClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareData{
    /**
     *  测试数据 ，字段暂时 只用一个 titleString，后续可以根据需求 相应加入新的字段
     */
    /*

    */
    NSMutableArray *testArray = [NSMutableArray array];
//    [testArray addObject:testDict];
    
    /***  去数据查看 是否有数据*/
    NSDictionary *parmDict  = @{@"category":@"1"};
    NSDictionary *dbDictionary =  [CXDBHandle statusesWithParams:parmDict];
    
    if (dbDictionary.count) {
        [testArray addObject:dbDictionary];
        NSMutableArray* arr=[dbDictionary[@"section_content"] mutableCopy];
        NSMutableArray* temp=[NSMutableArray new];
        for (NSDictionary* d in arr) {
            if ([[d objectForKey:@"content_name"] isEqualToString:@""]) {
            }
            else
                [temp addObject:d];
        }
        [self.searchArray addObjectsFromArray:temp];
    }
    
    for (NSDictionary *sectionDict in testArray) {
        CXSearchSectionModel *model = [[CXSearchSectionModel alloc]initWithDictionary:sectionDict];
        [self.sectionArray insertObject:model atIndex:0];
    }
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    CXSearchSectionModel *sectionModel =  self.sectionArray[section];
    return sectionModel.section_contentArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CXSearchCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cxSearchCollectionViewCell forIndexPath:indexPath];
    CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    CXSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
    [cell.contentButton setTitle:contentModel.content_name forState:UIControlStateNormal];
    cell.selectDelegate = self;
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.sectionArray.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *reusableview = nil;
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]){
        SelectCollectionReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:headerViewIden forIndexPath:indexPath];
        view.delectDelegate = self;
        CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
        [view setText:sectionModel.section_title];
        /***  此处完全 也可以自定义自己想要的模型对应放入*/
        if(indexPath.section == 1){
            [view setImage:@"cxCool"];
            view.delectButton.hidden = NO;
        }else{
            [view setImage:@"cxSearch"];
            view.delectButton.hidden = YES;
        }
        reusableview = view;
    }
    return reusableview;
}

- (CGSize) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    if (sectionModel.section_contentArray.count > 0) {
        CXSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
        return [CXSearchCollectionViewCell getSizeWithText:contentModel.content_name];
    }
    return CGSizeMake(80, 30);
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(Screen_Width, 60);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

#pragma mark - SelectCollectionCellDelegate
- (void)selectButttonClick:(CXSearchCollectionViewCell *)cell{
    NSIndexPath* indexPath = [self.collectionView indexPathForCell:cell];
    CXSearchSectionModel *sectionModel =  self.sectionArray[indexPath.section];
    CXSearchModel *contentModel = sectionModel.section_contentArray[indexPath.row];
    ///跳转搜索结果页
    [self pushReshltViewController:contentModel.content_name];
}


#pragma mark - UICollectionReusableViewButtonDelegate
- (void)delectData:(SelectCollectionReusableView *)view{
    if (self.sectionArray.count > 1) {
        [self.sectionArray removeLastObject];
        [self.searchArray removeAllObjects];
        [self.collectionView reloadData];
        [CXDBHandle saveStatuses:@{} andParam:@{@"category":@"1"}];
    }
}
#pragma mark - scrollView
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchTextField resignFirstResponder];
}
#pragma mark - textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([[textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] isEqualToString:@""]){
        return NO;
    }
    /***  每搜索一次   就会存放一次到历史记录，但不存重复的*/
    if ([self.searchArray containsObject:[NSDictionary dictionaryWithObject:textField.text forKey:@"content_name"]]) {
        [self pushReshltViewController:textField.text];
        return YES;
    }
    NSString* searchtxt=textField.text;
    [self reloadData:textField.text];
    [self pushReshltViewController:searchtxt];
    return YES;
}
- (void)reloadData:(NSString *)textString{
    [self.searchArray addObject:[NSDictionary dictionaryWithObject:textString forKey:@"content_name"]];
    
    NSDictionary *searchDict = @{@"section_id":@"1",@"section_title":@"大家都在搜",@"section_content":self.searchArray};
    
    /***由于数据量并不大 这样每次存入再删除没问题  存数据库*/
    NSDictionary *parmDict  = @{@"category":@"1"};
    [CXDBHandle saveStatuses:searchDict andParam:parmDict];
    
    CXSearchSectionModel *model = [[CXSearchSectionModel alloc]initWithDictionary:searchDict];
    if (self.sectionArray.count > 1) {
        [self.sectionArray removeLastObject];
    }
    [self.sectionArray addObject:model];
    for (int i=0;i< self.sectionArray.count;i++) {
        CXSearchSectionModel* sm=[self.sectionArray objectAtIndex:i];
        if (i==1) {
            sm.section_title=@"历史搜索";
        }
        if (i==0) {
            sm.section_contentArray=[self.hotArray mutableCopy];
        }
    }
    [self.collectionView reloadData];
    self.searchTextField.text = @"";
}

-(void)pushReshltViewController:(NSString *)searchText{
    SearchResultViewController * resultVC = [[SearchResultViewController alloc]init];
    resultVC.searchText = searchText;
    [self.navigationController pushViewController:resultVC animated:YES];
}


-(void)getHotSearch{
    NSDictionary *params = @{
                             };
    [HttpTool get:[NSString stringWithFormat:@"search/searching"] params:params success:^(id responseObj) {
        NSArray* a=responseObj[@"data"][@"searchList"];
        NSMutableArray* mutab=[NSMutableArray new];

        for (NSString* b in a) {
            CXSearchModel* bm=[[CXSearchModel alloc] init];
            bm.content_name=b;
            [mutab addObject:bm];
        }
        self.hotArray = [mutab copy];
//                    NSMutableArray * array = [NSMutableArray array];
//                    for (FBBaseModel * model in self.hotArray) {
//                        CXSearchModel * searchModel = [[CXSearchModel alloc] init];
//                        searchModel.content_name = model.Text;
//                        [array addObject:searchModel];
//                    }
//                    CXSearchSectionModel * sectionModel = [[CXSearchSectionModel alloc] init];
//                    sectionModel.section_id = @"2";
//                    sectionModel.section_title = @"历史搜索";
//                    sectionModel.section_contentArray = @[@"ss"];
//                    [self.sectionArray addObject:sectionModel];
        
        [self reloadData:@""];

                    [self.collectionView reloadData];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
//    [FBNetworkTool get:@"articleapi/com.HotSearchTag" parameters:nil showHUD:NO success:^(XMHttpResponseModel *responseModel) {
//        if (responseModel.code == 200) {
//            self.hotArray = [FBBaseModel mj_objectArrayWithKeyValuesArray:responseModel.data];
//            NSMutableArray * array = [NSMutableArray array];
//            for (FBBaseModel * model in self.hotArray) {
//                CXSearchModel * searchModel = [[CXSearchModel alloc] init];
//                searchModel.content_name = model.Text;
//                [array addObject:searchModel];
//            }
//            CXSearchSectionModel * sectionModel = [[CXSearchSectionModel alloc] init];
//            sectionModel.section_id = @"2";
//            sectionModel.section_title = @"热门搜索";
//            sectionModel.section_contentArray = @[@"ss"];
//            [self.sectionArray addObject:sectionModel];
//            [self.collectionView reloadData];
//        }
//    } failure:nil];
}









-(NSMutableArray *)sectionArray{
    if (_sectionArray == nil) {
        _sectionArray = [NSMutableArray array];
    }
    return _sectionArray;
}

-(NSMutableArray *)searchArray{
    if (_searchArray == nil) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:self.flowLayout];
        
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        
        [_collectionView registerNib:[UINib nibWithNibName:@"CXSearchCollectionViewCell" bundle:nil]
          forCellWithReuseIdentifier:cxSearchCollectionViewCell];
        
        [_collectionView registerClass:[SelectCollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:headerViewIden];
    }
    return _collectionView;
}

-(UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.minimumLineSpacing = 10;
        _flowLayout.minimumInteritemSpacing = 10;
    }
    return _flowLayout;
}

@end










