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
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    mySession = [userDefaults objectForKey:@"userSessionKey"];
    NSString *myHotelArr = [userDefaults objectForKey:@"descKey"];
    
    CXMLDocument *document = [[CXMLDocument alloc] initWithXMLString:myHotelArr options:0 error:nil];
    
    [self parseDire:document];
    [self parseDire2:document];
    
    NSString *myDesc = [item valueForKey:@"desc"];
    
    NSString *myAddress = [item2 valueForKey:@"address"];
    
    NSString *myFax = [item2 valueForKey:@"fax"];
    
    NSString *myPhone = [item2 valueForKey:@"phone"];
    
    NSString *myPrice = [item valueForKey:@"price"];
    
    NSString *myHotelID = [item2 valueForKey:@"id"];
    
    [userDefaults setObject:myHotelID forKey:@"hotelID"];
    
    NSString *myContact = [NSString stringWithFormat:@"酒店地址：%@\n传真：%@\n电话：%@",myAddress,myFax,myPhone];
    
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
    
    UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 105, 120, 30)]; 
    priceLabel.text = myPrice;
    priceLabel.font = [UIFont fontWithName:@"Arial" size:16];
    priceLabel.textColor = [UIColor orangeColor];
    
    
    
    UITextField *nav = [[UITextField alloc] initWithFrame:CGRectMake(0, 145, 320, 30)];
        nav.background = [UIImage imageNamed:@"detailinfonavbg.png"];
    
    
    //       商家描述
    
    nav.text = @"    商家描述";
    nav.font = [UIFont systemFontOfSize:12];
    nav.contentVerticalAlignment = 0;
    nav.userInteractionEnabled = NO;
    UILabel *descLable = [[UILabel alloc] init];
    [descLable setNumberOfLines:0];
    
    descLable.font =[UIFont systemFontOfSize:12];
    
    UIFont *font = [UIFont fontWithName:@"Helvetica" size:12];
    CGSize size = CGSizeMake(295,2000);
    
    
    CGSize descLablesize = [myDesc sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    [descLable setFrame:CGRectMake(14, nav.frame.origin.y + nav.frame.size.height + 10, descLablesize.width, descLablesize.height)];
    descLable.text =myDesc;
    

    //    联系方式    
    
    UITextField *contact = [[UITextField alloc] initWithFrame:CGRectMake(0, descLable.frame.origin.y + descLablesize.height +10, 320, 30)];
    
    contact.background = [UIImage imageNamed:@"detailinfonavbg.png"];
    
    
    contact.text = @"    联系方式";
    contact.font = [UIFont systemFontOfSize:12];
    contact.contentVerticalAlignment = 0;
    contact.userInteractionEnabled = NO;
    
    
    UILabel *contactLable = [[UILabel alloc] init];
    [contactLable setNumberOfLines:0];
    contactLable.font =[UIFont systemFontOfSize:12];
    
    CGSize contactLableSize = [myContact sizeWithFont:font constrainedToSize:size lineBreakMode:UILineBreakModeWordWrap];
    [contactLable setFrame:CGRectMake(14, contact.frame.origin.y + contact.frame.size.height + 10, contactLableSize.width, contactLableSize.height)];
    contactLable.text = myContact;
    
    
    
    
    
    [scrollView addSubview:priceLabel];
    [scrollView addSubview:nav];    
    [scrollView addSubview:descLable];
    [scrollView addSubview:contact];
    [scrollView addSubview:contactLable];
    
    
    [scrollView sendSubviewToBack:imageScrollView];
    [scrollView setContentSize:CGSizeMake(320,1000)];
    

    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}




//方式二:按节点查找
- (void) parseDire:(CXMLDocument *) document
{
    NSArray *YuDingRoom = NULL;
    YuDingRoom = [document nodesForXPath:@"//YuDingRoom" error:nil];
    for (CXMLElement *element in YuDingRoom)
    {
        if ([element isKindOfClass:[CXMLElement class]])
        {
            item = [[NSMutableDictionary alloc] init];
            for (int i = 0; i < [element childCount]; i++)
            {
                if ([[[element children] objectAtIndex:i] isKindOfClass:[CXMLElement class]])
                {
                    [item setObject:[[element childAtIndex:i] stringValue]
                             forKey:[[element childAtIndex:i] name]
                     ];
                    //                    NSLog(@"%@", [[element childAtIndex:i] stringValue]);
                }
            }
            //NSLog(@"%@", item);
        }
    }
}


- (void) parseDire2:(CXMLDocument *) document
{
    NSArray *YuDingRoom = NULL;
    YuDingRoom = [document nodesForXPath:@"//hotel" error:nil];
    for (CXMLElement *element in YuDingRoom)
    {
        if ([element isKindOfClass:[CXMLElement class]])
        {
            item2 = [[NSMutableDictionary alloc] init];
            for (int i = 0; i < [element childCount]; i++)
            {
                if ([[[element children] objectAtIndex:i] isKindOfClass:[CXMLElement class]])
                {
                    [item2 setObject:[[element childAtIndex:i] stringValue]
                              forKey:[[element childAtIndex:i] name]
                     ];
                    //                    NSLog(@"%@", [[element childAtIndex:i] stringValue]);
                }
            }
            //NSLog(@"%@", item);
        }
    }
}













- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
