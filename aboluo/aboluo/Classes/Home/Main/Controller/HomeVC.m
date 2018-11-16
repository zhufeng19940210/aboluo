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
#import "HomeMasterVC.h"                ///师傅列表
#import "HomeProjectVC.h"               ///项目列表
#import "HomeExchangeVC.h"              ///兑换
#import "HomeReceiptVC.h"               ///收款
#import "HomeRayVC.h"                   ///付款
#import "HomeScanVC.h"                  ///扫一扫
#import "HomeSearchVC.h"                ///搜索
#import "HomeAddressVC.h"               ///定位
#import "ServerOrdehallVC.h"            ///接单
#import "ServerBillinghallVC.h"         ///发单
@interface HomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *top_layout;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (nonatomic,strong)NSArray *adArray;
@property (nonatomic,strong)HomeTopView *topview;
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)NSMutableArray *projectArray;
@property (nonatomic,strong)NSMutableArray *masterArray;
@end
@implementation HomeVC
-(NSMutableArray *)projectArray
{
    if (!_projectArray) {
        _projectArray = [NSMutableArray arrayWithObjects:@"home_shuidian",@"home_nitu",@"home_mugong",@"home_guaci", nil];
    }
    return _projectArray;
}
-(NSMutableArray *)masterArray
{
    if (!_masterArray) {
        _masterArray = [NSMutableArray arrayWithObjects:@"home_shuidiangong2",@"home_nigong2",@"home_mugong2",@"home_guacigong2", nil];
    }
    return _masterArray;
}
-(NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSArray arrayWithObjects:@"京东、天猫等 app 首页常见的广告滚动视图",@"采用代理设计模式进行封装, 可进行事件点击处理,测试数就测试就减肥法解决",@"建议在 github 上下载建议在 github 上下载建议在 github 上下载建议在 github 上下载", nil];
    }
    return _titleArray;
}
-(NSArray *)adArray
{
    if (!_adArray) {
        _adArray = [NSArray arrayWithObjects:@"home_baaner",@"home_baaner", nil];
    }
    return _adArray;
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
   [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self setupHome];
    [self setupCollectionView];
}
-(void)setupHome
{
   self.topview = [[HomeTopView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 80+Height_NavBar)];
    self.topview.backgroundColor = MainThemeColor;
    self.top_layout.constant = CGRectGetMaxY(self.topview.frame);
    [self.view addSubview:self.topview];
    WEAKSELF
    //leftblock
    self.topview.leftblock = ^(UIButton *btn) {
        HomeAddressVC *addressvc = [[HomeAddressVC alloc]init];
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
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HomeMainCell class]) bundle:nil] forCellWithReuseIdentifier:@"HomeMainCell"];
     [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HomeRecommandCell class]) bundle:nil] forCellWithReuseIdentifier:@"HomeRecommandCell"];
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HomeSGAdvertCell class]) bundle:nil] forCellWithReuseIdentifier:@"HomeSGAdvertCell"];
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HomeRecommendTtileCell class]) bundle:nil] forCellWithReuseIdentifier:@"HomeRecommendTtileCell"];
}
#pragma mark collectionviewdelgate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 9;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0 || section == 1 || section == 2 ||section == 4 || section == 6 || section == 7) {
        return 1;
    }if (section == 3) {
        return self.projectArray.count;
    }if (section == 5) {
        return self.masterArray.count;
    }if (section == 8) {
        return 6;
    }else{
        return 0;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *homeCell = nil;
    if (indexPath.section == 0) {
        HomeAdCell *adCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeAdCell" forIndexPath:indexPath];
        adCell.urlArray = self.adArray;
        adCell.cycleview.backgroundColor = [UIColor clearColor];
        homeCell = adCell;
    }if (indexPath.section == 1) {
        HomeSGAdvertCell *adverCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeSGAdvertCell" forIndexPath:indexPath];
        adverCell.adverscollview.titles = self.titleArray;
        adverCell.adverscollview.titleColor = [UIColor redColor];
        adverCell.adverscollview.textAlignment = NSTextAlignmentLeft;
        homeCell = adverCell;
    }if (indexPath.section == 2) {
        HomeTitleCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeTitleCell" forIndexPath:indexPath];
        titleCell.title_lab.text = @"找项目";
        titleCell.pushblock = ^(UIButton *btn) {
            HomeProjectVC *projectvc = [[HomeProjectVC alloc]init];
            [self.navigationController pushViewController:projectvc animated:YES];
        };
        homeCell = titleCell;
    }
    if (indexPath.section == 3) {
        HomeProjectCell *projectCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeProjectCell" forIndexPath:indexPath];
        projectCell.icon_img.image = [UIImage imageNamed:self.projectArray[indexPath.row]];
        homeCell = projectCell;
    }if (indexPath.section == 4) {
        HomeTitleCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeTitleCell" forIndexPath:indexPath];
        titleCell.title_lab.text = @"找师傅";
        titleCell.pushblock = ^(UIButton *btn) {
            HomeMasterVC *mastervc = [[HomeMasterVC alloc]init];
            [self.navigationController pushViewController:mastervc animated:YES];
        };
        homeCell = titleCell;
    }if (indexPath.section == 5) {
        HomeProjectCell *projectCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeProjectCell" forIndexPath:indexPath];
        projectCell.icon_img.image = [UIImage imageNamed:self.masterArray[indexPath.row]];
        homeCell = projectCell;
    }if (indexPath.section == 6) {
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
    }if (indexPath.section == 7) {
        HomeRecommendTtileCell *recommendCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeRecommendTtileCell" forIndexPath:indexPath];
        homeCell = recommendCell;
    }if (indexPath.section == 8) {
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
    }if (indexPath.section == 2) {
        return CGSizeMake(IPHONE_WIDTH, 40);
    }if (indexPath.section == 3) {
        return CGSizeMake(IPHONE_WIDTH/5,IPHONE_WIDTH/5);
    }if (indexPath.section == 4) {
        return CGSizeMake(IPHONE_WIDTH,40);
    }if (indexPath.section == 5) {
        return CGSizeMake(IPHONE_WIDTH/5,IPHONE_WIDTH/5);
    }if (indexPath.section == 6) {
        return CGSizeMake(IPHONE_WIDTH, 120);
    }if (indexPath.section == 7) {
        return CGSizeMake(IPHONE_WIDTH, 50);
    }if (indexPath.section == 8) {
        return CGSizeMake(IPHONE_WIDTH, 130);
    }else{
        return CGSizeZero;
    }
}
@end
