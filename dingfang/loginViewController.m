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

@synthesize userPhoneID, userPW,loginBtn,loginView,registerView;

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

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
//
//    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; 
//    
//
//    
//    if (userPhoneID == textField)  
//        
//    { 
//        
//        if ([toBeString length] > 11) { 
//            
//            textField.text = [toBeString substringToIndex:11]; 
//            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"手机号码为11位数字" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil]; 
//            
//            [alert show]; 
//            
//            return NO; 
//            
//        } 
//
//    } 
//
//    return YES;
//}

//-(BOOL) textFieldShouldEndEditing:(UITextField *)textField
//{
//    
//    
//    
//    if (userPhoneID == textField)  
//        
//    { 
//        
//        if ([userPhoneID.text length] != 11) { 
//            
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"手机号格式不正确，请重新输入" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil]; 
//            
//            [alert show];
//            
//            if ([self resignFirstResponder]) {
//                [self becomeFirstResponder];
//            }   
//            return YES; 
//            
//        } 
//        
//    } 
//
//}
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

-(IBAction)regBtnPress:(id)sender
{
    
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
