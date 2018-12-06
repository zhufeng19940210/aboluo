//  HomeProductTypeCell.m
//  aboluo
//  Created by zhufeng on 2018/11/29.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "HomeProductTypeCell.h"
#import "HomeProductTypeDetailCell.h"
#import "HomeProductTypeModel.h"
@interface HomeProductTypeCell() <UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak) UICollectionView * myCollectionView;
@end

@implementation HomeProductTypeCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if ([super initWithFrame:frame]) {
    
        [self setupCollectView];
    }
    return self;
}
-(void)setProductTypeArray:(NSMutableArray *)productTypeArray
{
    _productTypeArray = productTypeArray;
    [self.myCollectionView reloadData];
}
-(void)setupCollectView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout  alloc]init];
    flowLayout.minimumInteritemSpacing = 0;
    //上下的间距，可以设置0的
    flowLayout.minimumLineSpacing = 0;
    //设置间隔
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //滚动的方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *mycollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, 150) collectionViewLayout:flowLayout];
    mycollectionView.delegate = self;
    mycollectionView.dataSource = self;
    mycollectionView.clipsToBounds = NO;
    mycollectionView.backgroundColor = [UIColor clearColor];
    mycollectionView.showsVerticalScrollIndicator = NO;
    mycollectionView.showsHorizontalScrollIndicator = NO;
    [mycollectionView registerNib:[UINib nibWithNibName:@"HomeProductTypeDetailCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"HomeProductTypeDetailCell"];
    [self addSubview:mycollectionView];
    _myCollectionView = mycollectionView;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = 120;
    CGFloat height = 140;
    return CGSizeMake (width,height);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.productTypeArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    HomeProductTypeDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeProductTypeDetailCell" forIndexPath:indexPath];
    HomeProductTypeModel *model = self.productTypeArray[indexPath.row];
    [cell.icon_img sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:[UIImage imageNamed:Default_Img]];
    cell.title_lab.text = [NSString stringWithFormat:@"%@",model.name];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    HomeProductTypeModel *model = self.productTypeArray[indexPath.row];
    if (self.producttypeblock) {
        self.producttypeblock(model);
    }
}
@end
