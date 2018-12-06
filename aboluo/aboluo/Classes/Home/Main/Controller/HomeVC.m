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
#import "HomeProjectDetailModel.h"
#import "HomeWorkTypeModel.h"
@interface HomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top_layout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (nonatomic,strong)HomeTopView *topview;
@property (nonatomic,strong)NSMutableArray *baanerArray;
@property (nonatomic,strong)NSMutableArray *noticArray;
@property (nonatomic,strong)NSMutableArray *projectArray;
@property (nonatomic,strong)NSMutableArray *masterArray;
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
    [self actionHomeNewData];
    [self setupHome];
    [self setupCollectionView];
    [self setupRefresh];
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
            [SVProgressHUD showSuccessWithStatus:ShowSuccessTip];
            ///移除全部
            [weakSelf.baanerArray removeAllObjects];
            [weakSelf.noticArray removeAllObjects];
            [weakSelf.projectArray removeAllObjects];
            [weakSelf.masterArray removeAllObjects];
            [weakSelf.productTypeArray removeAllObjects];
            [weakSelf.remmendProjectArray removeAllObjects];
            ///1.轮播
            weakSelf.baanerArray = [HomeBanner mj_objectArrayWithKeyValuesArray:res.data[@"advertisements"]];
            ///2.广播
            weakSelf.noticArray = [HomeNoticeModel mj_objectArrayWithKeyValuesArray:res.data[@"notices"]];
            ///3.项目
            weakSelf.projectArray = [HomeWorkTypeModel mj_objectArrayWithKeyValuesArray:res.data[@"xiangmu"]];
            ///4.师傅
            weakSelf.masterArray = [HomeWorkTypeModel mj_objectArrayWithKeyValuesArray:res.data[@"shifu"]];
            ///6.商品列表
            weakSelf.productTypeArray = [HomeProductTypeModel mj_objectArrayWithKeyValuesArray:res.data[@"categories"]];
            ///7.推荐列表
            weakSelf.remmendProjectArray =  [HomeProjectDetailModel mj_objectArrayWithKeyValuesArray:res.data[@"recommendProject"]];
            [weakSelf.collectionview reloadData];
            [weakSelf.collectionview.mj_header endRefreshing];
        }else{
            [SVProgressHUD showErrorWithStatus:ShowErrorTip];
            return;
        }
    } failure:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
        [SVProgressHUD showErrorWithStatus:FailRequestTip];
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
   self.topview = [[HomeTopView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, Height_NavBar)];
    self.topview.backgroundColor = MainThemeColor;
    self.top_layout.constant = Height_NavBar;
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
     [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HomeRecommandCell class]) bundle:nil] forCellWithReuseIdentifier:@"HomeRecommandCell"];
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HomeSGAdvertCell class]) bundle:nil] forCellWithReuseIdentifier:@"HomeSGAdvertCell"];
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HomeRecommendTtileCell class]) bundle:nil] forCellWithReuseIdentifier:@"HomeRecommendTtileCell"];
    [self.collectionview registerClass:[HomeProductTypeCell class] forCellWithReuseIdentifier:@"HomeProductTypeCell"];
}
#pragma mark collectionviewdelgate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 10;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0 || section == 1 || section == 2 ||section == 4 || section == 6 || section == 8) {
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
        return 1;
    }
    if (section == 9) {
        return self.remmendProjectArray.count;
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
        if (self.baanerArray.count >0) {
            NSMutableArray *photoArray = [NSMutableArray array];
            for (HomeBanner *baaner in self.baanerArray) {
                if (baaner.img) {
                    [photoArray addObject:baaner.img];
                }
            }
            adCell.urlArray = photoArray;
        }
        adCell.cycleview.backgroundColor = [UIColor clearColor];
        homeCell = adCell;
    }if (indexPath.section == 1) {
        ///1.广播
        HomeSGAdvertCell *adverCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeSGAdvertCell" forIndexPath:indexPath];
        if (self.noticArray.count >0) {
            NSMutableArray *noticeArray = [NSMutableArray array];
            for (HomeNoticeModel *notice in self.noticArray) {
                if (notice.name ) {
                    [noticeArray addObject:notice.name];
                }
            }
            adverCell.adverscollview.titles = noticeArray;
        }
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
        HomeWorkTypeModel *model = self.projectArray[indexPath.row];
        projectCell.typemodel = model;
        homeCell = projectCell;
    }if (indexPath.section == 4) {
        //4.个人找师傅标题
        HomeTitleCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeTitleCell" forIndexPath:indexPath];
        titleCell.title_lab.text = @"找师傅";
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
        HomeWorkTypeModel *model = self.masterArray[indexPath.row];
        projectCell.typemodel = model;
        homeCell = projectCell;
    }if (indexPath.section == 6){
        ///6.商城标题
        HomeTitleCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeTitleCell" forIndexPath:indexPath];
        titleCell.title_lab.text = @"商品列表";
        ///TODO找师傅更多数据
        titleCell.pushblock = ^(UIButton *btn) {
        };
        homeCell = titleCell;
    }if (indexPath.section == 7) {
        ///7.商城列表
        HomeProductTypeCell *productTypecell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeProductTypeCell" forIndexPath:indexPath];
        productTypecell.productTypeArray = self.productTypeArray;
        homeCell = productTypecell;
    }if (indexPath.section == 8) {
        ///11.为你推荐的东西
        HomeRecommendTtileCell *recommendCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeRecommendTtileCell" forIndexPath:indexPath];
        homeCell = recommendCell;
    }if (indexPath.section == 9) {
        ///12.推荐的商品的列表
        HomeRecommandCell *recommandCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeRecommandCell" forIndexPath:indexPath];
        HomeProjectDetailModel *detailModel = self.remmendProjectArray[indexPath.row];
        recommandCell.productModel = detailModel;
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
        return CGSizeMake(IPHONE_WIDTH, 200);
    }if (indexPath.section == 1) {
        return  CGSizeMake(IPHONE_WIDTH, 60);
    }if (indexPath.section == 2 || indexPath.section == 4 || indexPath.section == 6 || indexPath.section == 8 ) {
        return CGSizeMake(IPHONE_WIDTH, 40);
    }if (indexPath.section == 3 || indexPath.section == 5 ) {
        return CGSizeMake(IPHONE_WIDTH/5,IPHONE_WIDTH/5);
    }if (indexPath.section == 7) {
        return CGSizeMake(IPHONE_WIDTH,150);
    }if (indexPath.section == 9) {
        return CGSizeMake(IPHONE_WIDTH,130);
    }else{
        return CGSizeZero;
    }
}
@end

