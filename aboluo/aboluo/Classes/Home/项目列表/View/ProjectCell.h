//  ProjectCell.h
//  aboluo
//  Created by zhufeng on 2018/11/15.
//  Copyright © 2018 zhufeng. All rights reserved.
#import <UIKit/UIKit.h>
#import "HomeProjectDetailModel.h"
@interface ProjectCell : UITableViewCell
@property (nonatomic,strong)HomeProjectDetailModel *detailModel;
+ (instancetype)projectcellWithTableView:(UITableView *)tableView;
@end
