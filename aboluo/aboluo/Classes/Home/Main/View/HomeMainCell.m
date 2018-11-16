//  HomeMainCell.m
//  aboluo
//  Created by zhufeng on 2018/11/12.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "HomeMainCell.h"
@implementation HomeMainCell
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setupUI];
}
-(void)setupUI
{
    self.billing_img.userInteractionEnabled = YES;
    self.order_img.userInteractionEnabled   = YES;
    UITapGestureRecognizer *tapGesture  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionBillingBtn:)];
    UITapGestureRecognizer *tap2Gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionOrderBtn:)];
    [self.billing_img addGestureRecognizer:tapGesture];
    [self.order_img addGestureRecognizer:tap2Gesture];
}

/**
 发单大厅
 @param gesture 发单大厅
 */
-(void)actionBillingBtn:(UITapGestureRecognizer *)gesture
{
    NSLog(@"biliing.tag:%ld",gesture.view.tag);
    if (self.MainActionBlock) {
        self.MainActionBlock((HomeMianType)gesture.view.tag);
    }
}
/**
 接单大厅
 @param gesture 接单大厅
 */
-(void)actionOrderBtn:(UITapGestureRecognizer *)gesture
{
    NSLog(@"order.tag:%ld",gesture.view.tag);
    if (self.MainActionBlock) {
        self.MainActionBlock((HomeMianType)gesture.view.tag);
    }
}
@end
