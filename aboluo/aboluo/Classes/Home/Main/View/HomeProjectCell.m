//  HomeProjectCell.m
//  aboluo
//  Created by zhufeng on 2018/11/12.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "HomeProjectCell.h"
@interface HomeProjectCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon_img;
@property (weak, nonatomic) IBOutlet UILabel *title_lab;
@end
@implementation HomeProjectCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
/**
 工种分类
 @param typemodel 工种分类
 */
-(void)setTypemodel:(HomeWorkTypeModel *)typemodel
{
    _typemodel = typemodel;
    [_icon_img sd_setImageWithURL:[NSURL URLWithString:typemodel.img] placeholderImage:[UIImage imageNamed:Default_Img]];
    _title_lab.text = [NSString stringWithFormat:@"%@",typemodel.name];
}
/**
 项目分类
 @param xiangmumodel 项目分类
 */
-(void)setXiangmumodel:(HomeXiangmuModel *)xiangmumodel
{
    _xiangmumodel = xiangmumodel;
    [_icon_img sd_setImageWithURL:[NSURL URLWithString:xiangmumodel.img1] placeholderImage:[UIImage imageNamed:Default_Img]];
    _title_lab.text = [NSString stringWithFormat:@"%@",xiangmumodel.name];
}
@end
