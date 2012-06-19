//
//  DingDanViewController.m
//  dingfang
//
//  Created by user on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DingDanViewController.h"



@implementation DingDanViewController

@synthesize delegate;

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
    

    [self labelAdd];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)labelAdd
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *nickName = [userDefaults objectForKey:@"nickName"];
    NSInteger grade = [userDefaults integerForKey:@"grade"];
    double score = [userDefaults doubleForKey:@"score"];
    double money = [userDefaults doubleForKey:@"money"];
    NSString *lastLoginTime = [userDefaults objectForKey:@"lastLoginTime"];
    
    UILabel *nickNameL = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 150, 20)];
    UILabel *gradeL = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 150, 20)];
    UILabel *scoreL = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 150, 20)];
    UILabel *moneyL = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 150, 20)];
    UILabel *lastLoginTimeL = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, 280, 20)];
    
    nickNameL.text = nickName;
    nickNameL.textColor = [UIColor orangeColor];
    gradeL.text = [NSString stringWithFormat:@"用户等级：%d",grade];
    scoreL.text = [NSString stringWithFormat:@"积分：%ld",score];
    moneyL.text = [NSString stringWithFormat:@"云和币：%ld",money];
    lastLoginTimeL.text =[NSString stringWithFormat:@"上次登录时间：%@",lastLoginTime]; 
    
    [self.view addSubview:nickNameL];
    [self.view addSubview:gradeL];
    [self.view addSubview:scoreL];
    [self.view addSubview:moneyL];
    [self.view addSubview:lastLoginTimeL];
    

}
- (IBAction)colseView:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];  
}

- (IBAction)logoutAction:(id)sender
{

    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *mySession = [userDefaults objectForKey:@"userSessionKey"];
    
    SDZUserService *userService = [SDZUserService service];
    userService.logging = YES;
    
    [userService logout:self action:nil sessionId:mySession];
    
    int isLogin = 0;
    
    [userDefaults setInteger:isLogin forKey:@"isLogin"];
    
    [delegate colseUserBtn];
    
    

}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
