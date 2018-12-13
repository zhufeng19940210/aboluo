//  MyOrderModel.h
//  aboluo
//  Created by zhufeng on 2018/12/13.
//  Copyright © 2018 zhufeng. All rights reserved.

#import "BaseModel.h"

@interface MyOrderModel : BaseModel
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *checkWay;
@property (nonatomic,copy)NSString *companyLevelId;
@property (nonatomic,copy)NSString *contact;
@property (nonatomic,copy)NSString *contents;
@property (nonatomic,copy)NSString *cost;
@property (nonatomic,copy)NSString *createTime;
@property (nonatomic,copy)NSString *engineerId;
@property (nonatomic,copy)NSString *img;
@property (nonatomic,copy)NSString *insuranceId;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *overTime;
@property (nonatomic,copy)NSString *productId;
@property (nonatomic,copy)NSString *receivederId;
@property (nonatomic,copy)NSString *receivederList;
@property (nonatomic,copy)NSString *senderId;
@property (nonatomic,copy)NSString *startTime;
@property (nonatomic,copy)NSString *state;
/*
address = "\U6c5f\U897f\U7701\U5357\U660c\U5e02";
checkWay = 0;
companyLevelId = 2;
contact = "\U738b\U8001\U4e94";
contents = "\U5730\U7406\U4f4d\U7f6e\U597d";
cost = 6999;
createTime = 1544076040000;
engineerId = 0;
img = "http://lanpangzi.oss-cn-beijing.aliyuncs.com/data/CB3F0A9B841347BEB899E2BFC7085FB3.png?Expires=1860070568&OSSAccessKeyId=LTAIUsQLyTCbTOCx&Signature=w751HTx%2F1sHnXUPiE3pambRem5w%3D";
insuranceId = 1;
name = "\U592a\U5b50\U6bbf\U65b0\U589e\U53d1\U8d22\U9879\U76ee";
overTime = "2018-11-29";
overTime = 13065132030;
productId = 6;
projectId = 18;
receivederId = 12;
receivederList = "1,1544175195202.jpg;12,1544175022852.jpg;";
senderId = 12;
startTime = "2018-11-02";
state = 1;
 */
@end
