//
//  UITableViewCellExt.m
//  dingfang
//
//  Created by user on 12-7-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UITableViewCellExt.h"

@implementation UITableViewCell (UITableViewCellExt)


- (void)setBackgroundImage:(UIImage*)image
{
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    self.backgroundView = imageView;
    
}

- (void)setBackgroundImageByName:(NSString*)imageName
{

    [self setBackgroundImage:[[UIImage imageNamed:imageName] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 320, 52)]];
}


@end

