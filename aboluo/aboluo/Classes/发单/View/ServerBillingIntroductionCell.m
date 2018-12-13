//  ServerBillingIntroductionCell.m
//  aboluo
//  Created by zhufeng on 2018/12/4.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "ServerBillingIntroductionCell.h"
@implementation ServerBillingIntroductionCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.intraductaion_view.placeholder = @"请输入项目的描述,字数不要超过200字";
    self.intraductaion_view.font = [UIFont systemFontOfSize:15];
    self.intraductaion_view.textColor = MainThemeColor;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
