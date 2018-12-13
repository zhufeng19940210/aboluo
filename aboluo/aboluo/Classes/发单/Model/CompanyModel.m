//  CompanyModel.m
//  aboluo
//  Created by zhufeng on 2018/12/11.
//  Copyright © 2018 zhufeng. All rights reserved
#import "CompanyModel.h"

@implementation CompanyModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"cid": @"id"
             };
}
@end
