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

@synthesize field,userSession;

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
    SDZUserService *userService = [SDZUserService service];
    SDZYuDingRoomService *service = [SDZYuDingRoomService service];
    userService.logging = YES;
    service.logging = YES;
    [userService createSession:self action:@selector(createSessionHandler:)];
    
    [service findAllCity:self action:@selector(handleFindAllCity:) sessionId:userSession];
    [service findHotelByCity:self action:@selector(findHotelByCityHandler:) sessionId:userSession city:[cityArr objectAtIndex:0]];
   
    [super viewDidLoad];
	// Do any additional setup after loading the view.
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
    userSession = value;
    
	// Do something with the NSString* result
	NSLog(@"createSession returned the Session: %@", userSession);
    
    
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
    cityArr = value;
    NSLog(@"we have %@ city",[NSNumber numberWithInt:cityArr.count]);   
    
    for (SDZYuDingRoomService *city in cityArr) {
        NSLog(@"- %@",city);
    }
    
    
    
}


- (void)findHotelByCityHandler:(id)value
{
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    NSMutableArray *hotelArr = value;
    
    for (SDZYuDingRoomService *hotel in hotelArr) {
        NSLog(@"- %@",hotel);
    }
    
    
    
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
