//
//  DDOrderNavViewController.m
//  dingfang
//
//  Created by user on 12-7-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DDOrderNavViewController.h"
#import "DingDanViewController.h"

@interface DDOrderNavViewController ()

@end

@implementation DDOrderNavViewController

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
    DingDanViewController *ddvc = [[DingDanViewController alloc] init];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:ddvc]; 
    
    [self presentModalViewController:nav animated:YES];
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
