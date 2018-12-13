//  ServerBillingOrderTypeCell.m
//  aboluo
//  Created by zhufeng on 2018/12/4.
//  Copyright © 2018 zhufeng. All rights reserved
#import "ServerBillingOrderTypeCell.h"
@implementation ServerBillingOrderTypeCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.btn1.enabled = NO;
    self.btn2.enabled = NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
/**
 选择等级
 @param sender 选择等级
 */
- (IBAction)actionSelectLevelBtn:(UIButton *)sender
{
    int tag = (int)sender.tag;
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(pushSelectTypeWithTag:)]) {
            [self.delegate pushSelectTypeWithTag:tag];
        }
    }
}
/**
 选择类型
 @param sender 选择类型
 */
- (IBAction)actionSelectTypeBtn:(UIButton *)sender
{
    int tag = (int)sender.tag;
    if (tag == 0) {
        [self.person_btn setImage:[UIImage imageNamed:@"Server_Circle_Select"] forState:UIControlStateNormal];
        [self.person_btn setTitle:@"个人" forState:UIControlStateNormal];
        [self.person_btn setTitleColor:MainThemeColor forState:UIControlStateNormal];
        [self.company_btn setImage:[UIImage imageNamed:@"Server_Circle_normal"] forState:UIControlStateNormal];
        [self.company_btn setTitle:@"企业" forState:UIControlStateNormal];
        [self.company_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.btn1.enabled = YES;
        self.btn2.enabled = NO;
        self.company_tf.text = @"";
    }else{
        [self.person_btn setImage:[UIImage imageNamed:@"Server_Circle_normal"] forState:UIControlStateNormal];
        [self.person_btn setTitle:@"个人" forState:UIControlStateNormal];
        [self.person_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.company_btn setImage:[UIImage imageNamed:@"Server_Circle_Select"] forState:UIControlStateNormal];
        [self.company_btn setTitle:@"企业" forState:UIControlStateNormal];
        [self.company_btn setTitleColor:MainThemeColor forState:UIControlStateNormal];
        self.btn1.enabled = NO;
        self.btn2.enabled = YES;
        self.master_tf.text = @"";
    }
    if (self.selecttypeblock) {
        self.selecttypeblock(tag);
    }
}
@end
