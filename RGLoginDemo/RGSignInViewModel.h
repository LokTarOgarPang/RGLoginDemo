//
//  RGSignInViewModel.h
//  RGLoginDemo
//
//  Created by 泥红 on 2017/2/19.
//  Copyright © 2017年 RoyGao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface RGSignInViewModel : NSObject

///-----------
/// judge 判断是否符合正则规则
///-----------


/**
 检测输入的text是否符合正则表达式

 @param text 输入的文本
 @param rule 正则表达式
 @return yes：符合正则表达式；no：不符合
 */
-(BOOL)isValidateText:(NSString *)text withRule:(NSString *)rule;


/**
 根据输入的email判断是否符合邮箱格式。后两个方法类似
 */
-(BOOL)isValidateEmail:(NSString *)email;
-(BOOL)isValidatePassword:(NSString *)password;
-(BOOL)isValidateUsername:(NSString *)username;


///-----------
///  tip的信息，正常则返回nil
///-----------


/**
 根据输入的username与相应的正则表达式相比较。如果错误，返回错误提示；如若符合，返回nil。后两个方法类似
 
 @param username 用户输入的username
 @return 错误提示
 */
-(NSString *)tipOfTestUsername:(NSString *)username;
-(NSString *)tipOfTestEmail:(NSString *)email;
-(NSString *)tipOfTestPassword:(NSString *)password;


/**
 弹出标题为title 内容为text的提示框

 @param title 标题
 @param text 内容
 @return 系统自带居中提示框
 */
-(UIAlertController *)tipWithTitle:(NSString *)title text:(NSString *)text;

@end
