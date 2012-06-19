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

@synthesize loginBtn,hotelOrderBtn,userBtn;


- (void)passValue:(NSString *)valueOne
{
    userBtn = [[UIBarButtonItem alloc] initWithTitle:valueOne style:UIBarButtonItemStylePlain target:self action:@selector(gotoDingDanView)];
    
    self.navigationItem.rightBarButtonItem = nil;
    [self.navigationItem setRightBarButtonItem:userBtn];
    
    NSLog(@"the get value is %@", userBtn.title);
}

- (void)colseUserBtn
{

    self.navigationItem.rightBarButtonItem = nil;
    [self.navigationItem setRightBarButtonItem:loginBtn];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    

    
    
    loginBtn = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(gotoLoginView)];
    
   [[self navigationItem] setRightBarButtonItem:loginBtn];
    self.navigationItem.title = @"考";
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
