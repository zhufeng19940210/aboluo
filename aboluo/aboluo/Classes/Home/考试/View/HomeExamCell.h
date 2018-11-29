//  HomeExamCell.h
//  aboluo
//  Created by zhufeng on 2018/11/22.
//  Copyright © 2018 zhufeng. All rights reserved.
#import <UIKit/UIKit.h>
#import "ExamModel.h"
@interface HomeExamCell : UITableViewCell
@property (nonatomic,strong)ExamModel *exammodel;
+ (instancetype)HomecellWithTableView:(UITableView *)tableView;
@end
