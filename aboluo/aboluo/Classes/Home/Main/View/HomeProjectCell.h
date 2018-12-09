//  HomeProjectCell.h
//  aboluo
//  Created by zhufeng on 2018/11/12.
//  Copyright © 2018 zhufeng. All rights reserved.
#import <UIKit/UIKit.h>
#import "HomeWorkTypeModel.h"
#import "HomeXiangmuModel.h"
@interface HomeProjectCell : UICollectionViewCell
@property (nonatomic,strong)HomeWorkTypeModel *typemodel;
@property (nonatomic,strong)HomeXiangmuModel *xiangmumodel;
@end
