//  HomeProjectDetailModel.h
//  aboluo
//  Created by zhufeng on 2018/11/22.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "BaseModel.h"
@interface HomeProjectDetailModel : BaseModel
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *checkWay;
@property (nonatomic,copy) NSString *companyLevelId;
@property (nonatomic,copy) NSString *contents;
@property (nonatomic,copy) NSString *cost;
@property (nonatomic,copy) NSString *createTime;
@property (nonatomic,copy) NSString *engineerId;
@property (nonatomic,copy) NSString *rid;
@property (nonatomic,copy) NSString *img;
@property (nonatomic,copy) NSString *insuranceId;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *overTime;
@property (nonatomic,copy) NSString *productId;
@property (nonatomic,copy) NSString *receivederId;
@property (nonatomic,copy) NSString *receivederList;
@property (nonatomic,copy) NSString *sellerId;
@property (nonatomic,copy) NSString *senderId;
@property (nonatomic,copy) NSString *startTime;
@property (nonatomic,copy) NSString *state;
@property (nonatomic,copy) NSString *total;

/*
 address = "\U5730\U7406\U4f4d\U7f6e\U597d";
 checkWay = 0;
 companyLevelId = 2;
 contents = "\U5730\U7406\U4f4d\U7f6e\U597d";
 cost = 1000;
 createTime = 1543569675000;
 engineerId = 1;
 id = 1;
 img = "http://lanpangzi.oss-cn-beijing.aliyuncs.com/data/1544153020176.png?Expires=1859615889&OSSAccessKeyId=LTAIUsQLyTCbTOCx&Signature=zctX9GtKmXIojHToyu6J3%2F7z2gg%3D";
 insuranceId = 1;
 name = "\U8fd9\U662f12\U67087\U53f7\U53d1\U5355";
 overTime = "2018-11-29";
 productId = 4;
 receivederId = 0;
 receivederList = "1,1544175195202.jpg;12,1544175022852.jpg;";
 senderId = 1;
 startTime = "2018-11-02";
 state = 0;
 total = 300;
 */
@end
