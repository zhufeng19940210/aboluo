//  AddressListCell.m
//  aboluo
//  Created by zhufeng on 2018/11/19.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "AddressListCell.h"
@implementation AddressListCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
+ (instancetype)AddressCellWithTableView:(UITableView *)tableView{
    AddressListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (cell == nil) {
        cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].lastObject;
    }
    return cell;
}
-(void)setAddressmodel:(AddressModel *)addressmodel
{
    _addressmodel = addressmodel;
}
@end
