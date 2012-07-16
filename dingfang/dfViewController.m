//
//  dfViewController.m
//  dingfang
//
//  Created by user on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "dfViewController.h"
#import "loginViewController.h"
#import "DingDanViewController.h"


@implementation dfViewController

@synthesize loginBtn,hotelOrderBtn,userBtn,nav;


- (void)passValue:(NSString *)valueOne
{
    userBtn = [[UIBarButtonItem alloc] initWithTitle:valueOne style:UIBarButtonItemStylePlain target:self action:@selector(gotoDingDanView)];
    
    self.navigationItem.rightBarButtonItem = nil;
    [self.navigationItem setRightBarButtonItem:userBtn];
    
    NSLog(@"the get value is 11-- %@", userBtn.title);
}

- (void)colseUserBtn
{

    self.navigationItem.rightBarButtonItem = nil;
    loginBtn = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(gotoLoginView)];
    [self.navigationItem setRightBarButtonItem:loginBtn];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"nav_bg.png"] forBarMetrics:UIBarMetricsDefault];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    int isLogin = [userDefaults integerForKey:@"isLogin"];
    
    NSLog(@"----%d----",isLogin);
    
    if (isLogin == 1) {
        
        NSString *nickName = [userDefaults objectForKey:@"nickName"];
        NSLog(@"cena!!!!!!");
        self.navigationItem.rightBarButtonItem = nil;
        userBtn = [[UIBarButtonItem alloc] initWithTitle:nickName style:UIBarButtonItemStylePlain target:self action:@selector(gotoDingDanView)];
        
        [self.navigationItem setRightBarButtonItem:userBtn];
    }
    else{loginBtn = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(gotoLoginView)];
        
        [[self navigationItem] setRightBarButtonItem:loginBtn];
    }
    self.navigationItem.title = @"云和订酒店";
}



-(void)gotoLoginView
{
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                  bundle:nil];
    loginViewController *loginVC = [sb instantiateViewControllerWithIdentifier:@"loginViewController"];
    
    loginVC.delegate = self;
    
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:loginVC animated:NO];
    NSLog(@"111 the get value is %@", loginBtn.title);
    
    
}

-(void)gotoDingDanView
{
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                  bundle:nil];
    DingDanViewController *dingDanVC = [sb instantiateViewControllerWithIdentifier:@"DingDanView"];
    
    dingDanVC.delegate = self;
    
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:dingDanVC animated:YES];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
