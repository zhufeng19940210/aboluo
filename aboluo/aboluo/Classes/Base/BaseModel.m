//  BaseModel.m
//  aboluo
//  Created by zhufeng on 2018/11/21.
//  Copyright © 2018 zhufeng. All rights reserved.

#import "BaseModel.h"

@implementation BaseModel
-(id)initWithDataModel:(NSDictionary *)dic;
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    return self;
}
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
@end
