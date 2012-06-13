//
//  introImageViewController.m
//  dingfang
//
//  Created by user on 12-5-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelIntroImageViewController.h"
#import "UIImageView+WebCache.h"
#import "SDZYuDingRoomService.h"


static NSArray *__pageControlImageList = nil;
@implementation HotelIntroImageViewController

@synthesize imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

+(NSString *)pageControlImageWithIndex:(NSUInteger)index
{   

	if (__pageControlImageList==nil) {
		__pageControlImageList = [[NSArray alloc] initWithObjects:
        @"http://192.168.3.2:9001/idc/additional/getSmallImage.action?imageRef=2&amp;width=200&amp;height=100%22",
        @"http://192.168.3.2:9001/idc/additional/getSmallImage.action?imageRef=3&amp;width=200&amp;height=100%22",
        @"http://192.168.3.2:9001/idc/additional/getSmallImage.action?imageRef=4&amp;width=200&amp;height=100%22",nil];
	}
	return [__pageControlImageList objectAtIndex:index %[__pageControlImageList count]];
}

- (void)findHotelInfoHandle:(id)value
{
    
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
    
    NSString *hotelInfo = (NSString*)value;
    
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *mySession = [userDefaults objectForKey:@"userSessionKey"];
    
    NSString *myHotelIDString = [userDefaults objectForKey:@"hotelID"];
    
    SDZYuDingRoomService *service = [SDZYuDingRoomService service];
    service.logging = YES; 
    
    long myHotelID = [myHotelIDString longLongValue];
    
    [service findHotelInfo:self action:@selector(findHotelInfoHandle:) sessionId:mySession hotelId:myHotelID];
    
    
    [imageView setImageWithURL:[NSURL URLWithString:[HotelIntroImageViewController pageControlImageWithIndex:pageNumber]]];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (id)initWithPageNumber:(int)page {
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    
    if ((self =[board instantiateViewControllerWithIdentifier:@"HotelIntroImageViewController"])) {
        pageNumber = page;
    }
    return self;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
