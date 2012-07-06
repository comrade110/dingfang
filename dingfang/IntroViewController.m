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
#import "AlixPayOrder.h"
#import "AlixPayResult.h"
#import "AlixPay.h"
#import "DataSigner.h"
#import "NSDataEx.h"

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
    
    [orderView removeFromSuperview];
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
            orderView = [[UIView alloc] initWithFrame:CGRectMake(260, 80, 0, 0)];
            
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
            orderView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
            [UIView commitAnimations];
            
            
            UILabel *hotelNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 30, 210, 30)];
            hotelNameLabel.text = [NSString stringWithFormat:@"酒店名称：%@",myHotelName];
            hotelNameLabel.backgroundColor = [UIColor clearColor];
            hotelNameLabel.textColor =[UIColor whiteColor];
            
            UILabel *roomTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, hotelNameLabel.frame.origin.y +hotelNameLabel.frame.size.height +10, 210, 30)];
            roomTypeLabel.text = [NSString stringWithFormat:@"酒店房型：%@",myRoomType];
            roomTypeLabel.backgroundColor = [UIColor clearColor];
            roomTypeLabel.textColor =[UIColor whiteColor];
            
            UILabel *payNum = [[UILabel alloc] initWithFrame:CGRectMake(20, roomTypeLabel.frame.origin.y +roomTypeLabel.frame.size.height +20, 100, 30)];
            payNum.text = @"购买数量：";
            payNum.backgroundColor = [UIColor clearColor];
            payNum.textColor =[UIColor whiteColor];
            
            payNumField = [[UITextField alloc] initWithFrame:CGRectMake(110, roomTypeLabel.frame.origin.y +roomTypeLabel.frame.size.height +20, 80, 30)];
            
            payNumField.placeholder = [NSString stringWithFormat:@"最多购买%@件",myNum];
            
            payNumField.borderStyle = UITextBorderStyleRoundedRect;
            
            payNumField.keyboardType = UIKeyboardTypeNumberPad;
            
            int payCount = 1;

//      关闭按钮
            UIButton *closeViewButton = [[UIButton alloc] initWithFrame:CGRectMake(225, 3, 32, 32)];
            
            [closeViewButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
            
            [closeViewButton addTarget:self action:@selector(closeOrderView) forControlEvents:UIControlEventTouchUpInside];
            
//      付款按钮
            
            payNumField.text =[NSString stringWithFormat:@"%d",payCount];
            
            UIButton *payButton = [[UIButton alloc] initWithFrame:CGRectMake(60, payNumField.frame.origin.y +payNumField.frame.size.height +20, 71, 30)];
            
            [payButton setImage:[UIImage imageNamed:@"pay1@2x.png"] forState:UIControlStateNormal];
            [payButton addTarget:self action:@selector(payBtnPress) forControlEvents:UIControlEventTouchUpInside];
            
            
            
                        
            [orderView addSubview:hotelNameLabel];
            [orderView addSubview:roomTypeLabel];
            [orderView addSubview:payNum];
            [orderView addSubview:payNumField];
            [orderView addSubview:closeViewButton];
            [orderView addSubview:payButton];
            [self.view addSubview:orderView];
        }
    }else if(isLogin == 0) {
        
        [self presentModalViewController:loginVC animated:YES];
    }

}
-(void)closeOrderView
{
    [orderView removeFromSuperview];
}

