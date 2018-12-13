//  InsurancesModel.m
//  aboluo
//  Created by zhufeng on 2018/12/11.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "InsurancesModel.h"

@implementation InsurancesModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"iid": @"id"
             };
}
@end
