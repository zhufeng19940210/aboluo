//  MyOrderCell.m
//  aboluo
//  Created by zhufeng on 2018/12/13.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "MyOrderCell.h"
@interface MyOrderCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon_img;
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UILabel *area_lab;
@property (weak, nonatomic) IBOutlet UILabel *address_lab;
@property (weak, nonatomic) IBOutlet UIImageView *status_img;
@end
@implementation MyOrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
-(void)setOrdermodel:(MyOrderModel *)ordermodel
{
    _ordermodel = ordermodel;
    [_icon_img sd_setImageWithURL:[NSURL URLWithString:ordermodel.img] placeholderImage:[UIImage imageNamed:Default_Img]];
    _name_lab.text = ordermodel.name;
    _area_lab.text = @"";
    _address_lab.text = ordermodel.address;
    _status_img.image = @"";
}

@end
