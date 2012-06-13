//
//  IntroTabViewController.m
//  dingfang
//
//  Created by user on 12-6-8.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IntroTabViewController.h"

@interface IntroTabViewController ()

@end

@implementation IntroTabViewController

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
    UIButton *commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 31)];
    
    [commentBtn setBackgroundImage:[UIImage imageNamed:@"pay1@2x.png"] forState:UIControlStateNormal];
    
    UIBarButtonItem *commentItem = [[UIBarButtonItem alloc] initWithCustomView:commentBtn];
    
    
    
    self.navigationItem.rightBarButtonItem = commentItem;

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
