//
//  HotelIntroViewController.m
//  dingfang
//
//  Created by user on 12-6-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "HotelIntroViewController.h"
#import "HotelIntroImageViewController.h"

static NSUInteger kNumberOfPages = 3;

@implementation HotelIntroViewController

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
	HotelIntroImageViewController *controller = [viewControllers objectAtIndex:page];
	if ((NSNull *)controller == [NSNull null]) {
        controller = [[HotelIntroImageViewController alloc] initWithPageNumber:page];
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

//    webservice 取数据    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    mySession = [userDefaults objectForKey:@"userSessionKey"];

    NSString *myHotelIDString = [userDefaults objectForKey:@"hotelID"];
    
    SDZYuDingRoomService *service = [SDZYuDingRoomService service];
    service.logging = YES; 
    
    long myHotelID = [myHotelIDString longLongValue];
    
    [service findHotelInfo:self action:@selector(findHotelInfoHandle:) sessionId:mySession hotelId:myHotelID];
    
    
    
    
//       显示图片    

    
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
    
    [scrollView setContentSize:CGSizeMake(320,1000)];
    
    
    
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
    
    CXMLDocument *document = [[CXMLDocument alloc] initWithXMLString:hotelInfo options:0 error:nil];
    
    [self parseDire:document];
//    NSLog(@"%@",hotelInfo);
    
    
    
}



- (void) parseDire:(CXMLDocument *) document
{
    NSMutableArray *ar=[[NSMutableArray alloc] init];
    
    NSArray *nodes=nil;
    nodes=[document nodesForXPath:@"//intro" error:nil];
    
    NSString *strValue;
    NSString *strName;
    
    for (CXMLElement *node in nodes) {
        NSMutableDictionary *object=[[NSMutableDictionary alloc] init];
        
        // process to set attributes of object ----------------------------------------
        NSMutableDictionary *objectAttributes=[[NSMutableDictionary alloc] init];
        NSArray *arAttr=[node attributes];
        NSUInteger i, countAttr = [arAttr count];
        for (i = 0; i < countAttr; i++) {
            strValue=[[arAttr objectAtIndex:i] stringValue];
            strName=[[arAttr objectAtIndex:i] name];
            if(strValue && strName){
                [objectAttributes setValue:strValue forKey:strName];
            }
        }
        [object setValue:objectAttributes forKey:[node name]];
        // --------------------------------------------------------------------------------
        
        // process to read elements of object ----------------------------------------
        NSUInteger j, countElements = [node childCount];
        CXMLNode *element;
        NSMutableDictionary *elementDictionary=nil;
        for (j=0; j<countElements; j++) {
            element=[node childAtIndex:j];
            elementDictionary=[[NSMutableDictionary alloc] init];
            
            // process to read element attributes ----------------------------------
            if([element isMemberOfClass:[CXMLElement class]]){
                CXMLElement *element2=(CXMLElement*)element;
                arAttr=[element2 attributes];
                countAttr=[arAttr count];
                for (i=0; i<countAttr; i++) {
                    strName=[[arAttr objectAtIndex:i] name];
                    strValue=[[arAttr objectAtIndex:i] stringValue];
                    if(strName && strValue){
                        [elementDictionary setValue:strValue forKey:strName];
                    }
                }
            }
            // --------------------------------------------------------------------
            
            NSLog(@"%@",[elementDictionary valueForKey:@"img"]);
            
            imgArr = [NSMutableArray array];
            
            [imgArr addObject:[elementDictionary valueForKey:@"img"]];
            
            // element value if available
            strValue=[element stringValue];
            if(strValue){
                [elementDictionary setValue:strValue forKey:@"value"];
            }
            // ---------------------------------------------------------------------
            
            // check if object/dictionary exists for this key "name"
            strName=[element name];
            if([object valueForKey:strName]){
                if([[object valueForKey:strName] isKindOfClass:[NSMutableDictionary class]]){
                    NSMutableDictionary *d=[[NSMutableDictionary alloc] initWithDictionary:[object valueForKey:strName]];
                    NSMutableArray *arOFSameElementName=[[NSMutableArray alloc] initWithObjects:d,elementDictionary,nil];
                    [object setValue:arOFSameElementName forKey:strName];
                } else {
                    NSMutableArray *arOFSameElementName=[object valueForKey:strName];
                    [arOFSameElementName addObject:elementDictionary];
                }
            } else {
                [object setValue:elementDictionary forKey:strName];
            }
            // ---------------------------------------------------------------------
        }
        [ar addObject:object];
        
        // --------------------------------------------------------------------------------
    }
    
      NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    [userDefaults setObject:imgArr forKey:@"imgArr"];
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
