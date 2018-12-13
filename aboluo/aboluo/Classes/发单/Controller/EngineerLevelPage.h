//  EngineerLevelPage.h
//  aboluo
//  Created by zhufeng on 2018/12/11.
//  Copyright © 2018 zhufeng. All rights reserved.

#import "BaseVC.h"
#import "EngineerModel.h"
typedef void (^EngineerLevelPageBlock) (EngineerModel *model);
@interface EngineerLevelPage : BaseVC
@property (nonatomic,copy) EngineerLevelPageBlock engineerblock;
@end
