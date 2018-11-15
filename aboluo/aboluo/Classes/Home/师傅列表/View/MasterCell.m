//  MasterCell.m
//  aboluo
//  Created by zhufeng on 2018/11/15.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "MasterCell.h"

@implementation MasterCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

+ (instancetype)masterCellWithTableView:(UITableView *)tableView{
    MasterCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    }
    return cell;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
