//  StoreCell.h
//  aboluo
//  Created by zhufeng on 2018/11/16.
//  Copyright © 2018 zhufeng. All rights reserved.
#import <UIKit/UIKit.h>
@interface StoreCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *test_lab;
+ (instancetype)stroeCellWithTableView:(UITableView *)tableView;
@end
