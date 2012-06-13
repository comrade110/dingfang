//
//  CommentViewController.m
//  dingfang
//
//  Created by user on 12-6-12.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

@synthesize zStarView,hjStarView,fwStarView,ratingLabel,commTableView,commentArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *commonBtn = [[UIButton alloc] initWithFrame:CGRectMake(230, 20, 90, 30)];
    commonBtn.backgroundColor = [UIColor orangeColor];
    [commonBtn setTitle:@"我要评论" forState:UIControlStateNormal];
    [commonBtn addTarget:self action:@selector(showCommView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:commonBtn];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    mySession = [userDefaults objectForKey:@"userSessionKey"];
    NSString *myHotelID = [userDefaults objectForKey:@"hotelID"];    
    myHotelLong = [myHotelID longLongValue];
    
    NSLog(@"%ld",myHotelLong);
        
    SDZYuDingRoomService *service = [SDZYuDingRoomService service];
    service.logging = YES;  
    [service findYuDingCommentByHotel:self action:@selector(findYuDingCommentByHotelHandler:) sessionId:mySession hotelId:myHotelLong pageNo:1 perPageNum:10];
    
    
    commTableView.delegate = self;
    commTableView.dataSource = self;
    
    
}

- (void)showCommView
{
    
    UIButton *closeCommWindowBtn = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 60, 26)];    
    closeCommWindowBtn.backgroundColor = [UIColor grayColor];
    [closeCommWindowBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeCommWindowBtn addTarget:self action:@selector(closeCommView) forControlEvents:UIControlEventTouchUpInside];
    
    commentView = [[UIView alloc] initWithFrame:CGRectMake(0, 480, 320, 480)];
    
    UILabel *zComm = [[UILabel alloc] initWithFrame:CGRectMake(30, 58, 60, 30)];
    zComm.text = @"总体评价";
    zComm.backgroundColor = [UIColor clearColor];
    zComm.font = [UIFont systemFontOfSize:14];
    
    UILabel *hjComm = [[UILabel alloc] initWithFrame:CGRectMake(30, zComm.frame.origin.y + zComm.frame.size.height +10, 60, 30)];
    hjComm.text = @"环境评价";
    hjComm.backgroundColor = [UIColor clearColor];
    hjComm.font = [UIFont systemFontOfSize:14];
    
    UILabel *fwComm = [[UILabel alloc] initWithFrame:CGRectMake(30, hjComm.frame.origin.y + hjComm.frame.size.height +10, 60, 30)];
    fwComm.text = @"服务评价";
    fwComm.backgroundColor = [UIColor clearColor];
    fwComm.font = [UIFont systemFontOfSize:14];
    
    zStarView = [[RatingView alloc]init];
    
    zStarView.frame = CGRectMake(110, 60, 200, 30);
	[zStarView setImagesDeselected:@"0.png" partlySelected:@"1.png" fullSelected:@"2.png" andDelegate:self];
	[zStarView displayRating:4];
    
    hjStarView = [[RatingView alloc]init];
    
    hjStarView.frame = CGRectMake(110, zStarView.frame.origin.y + zStarView.frame.size.height +20, 200, 30);
	[hjStarView setImagesDeselected:@"0.png" partlySelected:@"1.png" fullSelected:@"2.png" andDelegate:self];
	[hjStarView displayRating:4];
    
    fwStarView = [[RatingView alloc]init];
    
    fwStarView.frame = CGRectMake(110, hjStarView.frame.origin.y + hjStarView.frame.size.height +20, 200, 30);
	[fwStarView setImagesDeselected:@"0.png" partlySelected:@"1.png" fullSelected:@"2.png" andDelegate:self];
	[fwStarView displayRating:4];
    
    
//  输入框    
    
    commTextView = [[UITextView alloc] initWithFrame:CGRectMake(30, fwStarView.frame.origin.y + fwStarView.frame.size.height +20, 280, 40)];
    commTextView.delegate = self;
    
    commTextView.backgroundColor = [UIColor colorWithRed:0.1 green:0.3 blue:0.2 alpha:1];
        
//  提交按钮    
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake(130, commTextView.frame.origin.y + commTextView.frame.size.height+20, 60, 26)];    
    submitBtn.backgroundColor = [UIColor grayColor];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitComm) forControlEvents:UIControlEventTouchUpInside];
    
