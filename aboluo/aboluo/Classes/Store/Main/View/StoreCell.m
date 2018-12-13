//  StoreCell.m
//  aboluo
//  Created by zhufeng on 2018/11/16.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "StoreCell.h"
@interface StoreCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon_img;
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UILabel *jifenjia_lab;
@property (weak, nonatomic) IBOutlet UILabel *pirce_lab;
@property (weak, nonatomic) IBOutlet UILabel *number_lab;
@end
@implementation StoreCell

- (void)awakeFromNib {

    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
}

+ (instancetype)stroeCellWithTableView:(UITableView *)tableView{
    StoreCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    }
    return cell;
}

-(void)setProductmodel:(StoreProductModel *)productmodel
{
    _productmodel = productmodel;
    [_icon_img sd_setImageWithURL:[NSURL URLWithString:productmodel.img] placeholderImage:[UIImage imageNamed:Default_Img]];
    _name_lab.text = [NSString stringWithFormat:@"%@",productmodel.name];
    _jifenjia_lab.text = [NSString stringWithFormat:@"积分价:+%@",productmodel.credit];
    _pirce_lab.text = [NSString stringWithFormat:@"￥%2.f",[productmodel.salePrice doubleValue]];
    _number_lab.text = [NSString stringWithFormat:@"%@购买",productmodel.supplyPrice];
}
@end
