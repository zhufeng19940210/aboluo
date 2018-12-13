//  StoreProductModel.m
//  aboluo
//  Created by zhufeng on 2018/12/11.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "StoreProductModel.h"
@implementation StoreProductModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"pid": @"id"
             };
}
@end
