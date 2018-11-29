//  HomeVC.m
//  aboluo
//  Created by zhufeng on 2018/11/3.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "HomeVC.h"
#import "HomeAdCell.h"
#import "HomeTitleCell.h"
#import "HomeRecommandCell.h"
#import "HomeProjectCell.h"
#import "HomeMainCell.h"
#import "HomeTopView.h"                 ///topview
#import "HomeSGAdvertCell.h"            ///轮播
#import "HomeRecommendTtileCell.h"      ///为你推荐
#import "HomeRecommendVC.h"             ///推荐列表
#import "HomeExchangeVC.h"              ///兑换
#import "HomeReceiptVC.h"               ///收款
#import "HomeRayVC.h"                   ///付款
#import "HomeScanVC.h"                  ///扫一扫
#import "HomeSearchVC.h"                ///搜索
#import "HomeAddressVC.h"               ///定位
#import "ServerOrdehallVC.h"            ///接单
#import "ServerBillinghallVC.h"         ///发单
#import "HomeProjectTypeVC.h"           ///项目列表
#import "HomeMasterModel.h"
#import "HomeProductTypeCell.h"         ///商品列表
#import "HomeProductTypeModel.h"
#import "HomeBanner.h"
#import "HomeNoticeModel.h"
@interface HomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top_layout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (nonatomic,strong)HomeTopView *topview;
@property (nonatomic,strong)NSMutableArray *baanerArray;
@property (nonatomic,strong)NSMutableArray *noticArray;
@property (nonatomic,strong)NSMutableArray *projectArray;
@property (nonatomic,strong)NSMutableArray *masterArray;
@property (nonatomic,strong)NSMutableArray *companyArray;
@property (nonatomic,strong)NSMutableArray *productTypeArray;
@property (nonatomic,strong)NSMutableArray *remmendProjectArray;
@end
@implementation HomeVC
-(NSMutableArray *)remmendProjectArray
{
    if (!_remmendProjectArray) {
        _remmendProjectArray = [NSMutableArray array];
    }
    return _remmendProjectArray;
}

-(NSMutableArray *)baanerArray
{
    if (!_baanerArray) {
        _baanerArray = [NSMutableArray array];
    }
    return _baanerArray;
}
-(NSMutableArray *)noticArray
{
    if (!_noticArray) {
        _noticArray = [NSMutableArray array];
    }
    return _noticArray;
}

-(NSMutableArray *)productTypeArray
{
    if (!_productTypeArray) {
        _productTypeArray = [NSMutableArray array];
    }
    return _productTypeArray;
}
-(NSMutableArray *)companyArray
{
    if (!_companyArray) {
        _companyArray = [NSMutableArray array];
    }
    return _companyArray;
}
-(NSMutableArray *)projectArray
{
    if (!_projectArray) {
        _projectArray = [NSMutableArray array];
    }
    return _projectArray;
}
-(NSMutableArray *)masterArray
{
    if (!_masterArray) {
        _masterArray = [NSMutableArray array];
    }
    return _masterArray;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupDetailData];
    [self actionHomeNewData];
    [self setupHome];
    [self setupCollectionView];
    [self setupRefresh];
}
-(void)setupDetailData
{
    HomeProductTypeModel *typemodel = [[HomeProductTypeModel alloc]init];
    typemodel.pid = @"1";
    typemodel.picurl = @"home_tyep";
    typemodel.title = @"家用电器1";
    [self.productTypeArray addObject:typemodel];
    
    HomeProductTypeModel *typemodel2 = [[HomeProductTypeModel alloc]init];
    typemodel2.pid = @"2";
    typemodel2.picurl = @"home_tyep";
    typemodel2.title = @"家用电器2";
    [self.productTypeArray addObject:typemodel2];
    
    HomeProductTypeModel *typemodel3 = [[HomeProductTypeModel alloc]init];
    typemodel3.pid = @"3";
    typemodel3.picurl = @"home_tyep";
    typemodel3.title = @"家用电器3";
    [self.productTypeArray addObject:typemodel3];
    
    HomeProductTypeModel *typemodel4 = [[HomeProductTypeModel alloc]init];
    typemodel4.pid = @"4";
    typemodel4.picurl = @"home_tyep";
    typemodel4.title = @"家用电器4";
    [self.productTypeArray addObject:typemodel4];
    
    HomeProductTypeModel *typemodel5 = [[HomeProductTypeModel alloc]init];
    typemodel5.pid = @"5";
    typemodel5.picurl = @"home_tyep";
    typemodel5.title = @"家用电器5";
    [self.productTypeArray addObject:typemodel5];
    
    HomeProductTypeModel *typemodel7 = [[HomeProductTypeModel alloc]init];
    typemodel7.pid = @"6";
    typemodel7.picurl = @"home_tyep";
    typemodel7.title = @"家用电器6";
    [self.productTypeArray addObject:typemodel7];
}
/**
 集成刷新功能
 */
