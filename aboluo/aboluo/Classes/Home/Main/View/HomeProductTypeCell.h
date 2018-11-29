//  HomeProductTypeCell.h
//  aboluo
//  Created by zhufeng on 2018/11/29.
//  Copyright © 2018 zhufeng. All rights reserved
#import <UIKit/UIKit.h>
#import "HomeProductTypeModel.h"
typedef void(^ProductTypeBlock)(HomeProductTypeModel *typeModel);
@interface HomeProductTypeCell : UICollectionViewCell
@property (nonatomic,strong)NSMutableArray *productTypeArray;
@property (nonatomic,copy)ProductTypeBlock producttypeblock;
@end
