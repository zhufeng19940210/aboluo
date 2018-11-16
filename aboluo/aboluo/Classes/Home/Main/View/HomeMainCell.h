//  HomeMainCell.h
//  aboluo
//  Created by zhufeng on 2018/11/12.
//  Copyright © 2018 zhufeng. All rights reserved.

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,HomeMianType) {
    HomeMianTypeOrder   = 1000,//接单大厅
    HomeMianTypeBilling = 2000,//发单大厅
};
@interface HomeMainCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *billing_img;
@property (weak, nonatomic) IBOutlet UIImageView *order_img;
@property (nonatomic,copy)void (^MainActionBlock)(HomeMianType type);
@end
