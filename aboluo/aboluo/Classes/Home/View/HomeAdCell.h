//  HomeAdCell.h
//  aboluo
//  Created by zhufeng on 2018/11/12.
//  Copyright © 2018 zhufeng. All rights reserved
#import <UIKit/UIKit.h>
@interface HomeAdCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet SDCycleScrollView *cycleview;
@property (nonatomic,strong)NSArray *urlArray;
@end
