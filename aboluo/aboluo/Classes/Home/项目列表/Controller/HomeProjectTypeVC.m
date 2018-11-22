//  HomeProjectTypeVC.m
//  aboluo
//  Created by zhufeng on 2018/11/22.
//  Copyright © 2018 zhufeng. All rights reserved.

#import "HomeProjectTypeVC.h"
#import "HomeProjectVC.h"
#import "HomeProjectCell.h"
#import "HomeMasterVC.h"
#import "HomeWorkTypeModel.h"
#import "HomeMasterVC.h"
@interface HomeProjectTypeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@end
@implementation HomeProjectTypeVC
- (void)viewDidLoad {
    [super viewDidLoad];
    if ([self.type isEqualToString:@"1"]) {
        //项目种类
        self.navigationItem.title = @"项目分类";
    }else{
        //工种种类
        self.navigationItem.title = @"工种分类";
    }
    [self setupCollectinoView];
}
/**
 创建视图
 */
-(void)setupCollectinoView
{
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    self.collectionview.backgroundColor = [UIColor clearColor];
    [self.collectionview registerNib:[UINib nibWithNibName:NSStringFromClass([HomeProjectCell class]) bundle:nil] forCellWithReuseIdentifier:@"HomeProjectCell"];
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.projectArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeProjectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeProjectCell" forIndexPath:indexPath];
    HomeWorkTypeModel *typemodel = self.projectArray[indexPath.row];
    cell.typemodel = typemodel;
    return  cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    HomeWorkTypeModel *projectmodel = self.projectArray[indexPath.row];
    if ([self.type isEqualToString:@"1"]) {
        //项目
        HomeProjectVC *projectvc= [[HomeProjectVC alloc]init];
        projectvc.typemodel = projectmodel;
        [self.navigationController pushViewController:projectvc animated:YES];
    }else{
        //工种
        HomeMasterVC *mastervc = [[HomeMasterVC alloc]init];
        mastervc.typemodel = projectmodel;
        [self.navigationController pushViewController:mastervc animated:YES];
        
    }

}
#pragma mark -item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(IPHONE_WIDTH/5,IPHONE_WIDTH/5);
}

@end
