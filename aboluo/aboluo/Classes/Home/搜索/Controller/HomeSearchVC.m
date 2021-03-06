//  HomeSearchVC.m
//  aboluo
//  Created by zhufeng on 2018/11/15.
//  Copyright © 2018 zhufeng. All rights reserved.
#import "HomeSearchVC.h"
@interface HomeSearchVC ()<UITextFieldDelegate>
@property (nonatomic,strong)UITextField *search_tf;
@property (nonatomic,assign)BOOL isSearch; //是否搜索
@property (nonatomic,strong)NSMutableArray *searchArray;
@end
@implementation HomeSearchVC
-(NSMutableArray *)searchArray
{
    if (!_searchArray) {
        _searchArray = [NSMutableArray array];
    }
    return _searchArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupConfigNavitionBar];
}
-(void)setupConfigNavitionBar
{
    [self setRightButtonText:@"搜索" withColor:[UIColor whiteColor]];
    UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH*0.8, 34)];
    textField.layer.masksToBounds = YES;
    textField.layer.cornerRadius = 16.0f;
    textField.backgroundColor = RGB(240, 240, 240);
    textField.font = [UIFont systemFontOfSize:15]; // 字体颜色
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary]; // 创建属性字典
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:14]; // 设置font
    attrs[NSForegroundColorAttributeName] = RGB(153, 153, 153); // 设置颜色
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:@"搜索您想要" attributes:attrs];
    textField.attributedPlaceholder = attStr;
    textField.textColor = [UIColor blackColor];
    textField.tintColor = RGB(153, 153, 153);
    textField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"search"]];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.rightView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_delete"]];
    textField.rightView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionClear:)];
    [textField.rightView addGestureRecognizer:tap];
    textField.rightViewMode = UITextFieldViewModeAlways;
    textField.rightView.hidden = YES;
    self.navigationItem.titleView = textField;
    textField.delegate = self;
    textField.returnKeyType = UIReturnKeySearch;
    textField.enablesReturnKeyAutomatically = YES; //这里设置为无文字就灰色不可点
    ///成为第一个响应者
    //[textField becomeFirstResponder];
    //监听的一个事件
    [textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    self.search_tf = textField;
    self.navigationItem.titleView = textField;
}
/**
 清除的功能
 @param gesture 清除功能
 */
-(void)actionClear:(UITapGestureRecognizer *)gesture
{
    [self.search_tf resignFirstResponder];
    self.isSearch = NO;
    self.search_tf.rightView.hidden = YES;
    self.search_tf.text = @"";
    [self.searchArray removeAllObjects];
}
/**
 值的变化功能
 @param tf 值变化的功能
 */
#pragma mark - textFieldDidChange
-(void)textFieldDidChange:(UITextField *)textField
{
    if (textField == self.search_tf) {
        if (textField.text.length == 0 ) {
            self.isSearch = NO;
            self.search_tf.rightView.hidden = YES;
            [self.searchArray removeAllObjects];
        }else{
            self.search_tf.rightView.hidden = NO;
        }
    }
}
/**
 点击搜索的功能
 @param button 搜索功能
 */
- (void)onRightBtnAction:(UIButton *)button
{
    [self searchMethod];
}
//搜索的功能
-(void)searchMethod
{
    NSString *searchStr = self.search_tf.text;
    if (searchStr.length == 0 || [searchStr isEqualToString:@""]) {
        [self showHint:@"搜索的内容不能为空" yOffset:-200];
        return;
    }
    //开始去搜索的东西
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
