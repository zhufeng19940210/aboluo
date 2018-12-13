//  InsurancesModel.h
//  aboluo
//  Created by zhufeng on 2018/12/11.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "BaseModel.h"

@interface InsurancesModel : BaseModel
@property (nonatomic,copy)NSString *coverage;  ///多少钱
@property (nonatomic,copy)NSString *iid;
@property (nonatomic,copy)NSString *premium;   ///保费
@property (nonatomic,assign)BOOL isSelect;
@end
