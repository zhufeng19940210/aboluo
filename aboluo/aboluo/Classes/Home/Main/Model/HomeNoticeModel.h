//  HomeNoticeModel.h
//  aboluo
//  Created by zhufeng on 2018/11/21.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "BaseModel.h"
@interface HomeNoticeModel : BaseModel
@property (nonatomic,copy) NSString *contents;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *nid;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *productId;
@property (nonatomic,copy) NSString *style;
@end
