//
//  introImageViewController.m
//  dingfang
//
//  Created by user on 12-5-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelIntroImageViewController.h"
#import "UIImageView+WebCache.h"


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



- (void)viewDidLoad
{
    [super viewDidLoad];
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
