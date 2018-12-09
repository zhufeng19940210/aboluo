//  SettingHeaderCell.m
//  aboluo
//  Created by zhufeng on 2018/11/25.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "SettingHeaderCell.h"

@implementation SettingHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.icon_img.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionIconGesture:)];
    [self.icon_img addGestureRecognizer:tap];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
#pragma mark -- actionIconGesture
-(void)actionIconGesture:(UITapGestureRecognizer *)gesture
{
    int tag =(int)gesture.view.tag;
    if (self.actionBlock) {
        self.actionBlock((SettingHeaderType)tag);
    }
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
