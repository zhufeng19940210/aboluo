//  AddressModel.h
//  aboluo
//  Created by zhufeng on 2018/11/22.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "BaseModel.h"
@interface AddressModel : BaseModel
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *detail;
@property (nonatomic,assign)int isDefault;
@end
