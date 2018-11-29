//  AddressListCell.h
//  aboluo
//  Created by zhufeng on 2018/11/19.
//  Copyright © 2018 zhufeng. All rights reserved.
#import <UIKit/UIKit.h>
#import "AddressModel.h"
@interface AddressListCell : UITableViewCell
+ (instancetype)AddressCellWithTableView:(UITableView *)tableView;
@property (nonatomic,strong)AddressModel *addressmodel;
@end
