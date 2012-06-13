//
//  CommentViewController.h
//  dingfang
//
//  Created by user on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDZYuDingRoomService.h"
#import "BIDTaskListController.h"
#import "RatingView.h"

@interface CommentViewController : UIViewController<RatingViewDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource>{

    UIView *commentView;
	UILabel *ratingLabel;
    UITextView *commTextView;
    NSString *mySession;
    long myHotelLong;
    UITableView *commTableView;
    NSMutableDictionary *item;
    NSMutableDictionary *item2;
    NSMutableArray *commentArr;
    int submitZP;
    int submitHJ;
    int submitFW;
    NSString *submitComment;
}
@property (nonatomic, retain) RatingView *zStarView;
@property (nonatomic, retain) RatingView *hjStarView;
@property (nonatomic, retain) RatingView *fwStarView;
@property (nonatomic, retain) UILabel *ratingLabel;
@property (nonatomic, retain) IBOutlet UITableView *commTableView;
@property (nonatomic, retain) NSMutableArray *commentArr;


-(void)ratingChanged:(float)newRating;

@end
