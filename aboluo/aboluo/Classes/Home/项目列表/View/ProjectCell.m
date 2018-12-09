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
    if (self.projectblock) {
        self.projectblock(self.detailModel);
    }
}
-(void)setDetailModel:(HomeProjectDetailModel *)detailModel
{
    _detailModel = detailModel;
    [_icon_img sd_setImageWithURL:[NSURL URLWithString:detailModel.img] placeholderImage:[UIImage imageNamed:Default_Img]];
    _name_lab.text = [NSString stringWithFormat:@"%@",detailModel.name];
    if ([detailModel.companyLevelId isEqualToString:@"0"] ) {
        ///个人接单
         _masterlevel_lab.text = [NSString stringWithFormat:@"师傅等级:%@",detailModel.engineerId];
    }else{
        //企业接单
        _masterlevel_lab.text = [NSString stringWithFormat:@"企业等级:%@",detailModel.companyLevelId];
    }
    _total_lab.text = [NSString stringWithFormat:@"项目费用:%.2f元",[detailModel.cost doubleValue]];
    _time_lab.text = [NSString stringWithFormat:@"时间:%@至%@",detailModel.startTime,detailModel.overTime];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}
@end
