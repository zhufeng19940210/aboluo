//  HomeProjectCell.h
//  aboluo
//  Created by zhufeng on 2018/11/12.
//  Copyright © 2018 zhufeng. All rights reserved.
#import <UIKit/UIKit.h>

@interface HomeProjectCell : UICollectionViewCell
/**
 图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *icon_img;
/**
 标题
 */
@property (weak, nonatomic) IBOutlet UILabel *title_lab;
@end
