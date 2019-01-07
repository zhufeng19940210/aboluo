//  HomeRecommandCell.m
//  aboluo
//  Created by zhufeng on 2018/11/12.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "HomeRecommandCell.h"
@interface HomeRecommandCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon_img;
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UILabel *total_lab;
@property (weak, nonatomic) IBOutlet UILabel *type_lab;
@property (weak, nonatomic) IBOutlet UILabel *time_lab;
@end
@implementation HomeRecommandCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setProductModel:(HomeProjectDetailModel *)productModel
{
    _productModel = productModel;
    [_icon_img sd_setImageWithURL:[NSURL URLWithString:productModel.img] placeholderImage:[UIImage imageNamed:Default_Img]];
    _name_lab.text = [NSString stringWithFormat:@"%@",productModel.name];
    _total_lab.text = [NSString stringWithFormat:@"施工总费用:%.2f元",[productModel.cost doubleValue]];
    _type_lab.text = [NSString stringWithFormat:@"工种:%@",productModel.product[@"name"]];
    _time_lab.text = [NSString stringWithFormat:@"时间:%@至%@",productModel.startTime,productModel.overTime];
}
/**
 抢单button
 @param sender 抢单button
 */
- (IBAction)actionGraborderBtn:(UIButton *)sender
{
    if (self.projcectblock) {
        self.projcectblock(self.productModel);
    }
}
@end
