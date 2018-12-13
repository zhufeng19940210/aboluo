//  EngineerModel.h
//  aboluo
//  Created by zhufeng on 2018/12/11.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "BaseModel.h"
@interface EngineerModel : BaseModel
@property (nonatomic,copy)NSString *eid;
@property (nonatomic,copy)NSString *img;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)BOOL isSelect;
@end
