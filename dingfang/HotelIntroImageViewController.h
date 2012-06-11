//
//  introImageViewController.h
//  dingfang
//
//  Created by user on 12-5-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HotelIntroImageViewController : UIViewController{
    
    UIImageView *imageView;
    
	int pageNumber;
}
@property (nonatomic, retain) IBOutlet UIImageView *imageView;

-(id)initWithPageNumber:(int)page;

@end
