//  StoreDetailModel.m
//  aboluo
//  Created by zhufeng on 2018/12/8.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "StoreDetailModel.h"
@implementation StoreDetailModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"sid": @"id"
             };
}
@end
