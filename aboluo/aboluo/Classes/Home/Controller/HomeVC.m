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
#import "HomeTopView.h"
@interface HomeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@property (nonatomic,strong)NSArray *adArray;
@end
@implementation HomeVC
-(NSArray *)adArray
{
    if (!_adArray) {
        _adArray = [NSArray arrayWithObjects:@"home_baaner",@"home_baaner", nil];
    }
    return _adArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   self.navigationController.navigationBar.barTintColor = MainThemeColor;
   //shadowline
   [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
   self.navigationController.navigationBar.shadowImage = [[UIImage alloc] init];
   self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    [self setupHome];
    [self setupCollectionView];
}
-(void)setupHome
{
    HomeTopView *topview = [[HomeTopView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 100)];
    topview.backgroundColor = MainThemeColor;
    [self.view addSubview:topview];
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
}
#pragma mark collectionviewdelgate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 8;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0  || section == 1|| section == 3 || section == 5 || section == 6) {
        return 1;
    }else if (section == 2){
        return 4;
    }else if (section == 4){
        return  4;
    }else if (section == 7){
        return 5;
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
        HomeTitleCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeTitleCell" forIndexPath:indexPath];
        titleCell.title_lab.text = @"项目列表";
        homeCell = titleCell;
    }if (indexPath.section == 2) {
        HomeProjectCell *projectCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeProjectCell" forIndexPath:indexPath];
        homeCell = projectCell;
    }if (indexPath.section == 3) {
        HomeTitleCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeTitleCell" forIndexPath:indexPath];
        titleCell.title_lab.text = @"师傅列表";
        homeCell = titleCell;
    }if (indexPath.section == 4) {
        HomeProjectCell *projectCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeProjectCell" forIndexPath:indexPath];
        homeCell = projectCell;
    }if (indexPath.section == 5) {
        HomeMainCell *mainCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeMainCell" forIndexPath:indexPath];
        homeCell = mainCell;
    }if (indexPath.section == 6) {
        HomeTitleCell *titleCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeTitleCell" forIndexPath:indexPath];
        titleCell.title_lab.text = @"优质推荐";
        homeCell = titleCell;
    }if (indexPath.section == 7) {
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
        return CGSizeMake(IPHONE_WIDTH, 120);
    }if (indexPath.section == 1) {
        return CGSizeMake(IPHONE_WIDTH, 40);
    }if (indexPath.section == 2) {
        return CGSizeMake(IPHONE_WIDTH/5,IPHONE_WIDTH/5);
    }if (indexPath.section == 3) {
        return CGSizeMake(IPHONE_WIDTH,40);
    }if (indexPath.section == 4) {
        return CGSizeMake(IPHONE_WIDTH/5,IPHONE_WIDTH/5);
    }if (indexPath.section == 5) {
        return CGSizeMake(IPHONE_WIDTH, 120);
    }if (indexPath.section == 6) {
        return CGSizeMake(IPHONE_WIDTH, 40);
    }if (indexPath.section == 7) {
        return CGSizeMake(IPHONE_WIDTH, 130);
    }else{
        return CGSizeZero;
    }
}
@end
