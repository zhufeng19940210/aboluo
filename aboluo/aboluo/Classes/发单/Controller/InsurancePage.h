//  InsurancePage.h
//  aboluo
//  Created by zhufeng on 2018/12/11.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "BaseVC.h"
#import "InsurancesModel.h"
typedef void (^InsurancePageBlock) (InsurancesModel *model);
@interface InsurancePage : BaseVC
@property (nonatomic,copy)InsurancePageBlock insuracnepageblock;
@end
