//  AddOrEditAddreddVC.h
//  aboluo
//  Created by zhufeng on 2018/11/19.
//  Copyright © 2018 zhufeng. All rights reserved.

#import "BaseVC.h"
#import "AddressModel.h"
@interface AddOrEditAddreddVC : BaseVC
///isAdd 是否编辑 isEdit
@property (nonatomic,assign)BOOL isAdd;
@property (nonatomic,strong)AddressModel *addressmodel;
@end
