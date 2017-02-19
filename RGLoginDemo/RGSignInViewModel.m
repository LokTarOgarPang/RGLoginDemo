//
//  RGSignInViewModel.m
//  RGLoginDemo
//
//  Created by 泥红 on 2017/2/19.
//  Copyright © 2017年 RoyGao. All rights reserved.
//

#import "RGSignInViewModel.h"
#import "Configuration.h"


@implementation RGSignInViewModel

/**
 *  判断输入的内容是否与正则表达式相符
 *
 */

-(BOOL)isValidateText:(NSString *)text withRule:(NSString *)rule {
    NSString *emailRegex = rule;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:text];
}

-(BOOL)isValidateUsername:(NSString *)username {
    NSPredicate *usernameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", UsernameRegex];
    return [usernameTest evaluateWithObject:username];
}

-(BOOL)isValidateEmail:(NSString *)email {
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", EmailRegex];
    return [emailTest evaluateWithObject:email];
}

-(BOOL)isValidatePassword:(NSString *)password
{
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PasswordRegex];
    return [passwordTest evaluateWithObject:password];
}


/*
 *  提示信息，正常则返回nil
 */
-(NSString *)tipOfTestUsername:(NSString *)username
{
    
    if ([username isEqualToString:@""] || [username isEqual:nil]) {
        return NSLocalizedString(@"username_empty", nil);
        
    }else if (username.length < 5){
        return NSLocalizedString(@"username_length_can_not_less_than_five", nil);
        
    }else if (![self isValidateText:username withRule:UsernameRegex]){
        return NSLocalizedString(@"username_only_can_be_letter_number_and_", nil);
    }else{
        return nil;
    }
}
-(NSString *)tipOfTestEmail:(NSString *)email
{
    if ([email isEqualToString:@""] || [email isEqual:nil]) {
        return NSLocalizedString(@"email_address_empty", nil);
    }else if (![self isValidateText:email withRule:EmailRegex]){
        return NSLocalizedString(@"email_address_invalid", nil);
    }else{
        return nil;
    }
    
}

-(NSString *)tipOfTestPassword:(NSString *)password
{
    if ([password isEqualToString:@""] || [password isEqual:nil]) {
        return NSLocalizedString(@"password_empty", nil);
    }else if (password.length < 8){
        return NSLocalizedString(@"password_length_can_not_less_than_eight", nil);
    }else if (![self isValidateText:password withRule:PasswordRegex]){
        return NSLocalizedString(@"password_only_consist_of_letter_number_and_", nil);
    }else{
        return nil;
    }
}




-(UIAlertController *)tipWithTitle:(NSString *)title text:(NSString *)text {
    
    UIAlertController *alterController = [UIAlertController alertControllerWithTitle:title message:text preferredStyle:UIAlertControllerStyleAlert];
    [alterController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"ok", nil) style:UIAlertActionStyleCancel handler:nil]];
    return alterController;
}

@end
