//
//  IntroViewController.m
//  dingfang
//
//  Created by user on 12-5-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "IntroViewController.h"
#import "introImageViewController.h"
#import "loginViewController.h"
#import "CommentViewController.h"
#import "HotelIntroViewController.h"
#include <CommonCrypto/CommonCryptor.h>

static NSUInteger kNumberOfPages = 3;


@implementation IntroViewController

@synthesize scrollView,imageScrollView, pageControl, viewControllers;
@synthesize tabBar,firstTabBarItem,secondTabBarItem,thirdTabBarItem;

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
    myUserID = [userDefaults objectForKey:@"userID"];
    
    CXMLDocument *document = [[CXMLDocument alloc] initWithXMLString:myHotelArr options:0 error:nil];
    
    [self parseDire:document];
    [self parseDire2:document];
    
    myDesc = [item valueForKey:@"desc"];
    
    myAddress = [item2 valueForKey:@"address"];
    
    myHotelName = [item2 valueForKey:@"name"];
    
    myRoomType = [item valueForKey:@"roomType"];
    
    myFax = [item2 valueForKey:@"fax"];
    
    myPhone = [item2 valueForKey:@"phone"];
    
    myPrice = [item valueForKey:@"price"];
    
    myNum = [item valueForKey:@"num"];
    
    myHotelID = [item2 valueForKey:@"id"];
    
    myRoomID = [item valueForKey:@"id"];
    
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
    
    UILabel *numLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 105, 80, 30)];
    numLabel.text = [NSString stringWithFormat:@"剩余数量：%@间",myNum];
    numLabel.font = [UIFont fontWithName:@"Arial" size:12];
    
    UIButton *orderBtn = [[UIButton alloc] initWithFrame:CGRectMake(235, 105, 70, 30)];
    [orderBtn setTitle:@"立即抢购" forState:UIControlStateNormal];
    orderBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [orderBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [orderBtn setBackgroundImage:[UIImage imageNamed:@"xiadan.png"] forState:UIControlStateNormal];
    [orderBtn addTarget:self action:@selector(orderBtnPress) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
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
    
    
    
    
    [scrollView addSubview:orderBtn];
    [scrollView addSubview:priceLabel];
    [scrollView addSubview:numLabel];
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



// 点击下单按钮

- (void)orderBtnPress
{
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                  bundle:nil];
    loginViewController *loginVC = [sb instantiateViewControllerWithIdentifier:@"loginViewController"];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    int isLogin = [userDefaults integerForKey:@"isLogin"];
    
    if (isLogin == 1) {
        if ([myNum integerValue] > 0) {
            orderView = [[UIView alloc] initWithFrame:CGRectMake(160, 240, 0, 0)];
            
            NSArray *subviews = orderView.subviews;
            
            for (UIView *view in subviews) {
                if ([view isKindOfClass:[UILabel class]]) {
                    UILabel *label = (UILabel*)view;
                    
                    label.font = [UIFont systemFontOfSize:12];
                    
                }
            }
            
            [UIView beginAnimations:@"comeOut" context:nil];
            [UIView setAnimationDuration:0.3];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            orderView.frame = CGRectMake(30, 40, 260, 300);
            orderView.backgroundColor = [UIColor whiteColor];
            [UIView commitAnimations];
            
            
            UILabel *hotelNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 210, 30)];
            hotelNameLabel.text = [NSString stringWithFormat:@"酒店名称：%@",myHotelName];
            
            UILabel *roomTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, hotelNameLabel.frame.origin.y +hotelNameLabel.frame.size.height +10, 210, 30)];
            roomTypeLabel.text = [NSString stringWithFormat:@"酒店房型：%@",myRoomType];
            
            UILabel *payNum = [[UILabel alloc] initWithFrame:CGRectMake(20, roomTypeLabel.frame.origin.y +roomTypeLabel.frame.size.height +20, 50, 30)];
            payNum.text = @"购买数量：";
            
            payNumField = [[UITextField alloc] initWithFrame:CGRectMake(80, roomTypeLabel.frame.origin.y +roomTypeLabel.frame.size.height +20, 60, 30)];
            
            payNumField.placeholder = [NSString stringWithFormat:@"最多购买%@件",myNum];
            
            payNumField.borderStyle = UITextBorderStyleRoundedRect;
            
            payNumField.keyboardType = UIKeyboardTypeNumberPad;
            
            int payCount = 1;
            
//      付款按钮
            
            payNumField.text =[NSString stringWithFormat:@"%d",payCount];
            
            UIButton *payButton = [[UIButton alloc] initWithFrame:CGRectMake(60, payNumField.frame.origin.y +payNumField.frame.size.height +20, 71, 30)];
            
            [payButton setImage:[UIImage imageNamed:@"pay1@2x.png"] forState:UIControlStateNormal];
            [payButton addTarget:self action:@selector(payBtnPress) forControlEvents:UIControlEventTouchUpInside];
            
            
            
                        
            [orderView addSubview:hotelNameLabel];
            [orderView addSubview:roomTypeLabel];
            [orderView addSubview:payNum];
            [orderView addSubview:payNumField];
            [orderView addSubview:payButton];
            [self.view addSubview:orderView];
        }
    }else if(isLogin == 0) {
        
        [self presentModalViewController:loginVC animated:YES];
    }

}


- (void)payBtnPress
{
    if ([payNumField.text intValue] < [myNum intValue]) {
        SDZYuDingRoomService *service = [SDZYuDingRoomService service];
        
        [service bookRoom:self action:@selector(bookRoomHandler:) sessionId:mySession roomId:myRoomID orderNum:payNumField.text];
        
    }
    
    
}

-(void)bookRoomHandler:(id)value
{
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    NSString *result = (NSString*)value;
    NSLog(@"%@",result);

    SDZYuDingRoomService *service = [SDZYuDingRoomService service];
    [service getZhiFuConfig:self action:@selector(getZhiFuConfigHandle:) sessionId:mySession];


}
//  获取支付宝信息

-(void)getZhiFuConfigHandle:(id)value
{
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    NSMutableArray *result = (NSMutableArray*)value;
    
    for (SDZYuDingRoom *items in result) {
        NSLog(@"%@",items);
    }
    
    

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
