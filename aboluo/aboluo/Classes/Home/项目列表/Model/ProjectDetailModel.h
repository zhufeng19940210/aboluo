//
//  ProjectDetailModel.h
//  aboluo
//
//  Created by zhufeng on 2018/12/13.
//  Copyright © 2018 zhufeng. All rights reserved.
//

#import "BaseModel.h"

@interface ProjectDetailModel : BaseModel
@property (nonatomic,copy)NSString *projectId;
@property (nonatomic,copy)NSString *name;
@property (nonatomic,copy)NSString *img;
@property (nonatomic,copy)NSString *contents;
@property (nonatomic,copy)NSString *cost;
@property (nonatomic,copy)NSString *total;
@property (nonatomic,copy)NSString *address;
@property (nonatomic,copy)NSString *startTime;
@property (nonatomic,copy)NSString *overTime;
@property (nonatomic,copy)NSString *receivederId;
@property (nonatomic,copy)NSString *receivederList;
@property (nonatomic,copy)NSString *checkWay;
@property (nonatomic,copy)NSString *insuranceId;
@property (nonatomic,copy)NSString *companyLevelId;
@property (nonatomic,copy)NSString *productId;
@property (nonatomic,copy)NSString *engineerId;
@property (nonatomic,copy)NSString *contact;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *sender;
@property (nonatomic,copy)NSString *receiveder;
@property (nonatomic,strong)NSString *insurance;
@property (nonatomic,strong)NSString *product;
@property (nonatomic,copy)NSString *engineer;
@property (nonatomic,copy)NSString *company;

/*
"projectId": 13,
"name": "太子殿新增发财项目",
"img": "http://lanpangzi.oss-cn-beijing.aliyuncs.com/data/1544153020176.png?Expires=1860059806&OSSAccessKeyId=LTAIUsQLyTCbTOCx&Signature=775sfe3zHezo%2FKGVK2XmmrQ3nBE%3D",
"contents": "地理位置好",
"cost": 6999,
"total": 300,
"address": "江西省南昌市",
"startTime": "2018-11-02",
"overTime": "2018-11-29",
"createTime": 1543802420000,
"state": 0,
"receivederId": 0,
"senderId": 1,
"receivederList": "1,http://lanpangzi.oss-cn-beijing.aliyuncs.com/data/1544175195202.jpg?Expires=1860059806&OSSAccessKeyId=LTAIUsQLyTCbTOCx&Signature=xbDCEZbQeTVKsp0NBoNTbAYDUCA%3D;12,http://lanpangzi.oss-cn-beijing.aliyuncs.com/data/1544175022852.jpg?Expires=1860059806&OSSAccessKeyId=LTAIUsQLyTCbTOCx&Signature=HGRMOsKLjB4%2B2CwXIm9B8SFlHkI%3D",
"checkWay": 0,
"insuranceId": 1,
"companyLevelId": 2,
"productId": 4,
"engineerId": 0,
"contact": null,
"phone": null,
"sender": null,
"receiveder": null,
"insurance": {
    "id": 1,
    "coverage": 100000,
    "premium": 60
},
"product": {
    "id": 4,
    "name": "水电施工",
    "img": "1544091222750.png",
    "img1": "1544091224843.png",
    "turn": null,
    "parentId": 1,
    "upes": null
},
"engineer": null,
"company": null
 */
@end
