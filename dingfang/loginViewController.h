//
//  loginViewController.h
//  dingfang
//
//  Created by user on 12-5-24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface loginViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *userPhoneID;
@property (strong, nonatomic) IBOutlet UITextField *userPW;
@property (strong, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UIView *loginView;
@property (strong, nonatomic) IBOutlet UIView *registerView;

-(IBAction)btnPress:(id)sender;
-(IBAction)regBtnPress:(id)sender;
-(IBAction)regBackBtnPress:(id)sender;

@end
