//  MasterCell.m
//  aboluo
//  Created by zhufeng on 2018/11/15.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "MasterCell.h"
@interface MasterCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon_img;
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UILabel *level_lab;
@property (weak, nonatomic) IBOutlet UILabel *good_lab;
@property (weak, nonatomic) IBOutlet UILabel *time_lab;
@end
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

-(void)setMastermodel:(HomeMasterModel *)mastermodel
{
    _mastermodel = mastermodel;
    [_icon_img sd_setImageWithURL:[NSURL URLWithString:mastermodel.head] placeholderImage:[UIImage imageNamed:Default_Img]];
    _name_lab.text = [NSString stringWithFormat:@"姓名:%@",mastermodel.name];
    _level_lab.text = [NSString stringWithFormat:@"会员等级:%@",mastermodel.memberRank];
    _time_lab.text  = [NSString stringWithFormat:@"会员时间:%@",mastermodel.create_time];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
