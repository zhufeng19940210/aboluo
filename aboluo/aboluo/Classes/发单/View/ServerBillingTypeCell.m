//  ServerBillingTypeCell.m
//  aboluo
//  Created by zhufeng on 2018/12/4.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "ServerBillingTypeCell.h"

@implementation ServerBillingTypeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
/**
 选择工作
 @param sender 选择工种
 */
- (IBAction)actionPushSelectTypeBtn:(UIButton *)sender
{
    if (self.deelgate) {
        if ([self.deelgate respondsToSelector:@selector(pushSelectTypeMethod)]) {
            [self.deelgate pushSelectTypeMethod];
        }
    }
}
@end
