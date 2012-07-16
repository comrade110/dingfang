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
    
    NSArray *myArr =[[NSArray alloc] init];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    myArr = [userDefaults objectForKey:@"imgArr"];
    
    NSLog(@"---%@---",myArr);
    
	if (__pageControlImageList==nil) {
		__pageControlImageList = [[NSArray alloc] initWithArray:myArr];
	}
    
    NSString *pageListString = [__pageControlImageList objectAtIndex:index %[__pageControlImageList count]];
    NSString *ip = @"http://192.168.3.7:9001";
    NSString *result = [NSString stringWithFormat:@"%@%@",ip,pageListString];
    
	return result;
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
