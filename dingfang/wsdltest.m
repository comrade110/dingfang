//
//  wsdltest.m
//  dingfang
//
//  Created by user on 12-5-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "wsdltest.h"

@interface wsdltest ()

@end

@implementation wsdltest

@synthesize field,userID;

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
    SDZUserService *userSession = [SDZUserService service];
    SDZYuDingRoomService *service = [SDZYuDingRoomService service];
    userSession.logging = YES;
    service.logging = YES;
     userID =(NSString *)[userSession createSession:self action:@selector(createSessionHandler:)];
    
    [service findAllCity:self action:@selector(handleFindAllCity:) sessionId:userID];
    
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void) createSessionHandler: (id) value {
    
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
    
    
	// Do something with the NSString* result
    NSString* result = (NSString*)value;
	NSLog(@"createSession returned the value: %@", result);
    
    
}

- (void)handleFindAllCity:(id)value
{
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    NSMutableArray *cityArr = value;
    NSLog(@"we have %@ city",[NSNumber numberWithInt:cityArr.count]);     
    
         

}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (IBAction)buttonPressed:(id)sender
{
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
