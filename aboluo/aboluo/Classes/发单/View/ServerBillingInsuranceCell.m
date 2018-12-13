//  ServerBillingInsuranceCell.m
//  aboluo
//  Created by zhufeng on 2018/12/4.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "ServerBillingInsuranceCell.h"

@implementation ServerBillingInsuranceCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
/**
 选择保险类型
 @param sender 选择保险类型
 */
- (IBAction)actionSelectInsuranceBtn:(UIButton *)sender
{
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(pushToInsuranceMethod)]) {
            [self.delegate pushToInsuranceMethod];
        }
    }
}
@end
