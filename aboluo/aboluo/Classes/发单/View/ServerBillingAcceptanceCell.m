//  ServerBillingAcceptanceCell.m
//  aboluo
//  Created by zhufeng on 2018/12/4.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "ServerBillingAcceptanceCell.h"
@implementation ServerBillingAcceptanceCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
/**
 选择验收成功
 @param sender 选择验收成功
 */
- (IBAction)actionSelctYanshouBtn:(UIButton *)sender
{
    int tag = (int)sender.tag;
    if (tag == 0) {
        //自主验收
        [self.mySelf_btn setImage:[UIImage imageNamed:@"Server_Circle_Select"] forState:UIControlStateNormal];
        [self.mySelf_btn setTitle:@"自主验收" forState:UIControlStateNormal];
        [self.mySelf_btn setTitleColor:MainThemeColor forState:UIControlStateNormal];
        [self.pingtai_btn setImage:[UIImage imageNamed:@"Server_Circle_normal"] forState:UIControlStateNormal];
        [self.pingtai_btn setTitle:@"平台验收" forState:UIControlStateNormal];
        [self.pingtai_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        //平台验收
        [self.mySelf_btn setImage:[UIImage imageNamed:@"Server_Circle_normal"] forState:UIControlStateNormal];
        [self.mySelf_btn setTitle:@"自主验收" forState:UIControlStateNormal];
        [self.mySelf_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.pingtai_btn setImage:[UIImage imageNamed:@"Server_Circle_Select"] forState:UIControlStateNormal];
        [self.pingtai_btn setTitle:@"平台验收" forState:UIControlStateNormal];
        [self.pingtai_btn setTitleColor:MainThemeColor forState:UIControlStateNormal];
    }
    if (self.accptanceblock) {
        self.accptanceblock(tag);
    }
}
@end
