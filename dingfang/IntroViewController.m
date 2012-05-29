//
//  IntroViewController.m
//  dingfang
//
//  Created by user on 12-5-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IntroViewController.h"
#import "introImageViewController.h"

static NSUInteger kNumberOfPages = 3;


@implementation IntroViewController

@synthesize scrollView,imageScrollView, pageControl, viewControllers;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)loadScrollViewWithPage:(int)page {
    if (page < 0) return;
    if (page >= kNumberOfPages) return;
    //此为你定义的视图，随你定义，我只定义了显示图片的试图，在此把你定义的视图放入此类的数组里。	
	introImageViewController *controller = [viewControllers objectAtIndex:page];
	if ((NSNull *)controller == [NSNull null]) {
        controller = [[introImageViewController alloc] initWithPageNumber:page];
        [viewControllers replaceObjectAtIndex:page withObject:controller];
    }
    
    // 把你定义的视图加入scrollview内，scrollview为显示的窗口
    if (nil == controller.view.superview) {
        CGRect frame = imageScrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [imageScrollView addSubview:controller.view];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
	if (pageControlUsed)
	{
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = imageScrollView.frame.size.width;
    int page = floor((imageScrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    pageControl.currentPage = page;
	
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
	
    // A possible optimization would be to unload the views+controllers which are no longer visible
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}


- (IBAction)changePage:(id)sender {
    int page = pageControl.currentPage;
    // load the visible page and the page on either side of it (to avoid flashes when the user starts scrolling)
    [self loadScrollViewWithPage:page - 1];
    [self loadScrollViewWithPage:page];
    [self loadScrollViewWithPage:page + 1];
    // update the scroll view to the appropriate page
    CGRect frame = imageScrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    [imageScrollView scrollRectToVisible:frame animated:YES];
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSMutableArray *controllers = [[NSMutableArray alloc] init];
    for (unsigned i = 0; i < kNumberOfPages; i++) {
        [controllers addObject:[NSNull null]];
    }
    self.viewControllers = controllers;
	
    // a page is the width of the scroll view
    imageScrollView.pagingEnabled = YES;
    imageScrollView.contentSize = CGSizeMake(imageScrollView.frame.size.width * kNumberOfPages, imageScrollView.frame.size.height);
    imageScrollView.showsHorizontalScrollIndicator = NO;
    imageScrollView.showsVerticalScrollIndicator = NO;
    imageScrollView.scrollsToTop = NO;
    imageScrollView.delegate = self;
	
    pageControl.numberOfPages = kNumberOfPages;
    pageControl.currentPage = 0;
    
    // pages are created on demand
    // load the visible page
    // load the page on either side to avoid flashes when the user starts scrolling
    [self loadScrollViewWithPage:0];
    [self loadScrollViewWithPage:1];
    
    UIImageView *navlist = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"detailinfonavbg.png"]];
    navlist.frame = CGRectMake(0, 110, 320, 30);
    UILabel *navLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 115, 80, 20)];
    navLable.text = @"详细信息";
    navLable.backgroundColor = [UIColor clearColor];
    
    [scrollView addSubview:navlist];
    
    [scrollView addSubview:navLable];
    
    [scrollView sendSubviewToBack:imageScrollView];
    [scrollView setContentSize:CGSizeMake(320,1000)];
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
