//  UserModel.m
//  aboluo
//  Created by zhufeng on 2018/11/3.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import "UserModel.h"
static NSString *UserModelKey = @"UserModelKey";
@implementation UserModel
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"aid": @"id"
             };
}
+ (void)save:(UserModel *)model
{
    NSDictionary *user = model.mj_keyValues;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:user forKey:UserModelKey];
    [defaults synchronize];
}
+ (UserModel *)getInfo
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:UserModelKey];
    UserModel *user =[UserModel mj_objectWithKeyValues:dict];
    return user;
}
+ (BOOL)isOnline
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:UserModelKey];
    UserModel *user =[UserModel mj_objectWithKeyValues:dict];
    if (user.aid.length>0)
        return YES;
    return NO;
}
+ (void)logout
{
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:UserModelKey];
    UserModel *user =[UserModel mj_objectWithKeyValues:dict];
    user.aid = nil;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:user.mj_keyValues forKey:UserModelKey];
    [defaults synchronize];
}
@end
