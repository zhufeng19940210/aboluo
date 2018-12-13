//  CompanyLevelPage.h
//  aboluo
//  Created by zhufeng on 2018/12/11.
//  Copyright © 2018 zhufeng. All rights reserved.

#import "BaseVC.h"
#import "CompanyModel.h"
typedef void (^CompanyLevelPageBlock) (CompanyModel *model);
@interface CompanyLevelPage : BaseVC
@property (nonatomic,copy)CompanyLevelPageBlock commpayblcok;
@end
