//  CompanyModel.h
//  aboluo
//  Created by zhufeng on 2018/12/11.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "BaseModel.h"

@interface CompanyModel : BaseModel
@property (nonatomic,copy)NSString *cid;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *onePay;
@property (nonatomic,copy)NSString *twoPay;
@property (nonatomic,assign)BOOL isSelect;
@end
