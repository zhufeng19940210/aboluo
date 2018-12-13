//  GongZhongModel.h
//  aboluo
//  Created by zhufeng on 2018/12/11.
//  Copyright © 2018 zhufeng. All rights reserved
#import "BaseModel.h"

@interface GongZhongModel : BaseModel
@property (nonatomic,copy)NSString *gid;
@property (nonatomic,copy)NSString *img;
@property (nonatomic,copy)NSString *img1;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *parentId;
@property (nonatomic,assign)BOOL isSelect;
@end
