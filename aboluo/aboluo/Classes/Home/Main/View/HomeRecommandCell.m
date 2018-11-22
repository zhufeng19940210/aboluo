//  HomeRecommandCell.m
//  aboluo
//  Created by zhufeng on 2018/11/12.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "HomeRecommandCell.h"
@interface HomeRecommandCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon_img;
@property (weak, nonatomic) IBOutlet UILabel *name_lab;
@property (weak, nonatomic) IBOutlet UILabel *total_lab;
@property (weak, nonatomic) IBOutlet UILabel *type_lab;
@property (weak, nonatomic) IBOutlet UILabel *time_lab;
@end

@implementation HomeRecommandCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
/**
 抢单button
 @param sender 抢单button
 */
- (IBAction)actionGraborderBtn:(UIButton *)sender
{
    
}
@end
