//
//  dfViewController.m
//  dingfang
//
//  Created by user on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "dfViewController.h"

@interface dfViewController ()

@end

@implementation dfViewController

@synthesize loginBtn,hotelOrderBtn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    SDZUserService *userService = [SDZUserService service];
    userService.logging = YES;
    [userService createSession:self action:@selector(createSessionHandler:)];
}

- (void) createSessionHandler:(id)value {
    
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"error:%@", value);
		return;
	}
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"fault:%@", value);
		return;
	}
    NSString *userSession = (NSString *)value;
    
    NSLog(@"%@",userSession);
    
    NSUserDefaults *SaveDefaults = [NSUserDefaults standardUserDefaults];
    [SaveDefaults setObject:userSession forKey:@"userSessionKey"];
    
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
