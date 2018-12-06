//  ServerBillingPictureCell.m
//  aboluo
//  Created by zhufeng on 2018/12/4.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "ServerBillingPictureCell.h"
#import "ZFSquareAddCollectionCell.h"
#import "ZFSquareCollectionViewCell.h"
@interface ServerBillingPictureCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionview;
@end
@implementation ServerBillingPictureCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupcollectionView];
}
-(void)setSelectArray:(NSMutableArray *)selectArray
{
    _selectArray = selectArray;
    [self.collectionview reloadData];
}
-(void)setupcollectionView{
    self.collectionview.delegate = self;
    self.collectionview.dataSource = self;
    //注册cell
    [self.collectionview registerNib:[UINib nibWithNibName:@"ZFSquareAddCollectionCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ZFSquareAddCollectionCell"];
    [self.collectionview registerNib:[UINib nibWithNibName:@"ZFSquareCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"ZFSquareCollectionViewCell"];
}

#pragma mark - UICollectionViewDelegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.selectArray.count + 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.selectArray.count) {
        ZFSquareAddCollectionCell *addItemCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZFSquareAddCollectionCell" forIndexPath:indexPath];
        return addItemCell;
    }
    ZFSquareCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ZFSquareCollectionViewCell" forIndexPath:indexPath];
    cell.icon_img.image = self.selectArray[indexPath.row];
    return cell;
}
#pragma mark  - collectionFlowlayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (IPHONE_WIDTH-20)/4;
    return CGSizeMake(width,width);
}
//cell的最小行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}
//cell的最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == self.selectArray.count) {
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(BCYPhotoPushSelectWithType:)]) {
                [self.delegate BCYPhotoPushSelectWithType];
            }
        }
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
@end
