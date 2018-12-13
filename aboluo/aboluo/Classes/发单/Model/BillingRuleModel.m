//  BillingRuleModel.m
//  aboluo
//
//  Created by zhufeng on 2018/12/11.
//  Copyright © 2018 zhufeng. All rights reserved.
//

#import "BillingRuleModel.h"

@implementation BillingRuleModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"rid": @"id"
             };
}
@end
