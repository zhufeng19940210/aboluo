//  ServerBillingHeaderCell.h
//  aboluo
//  Created by zhufeng on 2018/12/4.
//  Copyright © 2018 zhufeng. All rights reserved.
#import <UIKit/UIKit.h>
@protocol ServerBillingHeaderCellDelegate<NSObject>
-(void)pushSelectTimeMethodWithTag:(int)tag;
-(void)calateTotalPrice;
@end
@interface ServerBillingHeaderCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *project_name_tf;
@property (weak, nonatomic) IBOutlet UITextField *statr_time_tf;
@property (weak, nonatomic) IBOutlet UITextField *end_time_tf;
@property (weak, nonatomic) IBOutlet UITextField *cost_price_tf;
@property (weak, nonatomic) IBOutlet UILabel *total_price_lab;
@property (nonatomic,weak)id <ServerBillingHeaderCellDelegate> delegate;
@end
