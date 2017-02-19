//
//  RGSignInView.m
//  RGLoginDemo
//
//  Created by 泥红 on 2017/2/19.
//  Copyright © 2017年 RoyGao. All rights reserved.
//

#import "RGSignInView.h"
#import "Configuration.h"



@interface RGSignInView()<UITextFieldDelegate>{
    UIVisualEffectView *blurview;
}

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImageView;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;
@property (weak, nonatomic) IBOutlet UIButton *findPasswordBtn;
@property (weak, nonatomic) IBOutlet UIButton *signUpBtn;
@property (weak, nonatomic) IBOutlet UILabel *tipOneLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipTwoLabel;

@end

@implementation RGSignInView



-(instancetype)init
{
    RGSignInView *signInView = [[NSBundle mainBundle]loadNibNamed:@"RGSignInView" owner:self options:nil].firstObject;
    if  (!signInView) return nil;

    return signInView;
}


- (void)drawRect:(CGRect)rect {
    
    _emailTextField.delegate = self;
    _passwordTextField.delegate = self;
    
    [self configBackground];
    [self configView];
    [self congifAction];
}



-(void)configBackground
{
     UIImage *launchImage = [UIImage imageNamed:@"DisplayImage"];
    _backgroundImageView.image = launchImage;
    _backgroundImageView.clipsToBounds = YES;
    
    UIBlurEffect *beffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    blurview = [[UIVisualEffectView alloc]initWithEffect:beffect];
    blurview.alpha = kBlurViewAlpha;
    blurview.frame = [UIScreen mainScreen].bounds;
    
    [_backgroundImageView addSubview:blurview];

}

-(void)configView
{
    

    
    _emailTextField.placeholder = NSLocalizedString(@"email", nil);


    _passwordTextField.placeholder = NSLocalizedString(@"password", nil);

    
    
    
    
    [_signInBtn setTitle:NSLocalizedString(@"sign_in", nil) forState:UIControlStateNormal];
    [_signUpBtn setTitle:NSLocalizedString(@"sign_up", nil) forState:UIControlStateNormal];
    
    _tipOneLabel.text = NSLocalizedString(@"or", nil);
    _tipTwoLabel.text = NSLocalizedString(@"if_you_do_not_have_an_acount_yet", nil);

}

-(void)congifAction
{
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(letKeyboardDisapper)];
    gesture.numberOfTapsRequired = 1;
    gesture.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:gesture];
    
    [_backBtn addTarget:self action:@selector(backToMainViewControllerClicked) forControlEvents:UIControlEventTouchDown];
    
    
    
    [_findPasswordBtn addTarget:self
                         action:@selector(findPasswordButtonAction)
               forControlEvents:UIControlEventTouchUpInside];

    [_signInBtn addTarget:self action:@selector(signInClick) forControlEvents:UIControlEventTouchDown];
    
    [_signUpBtn addTarget:self action:@selector(signUpClick) forControlEvents:UIControlEventTouchDown];
}


#pragma mark --Method
//手势－点击
-(void)letKeyboardDisapper
{
    [_emailTextField resignFirstResponder];
    [_passwordTextField resignFirstResponder];
}

-(void)backToMainViewControllerClicked
{
    if ([self.signInDelegate respondsToSelector:@selector(signInViewTurnBackBtnClicked:)]) {
        [self.signInDelegate signInViewTurnBackBtnClicked:self];
    }
}

-(void)findPasswordButtonAction
{
    if ([self.signInDelegate respondsToSelector:@selector(signInViewFindPasswordBtnClicked:)]) {
        [self.signInDelegate signInViewFindPasswordBtnClicked:self];
    }
}

-(void)signInClick
{
    if ([self.signInDelegate respondsToSelector:@selector(signInViewSignInBtnClicked:)]) {
        [self.signInDelegate signInViewSignInBtnClicked:self];
    }
}

-(void)signUpClick
{
    if ([self.signInDelegate respondsToSelector:@selector(signInViewSignUpBtnClicked:)]) {
        [self.signInDelegate signInViewSignUpBtnClicked:self];
    }
}


- (IBAction)facebookLoginBtnClicked:(id)sender
{
    if ([self.signInDelegate respondsToSelector:@selector(signInViewFacebookBtnClicked:)]) {
        [self.signInDelegate signInViewFacebookBtnClicked:self];
    }
}
- (IBAction)wechatLoginBtnClicked:(id)sender
{
    if ([self.signInDelegate respondsToSelector:@selector(signInViewWeChatBtnClicked:)]) {
        [self.signInDelegate signInViewWeChatBtnClicked:self];
    }
}

#pragma mark  textFieldDelegate

/**
 *  点击return键盘：next－Done－直接sign in
 *
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == _emailTextField) {
        [_passwordTextField becomeFirstResponder];
    }
    if (textField == _passwordTextField) {
        [_passwordTextField resignFirstResponder];
        [self signInClick];
    }
    
    return YES;
}



- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if (!textField.window.isKeyWindow) {
        [textField.window makeKeyAndVisible];
    }
}


@end
