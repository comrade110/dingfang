//
//  introImageViewController.m
//  dingfang
//
//  Created by user on 12-5-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "introImageViewController.h"


static NSArray *__pageControlImageList = nil;
@implementation introImageViewController

@synthesize imageView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

+(UIImage *)pageControlImageWithIndex:(NSUInteger)index
{
	UIImage *image1 =[UIImage imageNamed:@"01.png"];
	UIImage *image2 =[UIImage imageNamed:@"02.png"];
	UIImage *image3 =[UIImage imageNamed:@"03.png"];
	if (__pageControlImageList==nil) {
		__pageControlImageList = [[NSArray alloc] initWithObjects:image1,image2,image3,nil];
	}
	return [__pageControlImageList objectAtIndex:index %[__pageControlImageList count]];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [imageView setImage:[introImageViewController pageControlImageWithIndex:pageNumber]];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (id)initWithPageNumber:(int)page {
    UIStoryboard *board=[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    
    
    if ((self =[board instantiateViewControllerWithIdentifier:@"introImageViewController"])) {
        pageNumber = page;
    }
    return self;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