-(void)setupRefresh
{
    [self setViewRefreshColletionView:self.collectionview
                     withHeaderAction:@selector(actionHomeNewData)
                      andFooterAction:nil
                               target:self];
}
/**
 加载最新的数据
 */
-(void)actionHomeNewData
{
    [SVProgressHUD showWithStatus:ShowTitleTip];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    WEAKSELF
    [[NetWorkTool shareInstacne]postWithURLString:Home_Index parameters:param success:^(id  _Nonnull responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        [SVProgressHUD dismiss];
        ResponeModel *res =  [ResponeModel mj_objectWithKeyValues:responseObject];
        if (res.code == 1) {
            ///移除全部
            [weakSelf.baanerArray removeAllObjects];
            [weakSelf.noticArray removeAllObjects];
            [weakSelf.projectArray removeAllObjects];
            [weakSelf.masterArray removeAllObjects];
            [weakSelf.companyArray removeAllObjects];
            [weakSelf.productTypeArray removeAllObjects];
            [weakSelf.remmendProjectArray removeAllObjects];
            ///1.轮播
            weakSelf.baanerArray = [HomeBanner mj_objectArrayWithKeyValuesArray:res.data[@"advertisements"]];
            ///2.广播
            weakSelf.noticArray = [HomeNoticeModel mj_objectArrayWithKeyValuesArray:res.data[@"notices"]];
            ///3.项目
            ///4.个人
            ///5.公司
            ///6.商品列表
            ///7.项目列表
            [weakSelf.collectionview reloadData];
            ///2.
            [weakSelf.collectionview.mj_header endRefreshing];
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        //[SVProgressHUD showErrorWithStatus:FailRequestTip];
        [weakSelf.collectionview.mj_header endRefreshing];
        return;
    }];
}
/**
 加载更多的数据
 */
-(void)actionHomeMoreData
{
    
}
-(void)setupHome
{
   self.topview = [[HomeTopView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 80+Height_NavBar)];
    self.topview.backgroundColor = MainThemeColor;
    self.top_layout.constant = 80+Height_NavBar;
    [self.view addSubview:self.topview];
    WEAKSELF
    //leftblock
    self.topview.leftblock = ^(UIButton *btn) {
        HomeAddressVC *addressvc = [[HomeAddressVC alloc]init];
        addressvc.addreessblock = ^(NSString *selectStr) {
            NSLog(@"selectStr:%@",selectStr);
            [weakSelf.topview.leftBarItem setTitle:selectStr forState:UIControlStateNormal];
        };
        [weakSelf.navigationController pushViewController:addressvc animated:YES];
    };
    //searcblock
    self.topview.searchblock = ^(UIButton *btn) {
        HomeSearchVC *searchvc = [[HomeSearchVC alloc]init];
        [weakSelf.navigationController pushViewController:searchvc animated:YES];
    };
    //topactioncallback
    self.topview.topactionCallback = ^(HomeTopType type) {
        if (type == HomeTopTypeScan) {
            //扫一扫
            HomeScanVC *scanvc = [[HomeScanVC alloc]init];
            [weakSelf.navigationController pushViewController:scanvc animated:YES];
        }else if(type == HomeTopTypePay){
            //付款
            HomeRayVC *payvc = [[HomeRayVC alloc]init];
            [weakSelf.navigationController pushViewController:payvc animated:YES];
        }else if(type == HomeTopTypeReceipt){
            //收款
            HomeReceiptVC *receiptvc = [[HomeReceiptVC alloc]init];
            [weakSelf.navigationController pushViewController:receiptvc animated:YES];
        }else if(type == HomeTopTypeExchage){
            //兑换
            HomeExchangeVC *exchangevc = [[HomeExchangeVC alloc]init];
            [weakSelf.navigationController pushViewController:exchangevc animated:YES];
        }
    };
}
-(void)setupCollectionView
{
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    self.collectionview.backgroundColor = [UIColor clearColor];
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HomeAdCell class]) bundle:nil] forCellWithReuseIdentifier:@"HomeAdCell"];
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HomeTitleCell class]) bundle:nil] forCellWithReuseIdentifier:@"HomeTitleCell"];
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HomeProjectCell class]) bundle:nil] forCellWithReuseIdentifier:@"HomeProjectCell"];
   ///Todo 傻逼天天改
   // [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HomeMainCell class]) bundle:nil] forCellWithReuseIdentifier:@"HomeMainCell"];
     [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HomeRecommandCell class]) bundle:nil] forCellWithReuseIdentifier:@"HomeRecommandCell"];
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HomeSGAdvertCell class]) bundle:nil] forCellWithReuseIdentifier:@"HomeSGAdvertCell"];
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HomeRecommendTtileCell class]) bundle:nil] forCellWithReuseIdentifier:@"HomeRecommendTtileCell"];
    [self.collectionview registerClass:[HomeProductTypeCell class] forCellWithReuseIdentifier:@"HomeProductTypeCell"];
}
#pragma mark collectionviewdelgate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 12;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0 || section == 1 || section == 2 ||section == 4 || section == 6 || section == 8 || section == 9 ||section == 10) {
        return 1;
    }if (section == 3) {
        if (self.projectArray.count > 3) {
            return 4;
        }else{
            return self.projectArray.count;
        }
    }if (section == 5) {
        if (self.masterArray.count > 3) {
            return 4;
        }else{
            return self.masterArray.count;
        }
    }if (section == 7) {
//        if (self.companyArray.count >3 ) {
//            return 4;
//        }else{
//            return self.companyArray.count;
//        }
        return 4;
    }
    if (section == 11) {
        return 6;
    }else{
        return 0;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *homeCell = nil;
    if (indexPath.section == 0) {
        ///0.轮播
        HomeAdCell *adCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeAdCell" forIndexPath:indexPath];
        //adCell.urlArray = self.adArray;
        adCell.cycleview.backgroundColor = [UIColor clearColor];
        homeCell = adCell;
    }if (indexPath.section == 1) {
        ///1.广播
        HomeSGAdvertCell *adverCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeSGAdvertCell" forIndexPath:indexPath];
        //adverCell.adverscollview.titles = self.titleArray;
        adverCell.adverscollview.titleColor = [UIColor redColor];
        adverCell.adverscollview.textAlignment = NSTextAlignmentLeft;
        homeCell = adverCell;
    }if (indexPath.section == 2) {
        ///2.找项目
        HomeTitleCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeTitleCell" forIndexPath:indexPath];
        titleCell.title_lab.text = @"找项目";
        ///TODO这里是找项目更多的数据了
        titleCell.pushblock = ^(UIButton *btn) {
            HomeProjectTypeVC *projecttpyevc = [[HomeProjectTypeVC alloc]init];
            projecttpyevc.projectArray = self.projectArray;
            projecttpyevc.type = @"1";
            [self.navigationController pushViewController:projecttpyevc animated:YES];
        };
        homeCell = titleCell;
    }
    if (indexPath.section == 3) {
        ///3.项目列表
        HomeProjectCell *projectCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeProjectCell" forIndexPath:indexPath];
        homeCell = projectCell;
    }if (indexPath.section == 4) {
        //4.个人找师傅标题
        HomeTitleCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeTitleCell" forIndexPath:indexPath];
        titleCell.title_lab.text = @"个人";
        ///TODO找师傅更多数据
        titleCell.pushblock = ^(UIButton *btn) {
            HomeProjectTypeVC *projecttpyevc = [[HomeProjectTypeVC alloc]init];
            projecttpyevc.projectArray = self.masterArray;
            projecttpyevc.type = @"2";
            [self.navigationController pushViewController:projecttpyevc animated:YES];
        };
        homeCell = titleCell;
    }if (indexPath.section == 5) {
        ///5.个人找师傅列表
        HomeProjectCell *projectCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeProjectCell" forIndexPath:indexPath];
        homeCell = projectCell;
    }if (indexPath.section == 6) {
        ///6.公司标题
        HomeTitleCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeTitleCell" forIndexPath:indexPath];
        titleCell.title_lab.text = @"公司";
        ///TODO找师傅更多数据
        titleCell.pushblock = ^(UIButton *btn) {
            HomeProjectTypeVC *projecttpyevc = [[HomeProjectTypeVC alloc]init];
            projecttpyevc.projectArray = self.masterArray;
            projecttpyevc.type = @"2";
            [self.navigationController pushViewController:projecttpyevc animated:YES];
        };
        homeCell = titleCell;
    } if (indexPath.section == 7){
        ///7.公司项目列表
        HomeProjectCell *projectCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeProjectCell" forIndexPath:indexPath];
        homeCell = projectCell;
    }if (indexPath.section == 8){
        ///8.商城标题
        HomeTitleCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeTitleCell" forIndexPath:indexPath];
        titleCell.title_lab.text = @"商品列表";
        ///TODO找师傅更多数据
        titleCell.pushblock = ^(UIButton *btn) {
            HomeProjectTypeVC *projecttpyevc = [[HomeProjectTypeVC alloc]init];
            projecttpyevc.projectArray = self.masterArray;
            projecttpyevc.type = @"2";
            [self.navigationController pushViewController:projecttpyevc animated:YES];
        };
        homeCell = titleCell;
    }if (indexPath.section == 9) {
        ///9.商城列表
        HomeProductTypeCell *productTypecell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeProductTypeCell" forIndexPath:indexPath];
        productTypecell.productTypeArray = self.productTypeArray;
        homeCell = productTypecell;
    }
    /*
    if (indexPath.section == 10) {
        ///10.接单
        HomeMainCell *mainCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeMainCell" forIndexPath:indexPath];
        mainCell.MainActionBlock = ^(HomeMianType type) {
            if (type == HomeMianTypeOrder) {
                ///接单
                ServerOrdehallVC *orderhallvc = [[ServerOrdehallVC alloc]init];
                [self.navigationController pushViewController:orderhallvc animated:YES];
            }if (type == HomeMianTypeBilling ) {
                //发单
                ServerBillinghallVC *billinghallvc = [[ServerBillinghallVC alloc]init];
                [self.navigationController pushViewController:billinghallvc animated:YES];
            }
        };
        homeCell = mainCell;
    }*/
     
     if (indexPath.section == 10) {
        ///11.为你推荐的东西
        HomeRecommendTtileCell *recommendCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeRecommendTtileCell" forIndexPath:indexPath];
        homeCell = recommendCell;
    }if (indexPath.section == 11) {
        ///12.推荐的商品的列表
        HomeRecommandCell *recommandCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeRecommandCell" forIndexPath:indexPath];
        homeCell = recommandCell;
    }
    return homeCell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
#pragma mark -item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(IPHONE_WIDTH, 130);
    }if (indexPath.section == 1) {
        return  CGSizeMake(IPHONE_WIDTH, 60);
    }if (indexPath.section == 2 || indexPath.section == 4 || indexPath.section == 6 || indexPath.section == 8 ) {
        return CGSizeMake(IPHONE_WIDTH, 40);
    }if (indexPath.section == 3 || indexPath.section == 5 || indexPath.section == 7) {
        return CGSizeMake(IPHONE_WIDTH/5,IPHONE_WIDTH/5);
    }if (indexPath.section == 9) {
        return CGSizeMake(IPHONE_WIDTH,150);
    }
    /*if (indexPath.section == 10) {
        return CGSizeMake(IPHONE_WIDTH,120);
    }*/
     if (indexPath.section == 10) {
        return CGSizeMake(IPHONE_WIDTH, 50);
    }if (indexPath.section == 11) {
        return CGSizeMake(IPHONE_WIDTH,130);
    }else{
        return CGSizeZero;
    }
}
@end
