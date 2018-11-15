//  HomeAdCell.m
//  aboluo
//  Created by zhufeng on 2018/11/12.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "HomeAdCell.h"
@implementation HomeAdCell
- (void)awakeFromNib {
    [super awakeFromNib];
}
-(void)setUrlArray:(NSArray *)urlArray
{
    _urlArray = urlArray;
    self.cycleview.imageURLStringsGroup = urlArray;
}
@end