- (void)payBtnPress
{
    if ([payNumField.text intValue] < [myNum intValue]) {
        SDZYuDingRoomService *service = [SDZYuDingRoomService service];
        
        service.logging = YES;
        
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
    
    NSArray *orderArray = [result componentsSeparatedByString:@","];
    
    NSLog(@"数字是：%@",result);
    SDZYuDingRoomService *service = [SDZYuDingRoomService service];
    
    orderNumber = [orderArray objectAtIndex:0];
    
    if ([[orderArray objectAtIndex:1] intValue] == 2) {
        [service getZhiFuConfig:self action:@selector(getZhiFuConfigHandle:) sessionId:mySession];
    }
    


}
//  获取支付宝信息
- (NSString*)URLencode:(NSString *)originalString
        stringEncoding:(NSStringEncoding)stringEncoding {
    //!  @  $  &  (  )  =  +  ~  `  ;  '  :  ,  /  ?
    //%21%40%24%26%28%29%3D%2B%7E%60%3B%27%3A%2C%2F%3F
    NSArray *escapeChars = [NSArray arrayWithObjects:@";" , @"/" , @"?" , @":" ,
                            @"@" , @"&" , @"=" , @"+" ,    @"$" , @"," ,
                            @"!", @"'", @"(", @")", @"*", nil];
    
    NSArray *replaceChars = [NSArray arrayWithObjects:@"%3B" , @"%2F", @"%3F" , @"%3A" ,
                             @"%40" , @"%26" , @"%3D" , @"%2B" , @"%24" , @"%2C" ,
                             @"%21", @"%27", @"%28", @"%29", @"%2A", nil];
    
    int len = [escapeChars count];
    
    NSMutableString *temp = [[originalString
                              stringByAddingPercentEscapesUsingEncoding:stringEncoding]
                             mutableCopy];
    
    int i;
    for (i = 0; i < len; i++) {
        
        [temp replaceOccurrencesOfString:[escapeChars objectAtIndex:i]
                              withString:[replaceChars objectAtIndex:i]
         options:NSLiteralSearch
                                   range:NSMakeRange(0, [temp length])];
    }
    
    NSString *outStr = [NSString stringWithString: temp];
    
    return outStr;
}
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
    SDZMobileZhiFuConfig *result = (SDZMobileZhiFuConfig*)value;
    
    NSString *keyVal = @"cn.com.winghall.EncryptUtil.whadmin";
    

    NSString *zhifubao_notify_url_ava = [self TripleDES:result.zhifubao_notify_url encryptOrDecrypt:kCCDecrypt key:keyVal];
    
    
    NSLog(@"%@",zhifubao_notify_url_ava);
    
    zhifubao_notify_url_ava = [self URLencode:zhifubao_notify_url_ava stringEncoding:NSUTF8StringEncoding];
    
    NSLog(@"%@",zhifubao_notify_url_ava);
    
    NSString *partner = [self TripleDES:result.zhifubao_partner encryptOrDecrypt:kCCDecrypt key:keyVal];
//    NSString *zhifubao_return_url_shouji_ava = [self TripleDES:result.zhifubao_return_url_shouji encryptOrDecrypt:kCCDecrypt key:keyVal];
    NSString *zhifubao_rsa_alipay_public_ava = [self TripleDES:result.zhifubao_rsa_alipay_public encryptOrDecrypt:kCCDecrypt key:keyVal];
    
    NSString *zhifubao_rsa_private_ava = [self TripleDES:result.zhifubao_rsa_private encryptOrDecrypt:kCCDecrypt key:keyVal];
    NSString *seller = result.zhifubao_seller_email;
    
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:zhifubao_rsa_alipay_public_ava forKey:@"zhifubao_rsa_alipay_public"];
    
    //partner和seller获取失败,提示
	if ([partner length] == 0 || [seller length] == 0)
	{
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
														message:@"缺少partner或者seller。" 
													   delegate:self 
											  cancelButtonTitle:@"确定" 
											  otherButtonTitles:nil];
		[alert show];
		return;
	}
    /*生成订单信息及签名
    *由于demo的局限性，本demo中的公私钥存放在AlixPayDemo-Info.plist中,外部商户可以存放在服务端或本地其他地方。
    */
	//将商品信息赋予AlixPayOrder的成员变量
    
	AlixPayOrder *order = [[AlixPayOrder alloc] init];
	order.partner = partner;
	order.seller = seller;
	order.tradeNO = orderNumber; //订单ID（由商家自行制定）
	order.productName = myHotelName; //商品标题
	order.productDescription = myDesc; //商品描述
	order.amount = [NSString stringWithFormat:@"%.2f",[myPrice floatValue]]; //商品价格
	order.notifyURL =  zhifubao_notify_url_ava; //回调URL
	
	//应用注册scheme,在AlixPayDemo-Info.plist定义URL types,用于安全支付成功后重新唤起商户应用
	NSString *appScheme = @"dingfang"; 
	
	//将商品信息拼接成字符串
	NSString *orderSpec = [order description];
	NSLog(@"orderSpec = %@",orderSpec);
    
	//获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode

	id<DataSigner> signer = CreateRSADataSigner(zhifubao_rsa_private_ava);
	NSString *signedString = [signer signString:orderSpec];
	
	//将签名成功字符串格式化为订单字符串,请严格按照该格式
	NSString *orderString = nil;
	if (signedString != nil) {
		orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
	}
	//获取安全支付单例并调用安全支付接口
	AlixPay * alixpay = [AlixPay shared];
	int ret = [alixpay pay:orderString applicationScheme:appScheme];
	
	if (ret == kSPErrorAlipayClientNotInstalled) {
		UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" 
															 message:@"您还没有安装支付宝的客户端，请先装。" 
															delegate:self 
												   cancelButtonTitle:@"确定" 
												   otherButtonTitles:nil];
		[alertView setTag:123];
		[alertView show];
	}
	else if (ret == kSPErrorSignError) {
		NSLog(@"签名错误！");
	}    

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (alertView.tag == 123) {
		NSString * URLString = [NSString stringWithString:@"http://itunes.apple.com/cn/app/id333206289?mt=8"];
		[[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLString]];
	}
}

