//  UserModel.h
//  aboluo
//  Created by zhufeng on 2018/11/3.
//  Copyright © 2018年 zhufeng. All rights reserved.
#import <Foundation/Foundation.h>
@interface UserModel : NSObject
@property (nonatomic,copy)NSString  *commerceId;
@property (nonatomic,copy)NSString  *createTime;
@property (nonatomic,copy)NSString  *head;
@property (nonatomic,copy)NSString  *aid;
@property (nonatomic,copy)NSString  *identify;
@property (nonatomic,copy)NSString  *latitude;
@property (nonatomic,copy)NSString  *levelId;
@property (nonatomic,copy)NSString  *longitude;
@property (nonatomic,copy)NSString  *password;
@property (nonatomic,copy)NSString  *phone;
@property (nonatomic,copy)NSString  *recommendId;
@property (nonatomic,copy)NSString  *roleId;
+ (void)save:(UserModel *)model;
+ (UserModel *)getInfo;
+ (BOOL)isOnline;
+ (void)logout;
@end
