//  HomeBanner.h
//  aboluo
//  Created by zhufeng on 2018/11/21.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "BaseModel.h"
@interface HomeBanner : BaseModel
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *hid;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,assign)int turn;
@property (nonatomic,assign)int type;
@property (nonatomic,copy)NSString *url;
@end
