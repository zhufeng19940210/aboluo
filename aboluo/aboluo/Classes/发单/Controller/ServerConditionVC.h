//  ServerConditionVC.h
//  aboluo
//  Created by zhufeng on 2018/12/10.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "BaseVC.h"
#import "GongZhongModel.h"
typedef void (^ConditionBlock) (GongZhongModel *model);
@interface ServerConditionVC : BaseVC
@property (nonatomic,copy)ConditionBlock conditionblock;
@end
