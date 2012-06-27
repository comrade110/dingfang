//
//  dfViewController.m
//  dingfang
//
//  Created by user on 12-5-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "dfViewController.h"
#import "loginViewController.h"
#import "DingDanViewController.h"


@implementation dfViewController

@synthesize loginBtn,hotelOrderBtn,userBtn;


- (void)passValue:(NSString *)valueOne
{
    userBtn = [[UIBarButtonItem alloc] initWithTitle:valueOne style:UIBarButtonItemStylePlain target:self action:@selector(gotoDingDanView)];
    
    self.navigationItem.rightBarButtonItem = nil;
    [self.navigationItem setRightBarButtonItem:userBtn];
    
    NSLog(@"the get value is %@", userBtn.title);
}

- (void)colseUserBtn
{

    self.navigationItem.rightBarButtonItem = nil;
    [self.navigationItem setRightBarButtonItem:loginBtn];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSString *key1 =@"cn.com.winghall.EncryptUtil.whadmin";  //解密key 

    NSString *asd = [self TripleDES:@"abc" encryptOrDecrypt:kCCEncrypt key:key1];
    
    
    NSLog(@"--%@---",asd);
    
    loginBtn = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStyleDone target:self action:@selector(gotoLoginView)];
    
   [[self navigationItem] setRightBarButtonItem:loginBtn];
    self.navigationItem.title = @"考";
}

- (NSString*)TripleDES:(NSString*)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt key:(NSString*)key {
    
    
    const void *vplainText;
    size_t plainTextBufferSize;
    
    if (encryptOrDecrypt == kCCDecrypt)
    {
        NSData *EncryptData = [GTMBase64 decodeData:[plainText dataUsingEncoding:NSUTF8StringEncoding]];
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
    
    bufferPtrSize = (plainTextBufferSize + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    // memset((void *) iv, 0x0, (size_t) sizeof(iv));
    
    //    NSString *key = @"123456789012345678901234";
    NSString *initVec = @"adsddd";
    const void *vkey = (const void *) [key UTF8String];
    const void *vinitVec = (const void *) [initVec UTF8String];
    
    ccStatus = CCCrypt(encryptOrDecrypt,
                       kCCAlgorithmDES,
                       kCCOptionPKCS7Padding|kCCOptionECBMode,
                       vkey, //"123456789012345678901234", //key
                       kCCKeySizeDES,
                       vinitVec, //"init Vec", //iv,
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
        NSLog(@"lalala");
    }
    else
    {
        NSData *myData = [NSData dataWithBytes:(const void *)bufferPtr length:(NSUInteger)movedBytes];
        result = [GTMBase64 stringByEncodingData:myData];
    }
    
    return result;
    
} 

-(void)gotoLoginView
{
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                  bundle:nil];
    loginViewController *loginVC = [sb instantiateViewControllerWithIdentifier:@"loginViewController"];
    
    loginVC.delegate = self;
    
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:loginVC animated:NO];
    NSLog(@"111 the get value is %@", loginBtn.title);
    
    
}

-(void)gotoDingDanView
{
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                  bundle:nil];
    DingDanViewController *dingDanVC = [sb instantiateViewControllerWithIdentifier:@"DingDanView"];
    
    dingDanVC.delegate = self;
    
    [self setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    [self presentModalViewController:dingDanVC animated:YES];
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
