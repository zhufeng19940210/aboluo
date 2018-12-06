//  HomeProductTypeModel.h
//  aboluo
//  Created by zhufeng on 2018/11/29.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "BaseModel.h"
@interface HomeProductTypeModel : BaseModel
@property (nonatomic,copy)NSString *pid;
@property (nonatomic,copy)NSString *img;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *parentId;
@end
