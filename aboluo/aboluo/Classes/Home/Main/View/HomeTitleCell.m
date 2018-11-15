//  HomeTitleCell.m
//  aboluo
//  Created by zhufeng on 2018/11/12.
//  Copyright © 2018 zhufeng. All rights reserved.

#import "HomeTitleCell.h"

@implementation HomeTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
}
/**
 跳转页面
 @param sender 跳转页面
 */
- (IBAction)actionPushBtn:(UIButton *)sender
{
    if (self.pushblock) {
        self.pushblock(sender);
    }
}
@end