- (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key {
    
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        //        NSData *EncryptData = [GTMBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
        NSData *EncryptData = [plainText hexToBytes];   // 收到的十六进制转为byte存入NSData
        plainTextBufferSize = [EncryptData length];
        vplainText = [EncryptData bytes];
    }
    else
    {
        NSData* data = [plainText dataUsingEncoding:NSUTF8StringEncoding];
        plainTextBufferSize = [data length];
        vplainText = (const void *)[data bytes];
    }
    
    CCCryptorStatus ccStatus;
    uint8_t *bufferPtr = NULL;
    size_t bufferPtrSize = 0;
    size_t movedBytes = 0;
    // uint8_t ivkCCBlockSize3DES;
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    //    NSString *key = @"123456789012345678901234";
    const void *vkey = (const void *) [key UTF8String];
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithmDES,
                       kCCOptionPKCS7Padding|kCCOptionECBMode,
                       vkey,  //key
                       kCCKeySizeDES,
                       NULL, //"init Vec", //iv,
                       vplainText, //"Your Name", //plainText,
                       plainTextBufferSize,
                       (void *)bufferPtr,
                       bufferPtrSize,
                       &movedBytes);
    //if (ccStatus == kCCSuccess) NSLog(@"SUCCESS");
    /*else if (ccStatus == kCC ParamError) return @"PARAM ERROR";
     else if (ccStatus == kCCBufferTooSmall) return @"BUFFER TOO SMALL";
     else if (ccStatus == kCCMemoryFailure) return @"MEMORY FAILURE";
     else if (ccStatus == kCCAlignmentError) return @"ALIGNMENT";
     else if (ccStatus == kCCDecodeError) return @"DECODE ERROR";
     else if (ccStatus == kCCUnimplemented) return @"UNIMPLEMENTED"; */
    
    NSString *result;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        result = [[NSString alloc] initWithData:[NSData dataWithBytes:(const void *)bufferPtr 
                                                               length:(NSUInteger)movedBytes] 
                                       encoding:NSUTF8StringEncoding];
    }
    else
    {      
        
        result = [self parseByte2HexString:bufferPtr ];
        
        
    }
    
    return result;
    
} 
-(NSString *) parseByte2HexString:(Byte *) bytes
{
    NSMutableString *hexStr = [[NSMutableString alloc]init];
    int i = 0;
    if(bytes)
    {
        while (bytes[i] != '\0') 
        {
            NSString *hexByte = [NSString stringWithFormat:@"%X",bytes[i] & 0xff];///16进制数
            if([hexByte length]==1)
                [hexStr appendFormat:@"0%@", hexByte];
            else 
                [hexStr appendFormat:@"%@", hexByte];
            
            i++;
        }
    }
    return hexStr;
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
