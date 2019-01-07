//
//  ProjectDetailHeaderCell.h
//  aboluo
//
//  Created by zhufeng on 2018/12/9.
//  Copyright © 2018 zhufeng. All rights reserved.
//

#import "BaseCell.h"

@interface ProjectDetailHeaderCell : BaseCell
@property (weak, nonatomic) IBOutlet SDCycleScrollView *adscrollview;
@property (weak, nonatomic) IBOutlet UILabel *content_lab;
@end
