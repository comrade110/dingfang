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

@synthesize field,userSession,cityArr;

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
    SDZUserService *userService = [SDZUserService service];
    SDZYuDingRoomService *service = [SDZYuDingRoomService service];
    userService.logging = YES;
    service.logging = YES;
    
    [service findAllCity:self action:@selector(findAllCityHandle:) sessionId:userSession];
//    [service findHotelByCity:self action:@selector(findHotelByCityHandler:) sessionId:userSession city:[cityArr objectAtIndex:0]];
    [self performSelector:@selector(showAciotn) withObject:nil afterDelay:1.0];
    
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


- (void)findAllCityHandle:(id)value
{
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    
    self.cityArr = (NSMutableArray*)value;
    NSLog(@"we have %@ city",[NSNumber numberWithInt:cityArr.count]); 
    for (int i = 0; i < [cityArr count]; i++) {
        NSLog(@"----%@------",[cityArr objectAtIndex:i]);
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
    hotelInfoArr = value;
    
    for (SDZYuDingRoomService *hotel in hotelInfoArr) {
//        NSLog(@"- %@",hotel);
//        CXMLDocument *doc = [[CXMLDocument alloc] initWithXMLString:(NSString *)hotel options:0 error:nil];        
//        NSArray *hotels = NULL;
//        hotels = [doc nodesForXPath:@"//Hotel" error:nil];
//        for(CXMLElement *element in hotels){
//            if ([element isKindOfClass:[CXMLElement class]]){
//                NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
//                for (int i = 0; i < [element childCount]; i++)
//                {
//                    if ([[[element children] objectAtIndex:i] isKindOfClass:[CXMLElement class]])
//                    {
//                        [item setObject:[[element childAtIndex:i] stringValue]
//                                 forKey:[[element childAtIndex:i] name]
//                         ];
//                        NSLog(@"%@", [[element childAtIndex:i] stringValue]);
//                    }
//                }
//            }
//        }

    }
}

-(void)showAciotn
{
    
    for (int i= 0; i<3; i++) {
        UILabel *la= [[UILabel alloc] initWithFrame:CGRectMake(10, 100*i+20, 100, 70)];
        la.text = [cityArr objectAtIndex:i];
        la.backgroundColor = [UIColor grayColor];
        [self.view addSubview:la];
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
