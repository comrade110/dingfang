//
//  loginViewController.h
//  dingfang
//
//  Created by user on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SDZUserService.h"
#import "dfLoginBtnDelegate.h"
#import "CHKeychain.h"

@interface loginViewController : UIViewController<UITextFieldDelegate>
{
    NSString *mySession;
    SDZUserService *userService;
    NSObject<dfLoginBtnDelegate> * delegate;
    IBOutlet UIButton *btnRemeberUsernamePassword;
    BOOL rememberUsernamePassword;

}

@property (strong, nonatomic) IBOutlet UITextField *userPhoneID;
@property (strong, nonatomic) IBOutlet UITextField *userPW;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet UIView *registerView;

@property (strong, nonatomic) IBOutlet UITextField *ruserPhoneID;
@property (strong, nonatomic) IBOutlet UITextField *ruserID;
@property (strong, nonatomic) IBOutlet UITextField *ruserPW;
@property (strong, nonatomic) IBOutlet UITextField *ruserPWCheck;
@property (strong, nonatomic) IBOutlet UITextField *mobileVerify;
@property (strong, nonatomic) IBOutlet UIButton *registerBtn;
@property (strong, nonatomic) NSObject<dfLoginBtnDelegate> * delegate;

-(IBAction) remeberUsernamePassword: (id)sender;
-(IBAction) btnPress: (id)sender;
-(IBAction) submitBtnPress: (id)sender;
-(IBAction) regBtnPress: (id)sender;
-(IBAction) regBackBtnPress: (id)sender;
-(IBAction) regValidatekBtnPress: (id)sender;



@end
