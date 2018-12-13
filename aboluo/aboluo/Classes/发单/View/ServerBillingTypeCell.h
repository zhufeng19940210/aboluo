//  ServerBillingTypeCell.h
//  aboluo
//  Created by zhufeng on 2018/12/4.
//  Copyright © 2018 zhufeng. All rights reserved
#import <UIKit/UIKit.h>
@protocol ServerBillingTypeCellDelegate<NSObject>
-(void)pushSelectTypeMethod;
@end
@interface ServerBillingTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *gongzhong_lab;
@property (nonatomic,weak)id <ServerBillingTypeCellDelegate> deelgate;
@end
