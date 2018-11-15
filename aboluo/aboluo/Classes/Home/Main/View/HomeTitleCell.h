//  HomeTitleCell.h
//  aboluo
//  Created by zhufeng on 2018/11/12.
//  Copyright © 2018 zhufeng. All rights reserved.
#import <UIKit/UIKit.h>
typedef void(^PushBlock)(UIButton *btn);
@interface HomeTitleCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *title_lab;
@property (nonatomic,copy)PushBlock pushblock;
@end
