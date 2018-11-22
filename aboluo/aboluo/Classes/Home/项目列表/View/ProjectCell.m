//  ProjectCell.m
//  aboluo
//  Created by zhufeng on 2018/11/15.
//  Copyright © 2018 zhufeng. All rights reserved.

#import "ProjectCell.h"
@interface ProjectCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon_img;
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UILabel *masterlevel_lab;
@property (weak, nonatomic) IBOutlet UILabel *total_lab;
@property (weak, nonatomic) IBOutlet UILabel *time_lab;
@end
@implementation ProjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
+ (instancetype)projectcellWithTableView:(UITableView *)tableView{
    ProjectCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    }
    return cell;
}
/**
 抢单Btn
 @param sender 抢单button
 */
- (IBAction)actionGraborderBtn:(UIButton *)sender
{
    NSLog(@"抢单");
}

-(void)setDetailModel:(HomeProjectDetailModel *)detailModel
{
    _detailModel = detailModel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}
@end
