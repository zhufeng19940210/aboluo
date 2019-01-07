//
//  HomeMasterDetailModel.h
//  aboluo
//
//  Created by zhufeng on 2018/12/20.
//  Copyright © 2018 zhufeng. All rights reserved.
//

#import "BaseModel.h"

@interface HomeMasterDetailModel : BaseModel
@property (nonatomic,copy)NSString *projectAmount;
@property (nonatomic,strong)NSDictionary *user;
//@property (nonatomic,copy)NSString *coupon;
//@property (nonatomic,copy)NSString *createTime;
//@property (nonatomic,copy)NSString *credit;
//@property (nonatomic,copy)NSString *freezeCredit;
//@property (nonatomic,copy)NSString *head;
//@property (nonatomic,copy)NSString *identify;
//@property (nonatomic,copy)NSString *hid;
//@property (nonatomic,copy)NSString *levelId;
//@property (nonatomic,copy)NSString *phone;
//@property (nonatomic,copy)NSString *recommendId;
//@property (nonatomic,copy)NSString *roleId;
//@property (nonatomic,copy)NSString *identify;
//@property (nonatomic,copy)NSString *latitude;
//@property (nonatomic,copy)NSString *longitude;
//@property (nonatomic,copy)NSString *password;
/*
projectAmount = 6;
user =         {
    commerce =             {
        id = 1;
        name = "\U6c5f\U897f\U5546\U4f1a";
        recommendId = 1;
    };
    coupon = 0;
    createTime = 1543571023000;
    credit = 18000;
    freezeCredit = 0;
    head = "http://lanpangzi.oss-cn-beijing.aliyuncs.com/data/1544175195202.jpg?Expires=1860657968&OSSAccessKeyId=LTAIUsQLyTCbTOCx&Signature=CVmR03w9K3ZyiPIoX8yqI0qAVhI%3D";
    id = 1;
    identify = 1;
    latitude = 0;
    levelId = 2;
    longitude = 0;
    password = e10adc3949ba59abbe56e057f20f883e;
    phone = 13065132030;
    recommendId = 0;
    roleId = 1;
 */
@end
