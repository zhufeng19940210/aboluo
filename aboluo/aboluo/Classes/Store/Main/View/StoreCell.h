//  StoreCell.h
//  aboluo
//  Created by zhufeng on 2018/11/16.
//  Copyright © 2018 zhufeng. All rights reserved.
#import <UIKit/UIKit.h>
#import "StoreProductModel.h"
@interface StoreCell : UITableViewCell
@property (nonatomic,strong)StoreProductModel *productmodel;
+ (instancetype)stroeCellWithTableView:(UITableView *)tableView;
@end
