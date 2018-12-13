//  ServerBillingOrderTypeCell.h
//  aboluo
//  Created by zhufeng on 2018/12/4.
//  Copyright © 2018 zhufeng. All rights reserved.
#import <UIKit/UIKit.h>
@protocol ServerBillingOrderTypeCellDelegate<NSObject>
-(void)pushSelectTypeWithTag:(int)tag;
@end
typedef void (^SelectTypeBlock)(int tag);
@interface ServerBillingOrderTypeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *master_tf;
@property (weak, nonatomic) IBOutlet UITextField *company_tf;
@property (weak, nonatomic) IBOutlet UIButton *person_btn;
@property (weak, nonatomic) IBOutlet UIButton *company_btn;
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (nonatomic,weak)id <ServerBillingOrderTypeCellDelegate> delegate;
@property (nonatomic,copy)SelectTypeBlock selecttypeblock;
@end
