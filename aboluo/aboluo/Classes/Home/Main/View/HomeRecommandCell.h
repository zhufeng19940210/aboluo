//  HomeRecommandCell.h
//  aboluo
//  Created by zhufeng on 2018/11/12.
//  Copyright © 2018 zhufeng. All rights reserved.

#import <UIKit/UIKit.h>
#import "HomeProjectDetailModel.h"
typedef void (^ProjectBlock)(HomeProjectDetailModel *productModel);
@interface HomeRecommandCell : UICollectionViewCell
@property (nonatomic,strong)HomeProjectDetailModel *productModel;
@property (nonatomic,copy)ProjectBlock projcectblock;
@end
