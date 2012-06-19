//
//  DingDanNaviController.m
//  dingfang
//
//  Created by user on 12-6-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DingDanNaviController.h"
#import "loginViewController.h"
#import "DingDanViewController.h"

@implementation DingDanNaviController

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
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                  bundle:nil];
    loginViewController *loginVC = [sb instantiateViewControllerWithIdentifier:@"loginViewController"];
    DingDanViewController *dingDanVC = [sb instantiateViewControllerWithIdentifier:@"DingDanView"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    int isLogin = [userDefaults integerForKey:@"isLogin"];
    
    if (isLogin == 1) {
         [self pushViewController:dingDanVC animated:YES];
    }else if(isLogin == 0) {
    
         [self pushViewController:loginVC animated:YES];
    }
    
    
	// Do any additional setup after loading the view.
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
