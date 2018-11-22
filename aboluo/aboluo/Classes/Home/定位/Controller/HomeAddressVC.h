//  HomeAddressVC.h
//  aboluo
//  Created by zhufeng on 2018/11/15.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "BaseVC.h"
typedef void(^SelectAddressBlock)(NSString *selectStr);
@interface HomeAddressVC : BaseVC
@property (nonatomic,copy)SelectAddressBlock addreessblock;
@end
