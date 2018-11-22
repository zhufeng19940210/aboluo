//  ExamModel.h
//  aboluo
//  Created by zhufeng on 2018/11/22.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "BaseModel.h"

@interface ExamModel : BaseModel
@property (nonatomic,copy)NSString *pid;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *result;
@property (nonatomic,copy)NSString *selectStr;
@end
