//  MasterCell.h
//  aboluo
//  Created by zhufeng on 2018/11/15.
//  Copyright © 2018 zhufeng. All rights reserved.

#import <UIKit/UIKit.h>
#import "HomeMasterModel.h"
@interface MasterCell : UITableViewCell
@property (nonatomic,strong)HomeMasterModel *mastermodel;
+ (instancetype)masterCellWithTableView:(UITableView *)tableView;
@end