//  点击空白隐藏键盘
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyBoard:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    [commentView addGestureRecognizer: tapGestureRecognizer]; 
    [tapGestureRecognizer setCancelsTouchesInView:NO]; 
    
    
    [commentView addSubview:closeCommWindowBtn];
    [commentView addSubview:zComm];
    [commentView addSubview:hjComm];
    [commentView addSubview:fwComm];
    [commentView addSubview:zStarView];
    [commentView addSubview:hjStarView];
    [commentView addSubview:fwStarView];
    [commentView addSubview:commTextView];
    [commentView addSubview:submitBtn];
    
    [UIView beginAnimations:@"comeOut" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    commentView.frame = CGRectMake(0, 0, 320, 480);
    commentView.backgroundColor = [UIColor whiteColor];
    [UIView commitAnimations];
    
    
    [[[UIApplication sharedApplication] keyWindow] addSubview:commentView];
    [commTextView becomeFirstResponder];

}
- (void)hideKeyBoard:(id)sender
{
    [commTextView  resignFirstResponder];
}

//关闭

-(void)closeCommView
{
    
    [commTextView resignFirstResponder];
    [UIView beginAnimations:@"comeOut" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    commentView.frame = CGRectMake(0, 480, 320, 480);
    [UIView commitAnimations];
    
    [[[UIApplication sharedApplication] keyWindow] removeFromSuperview];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range  replacementText:(NSString *)text
{
    if (range.length==0) {
        if ([text isEqualToString:@"\n"]) {
            [textView resignFirstResponder];
            return NO;
        }
    }
    
    return YES;
}


//  提交评论

-(void)submitComm
{
    
    SDZYuDingRoomService *service = [SDZYuDingRoomService service];
    service.logging = YES;        
    
    submitComment = commTextView.text;
    [service saveYuDingComment:self action:@selector(saveYuDingCommentHandler:) sessionId:mySession hotelId:myHotelLong userId:2 evaluate:submitZP environment:submitHJ service:submitFW comment:submitComment];
    
    [self closeCommView];
    

}
- (void) findYuDingCommentByHotelHandler: (id) value {
    
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"%@", value);
		return;
	}
    
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"%@", value);
		return;
	}				
    
    NSMutableArray* result = (NSMutableArray*)value;
    self.commentArr = [[NSMutableArray alloc] init];
    for (int i = 0; i <((NSMutableArray *)result).count; i++) {
        
        SDZYuDingRoom *myObj = [result objectAtIndex:i];
        
        [commentArr addObject:[myObj serialize]];   // [myObj serialize]序列化数组元素，否则不能解析
        
    }
    
    [self.commTableView reloadData];
    
}


- (void) saveYuDingCommentHandler: (BOOL) value {
    
    
	// Do something with the BOOL result
    
	NSLog(@"saveYuDingComment returned the value: %@", [NSNumber numberWithBool:value]);
    
}


-(void)ratingChanged:(float)newRating {
	newRating = zStarView.rating;
    submitZP = newRating ;
    
	newRating = hjStarView.rating;
	submitHJ = newRating;
    
    newRating = fwStarView.rating;
	submitFW = newRating;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [commentArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (commentArr != NULL) {
        
        CXMLDocument *document = [[CXMLDocument alloc] initWithXMLString:[commentArr objectAtIndex:indexPath.row] options:0 error:nil];
        CXMLDocument *document2 = [[CXMLDocument alloc] initWithXMLString:[commentArr objectAtIndex:indexPath.row] options:0 error:nil];
        
        [self parseDire:document]; 
        [self parseDire2:document2]; 
    }  
    
    
    // Configure the cell...
    NSString *identifier = nil;
    identifier = @"commentCell";
    UITableViewCell *cell;
    
    NSString *userEvaluate = [item valueForKey:@"evaluate"];
    NSString *nickName = [item2 valueForKey:@"nickName"];
    NSString *userComment = [item valueForKey:@"comment"];
    
    cell = [commTableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    } else{ 
        NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews]; 
        for (UIView *subview in subviews) { 
            [subview removeFromSuperview]; 
        } 
    } 
    
    UIImageView *starScoreImgView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 0, 108, 20)];
    
    [starScoreImgView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"commentScore%@",userEvaluate]]];
    
    UILabel *nickNameLable = [[UILabel alloc] initWithFrame:CGRectMake(220, 0, 140, 30)];
    
    nickNameLable.text = nickName;
    nickNameLable.font = [UIFont systemFontOfSize:12.0f];
    nickNameLable.textColor = [UIColor orangeColor];
    
    UILabel *userCommentLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, 420, 30)];
    
    userCommentLabel.text = userComment;
    userCommentLabel.font = [UIFont systemFontOfSize:12.0f];
    
    [cell.contentView addSubview:starScoreImgView];
    [cell.contentView addSubview:nickNameLable];
    [cell.contentView addSubview:userCommentLabel];
    
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72.0;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
//方式二:按节点查找
- (void) parseDire:(CXMLDocument *) document
{
    NSArray *YuDingRoom = NULL;
    YuDingRoom = [document nodesForXPath:@"//YuDingComment" error:nil];
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
    YuDingRoom = [document nodesForXPath:@"//user" error:nil];
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

@end
