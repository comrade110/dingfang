//
//  loginViewController.m
//  dingfang
//
//  Created by user on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "loginViewController.h"

@interface loginViewController ()

@end

@implementation loginViewController

@synthesize userPhoneID, userPW, ruserPhoneID, ruserPWCheck,ruserPW,loginBtn, registerBtn, loginView,registerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    userPhoneID.delegate =self;
//    [userPhoneID becomeFirstResponder];
    [registerView removeFromSuperview];
    
}

// 登录按钮点击后事件
-(IBAction)btnPress:(id)sender
{
    
	if ([userPW.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"密码不能为空" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    NSCharacterSet *disallowedCharacters = [[NSCharacterSet
                                             characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSCharacterSet *disallowedCharacters2 = [[NSCharacterSet
                                              characterSetWithCharactersInString:@"0123456789QWERTYUIOPLKJHGFDSAZXCVBNMqwertyuioplkjhgfdsazxcvbnm"] invertedSet];
    NSRange foundRange = [userPhoneID.text rangeOfCharacterFromSet:disallowedCharacters];
    NSRange foundRange2 = [userPW.text rangeOfCharacterFromSet:disallowedCharacters2];
    if (foundRange.location != NSNotFound || [userPhoneID.text length] != 11) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"手机号应为11位数字" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
        return;
    }
    
    if (foundRange2.location != NSNotFound || ([userPW.text length] > 0 && [userPW.text length] < 5)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"密码应为大于5位数的数字或字母组合" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
        return;
    }    
    
}
// 注册提交按钮点击后事件
-(IBAction)submitBtnPress:(id)sender
{
    
	if ([ruserPW.text length] == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"密码不能为空" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    
    NSCharacterSet *disallowedCharacters = [[NSCharacterSet
                                             characterSetWithCharactersInString:@"0123456789"] invertedSet];
    NSCharacterSet *disallowedCharacters2 = [[NSCharacterSet
                                              characterSetWithCharactersInString:@"0123456789QWERTYUIOPLKJHGFDSAZXCVBNMqwertyuioplkjhgfdsazxcvbnm"] invertedSet];
    NSRange foundRange = [ruserPhoneID.text rangeOfCharacterFromSet:disallowedCharacters];
    NSRange foundRange2 = [ruserPW.text rangeOfCharacterFromSet:disallowedCharacters2];
    if (foundRange.location != NSNotFound || [ruserPhoneID.text length] != 11) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"手机号应为11位数字" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
        return;
    }
    
    if (foundRange2.location != NSNotFound || ([ruserPW.text length] > 0 && [userPW.text length] < 5)) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"密码应为大于5位数的数字或字母组合" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
        return;
    }
    if (ruserPW.text != ruserPWCheck.text) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"" message: @"两次输入的密码不同" 
                                                       delegate: NULL cancelButtonTitle: @"OK" otherButtonTitles: NULL];
        [alert show];
    }
    
}


-(IBAction)regBtnPress:(id)sender
{
    [userPhoneID resignFirstResponder];
    [userPW resignFirstResponder];
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [animation setSubtype:kCATransitionFromRight];
    
    [loginView removeFromSuperview];
    [self.view addSubview:registerView];
    [[self.view layer] addAnimation:animation forKey:@"switch"];
}

-(IBAction)regBackBtnPress:(id)sender
{
    CATransition *animation = [CATransition animation];
    [animation setDuration:0.5];
    [animation setType:kCATransitionPush];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [animation setSubtype:kCATransitionFromLeft];
    
    [registerView removeFromSuperview];
    [self.view addSubview:loginView];
    [[self.view layer] addAnimation:animation forKey:@"switch"];
}
- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
