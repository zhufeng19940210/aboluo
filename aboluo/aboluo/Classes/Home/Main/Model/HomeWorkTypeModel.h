//  HomeWorkTypeModel.h
//  aboluo
//  Created by zhufeng on 2018/11/22.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "BaseModel.h"
@interface HomeWorkTypeModel : BaseModel
@property (nonatomic,copy)NSString *wid;
@property (nonatomic,copy)NSString *img;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *parentId;
@end
