//
//  RGSignInView.h
//  RGLoginDemo
//
//  Created by 泥红 on 2017/2/19.
//  Copyright © 2017年 RoyGao. All rights reserved.
//
#import <UIKit/UIKit.h>
@class RGSignInView;
@protocol RGSignInViewDelegate <NSObject>

-(void)signInViewTurnBackBtnClicked:(RGSignInView *)signIn;
-(void)signInViewFindPasswordBtnClicked:(RGSignInView *)signIn;
-(void)signInViewSignInBtnClicked:(RGSignInView *)signIn;
-(void)signInViewSignUpBtnClicked:(RGSignInView *)signIn;
-(void)signInViewFacebookBtnClicked:(RGSignInView *)signIn;
-(void)signInViewWeChatBtnClicked:(RGSignInView *)signIn;

@end

@interface RGSignInView : UIView

@property (nonatomic,weak) id<RGSignInViewDelegate> signInDelegate;

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInBtn;
@end
