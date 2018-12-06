//  SettingHeaderCell.m
//  aboluo
//  Created by zhufeng on 2018/11/25.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "SettingHeaderCell.h"

@implementation SettingHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
/**
 button的点击事件
 @param sender button的点击事件
 */
- (IBAction)actionHeaderBtn:(UIButton *)sender
{
    if (self.actionBlock) {
        self.actionBlock((SettingHeaderType)sender.tag);
    }
}
@end
