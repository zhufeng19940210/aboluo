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
-(void)setTypemodel:(HomeWorkTypeModel *)typemodel
{
    _typemodel = typemodel;
    [_icon_img sd_setImageWithURL:[NSURL URLWithString:typemodel.img] placeholderImage:[UIImage imageNamed:Default_Img]];
    _title_lab.text = [NSString stringWithFormat:@"%@",typemodel.name];
}
@end
