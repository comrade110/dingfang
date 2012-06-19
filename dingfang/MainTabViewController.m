//
//  MainTabViewController.m
//  dingfang
//
//  Created by user on 12-6-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MainTabViewController.h"
#import "loginViewController.h"
#import "BIDTaskListController.h"
#import "DingDanViewController.h"

@interface MainTabViewController ()

@end

@implementation MainTabViewController

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
//    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard"
//                                                  bundle:nil];
//    loginViewController *loginVC = [sb instantiateViewControllerWithIdentifier:@"loginViewController"];
//    BIDTaskListController *bidTaskList =[sb instantiateViewControllerWithIdentifier:@"BIDTaskList"];
//    DingDanViewController *dingDanVC = [sb instantiateViewControllerWithIdentifier:@"DingDanView"];
//    
//    self.tabBarController.viewControllers = [NSArray arrayWithObjects:bidTaskList,loginVC,dingDanVC, nil];
//    
    
    
    
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
