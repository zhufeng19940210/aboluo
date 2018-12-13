//  ServerBillingHeaderCell.m
//  aboluo
//  Created by zhufeng on 2018/12/4.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "ServerBillingHeaderCell.h"
@implementation ServerBillingHeaderCell
- (void)awakeFromNib {
    [super awakeFromNib];
    self.statr_time_tf.delegate = self;
    self.end_time_tf.delegate   = self;
    self.cost_price_tf.delegate = self;
    [self.cost_price_tf addTarget:self action:@selector(actionCaltaPrice) forControlEvents:UIControlEventEditingChanged];
    [self.statr_time_tf addTarget:self action:@selector(actionCaltaPrice) forControlEvents:UIControlEventEditingChanged];
    [self.end_time_tf addTarget:self action:@selector(actionCaltaPrice) forControlEvents:UIControlEventEditingChanged];
}
-(void)actionCaltaPrice{
    NSLog(@"计算价格");
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(calateTotalPrice)]) {
            [self.delegate calateTotalPrice];
        }
    }
}
- (IBAction)actionSelectTimeBtn:(UIButton *)sender
{
    int tag = (int)sender.tag;
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(pushSelectTimeMethodWithTag:)]) {
            [self.delegate pushSelectTimeMethodWithTag:tag];
        }
    }
}
@end
