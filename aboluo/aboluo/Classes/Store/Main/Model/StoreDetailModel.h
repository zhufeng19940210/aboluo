//  StoreDetailModel.h
//  aboluo
//  Created by zhufeng on 2018/12/8.
//  Copyright © 2018 zhufeng. All rights reserved.

#import "BaseModel.h"

@interface StoreDetailModel : BaseModel
@property (nonatomic,copy) NSString *sid;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *parentId;
@end
