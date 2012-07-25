//
//  DingDanViewController.m
//  dingfang
//
//  Created by user on 12-6-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DingDanViewController.h"
#import "SDZUserService.h"
#import "SDZYuDingRoomService.h"
#import "iToast.h"



@implementation DingDanViewController

@synthesize delegate,navBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    [self labelAdd];
    
//   tableview add
    
    ddArr = [NSArray arrayWithObjects:@"最近3天订单",@"最近30天订单",@"所有订单", nil];
    
    orderTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 200, 320, 180) style:UITableViewStyleGrouped];
    
    orderTableView.backgroundColor = [UIColor clearColor];
    
    orderTableView.delegate = self;
    
    orderTableView.dataSource = self;
    
    orderTableView.scrollEnabled = NO;
    
    NSDate *date = [NSDate date];
    
    int time = [date timeIntervalSince1970];
    
    int firstTime = time - 3*24*60*60;
    
    int secondTime = time - 30*24*60*60; 
    
    NSDate *firstDate = [[NSDate alloc] initWithTimeIntervalSince1970:firstTime];
    
    NSDate *secondDate = [[NSDate alloc] initWithTimeIntervalSince1970:secondTime];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"yyyyMMddHHMMSS000"];
    
    nowTime = [formatter stringFromDate:date];
    
    firstDateTime = [formatter stringFromDate:firstDate];
    
    secondDateTime = [formatter stringFromDate:secondDate];
    
    NSLog(@"%@",nowTime);
    NSLog(@"%@",firstDateTime);
    NSLog(@"%@",secondDateTime);
    
    
    [self.view addSubview:orderTableView];
    
    
    
    
    
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(void)labelAdd
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *nickName = [userDefaults objectForKey:@"nickName"];
    NSInteger grade = [userDefaults integerForKey:@"grade"];
    double score = [userDefaults doubleForKey:@"score"];
    double money = [userDefaults doubleForKey:@"money"];
    NSString *lastLoginTime = [userDefaults objectForKey:@"lastLoginTime"];
    
    UILabel *nickNameL = [[UILabel alloc] initWithFrame:CGRectMake(20, 60, 150, 20)];
    UILabel *gradeL = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 150, 20)];
    UILabel *scoreL = [[UILabel alloc] initWithFrame:CGRectMake(20, 120, 150, 20)];
    UILabel *moneyL = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, 150, 20)];
    UILabel *lastLoginTimeL = [[UILabel alloc] initWithFrame:CGRectMake(20, 180, 280, 20)];
    
    nickNameL.text = nickName;
    nickNameL.textColor = [UIColor orangeColor];
    gradeL.text = [NSString stringWithFormat:@"用户等级：%d",grade];
    scoreL.text = [NSString stringWithFormat:@"积分：%ld",score];
    moneyL.text = [NSString stringWithFormat:@"云和币：%ld",money];
    lastLoginTimeL.text =[NSString stringWithFormat:@"上次登录时间：%@",lastLoginTime]; 
    
    [self.view addSubview:nickNameL];
    [self.view addSubview:gradeL];
    [self.view addSubview:scoreL];
    [self.view addSubview:moneyL];
    [self.view addSubview:lastLoginTimeL];
    
//  tableView
    
    

}
- (IBAction)colseView:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];  
}

- (IBAction)logoutAction:(id)sender
{

    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *mySession = [userDefaults objectForKey:@"userSessionKey"];
    
    SDZUserService *userService = [SDZUserService service];
    userService.logging = YES;
    
    [userService logout:self action:nil sessionId:mySession];
    
    int isLogin = 0;
    
    [userDefaults setInteger:isLogin forKey:@"isLogin"];
    
    [delegate colseUserBtn];
    
    

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [ddArr count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    cell = [orderTableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] init];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; 
    }  
    
    // Configure the cell...
    UILabel *ddLable = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, 200, 30)];
    
    ddLable.text =[ddArr objectAtIndex:indexPath.row];
    ddLable.backgroundColor = [UIColor clearColor];
    ddLable.font = [UIFont systemFontOfSize:12];
    
    
    
    [cell.contentView addSubview:ddLable];
    
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    SDZYuDingRoomService *service = [SDZYuDingRoomService service];
    
    NSUserDefaults *SaveDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *mySession = [SaveDefaults objectForKey:@"userSessionKey"];

//   查找特定时间的订单信息    

    if (indexPath.row == 0) {
            [service findYuDingRoomLogInfo:self action:@selector(findYuDingRoomLogInfoHandler:) sessionId:mySession hotelId:nil cityName:nil startTime:firstDateTime endTime:nowTime pageNo:1 perPageNum:10];
    }else if (indexPath.row == 1) {
            [service findYuDingRoomLogInfo:self action:@selector(findYuDingRoomLogInfoHandler:) sessionId:mySession hotelId:nil cityName:nil startTime:secondDateTime endTime:nowTime pageNo:1 perPageNum:10];
    }else if (indexPath.row == 2) {
            [service findYuDingRoomLogInfo:self action:@selector(findYuDingRoomLogInfoHandler:) sessionId:mySession hotelId:nil cityName:nil startTime:@"19700101000000000" endTime:nowTime pageNo:1 perPageNum:10];
    }
    


    
    
    
    
}



-(void)findYuDingRoomLogInfoHandler:(id)value
{
    NSMutableArray *result = (NSMutableArray*)value;
    
    if ([value isKindOfClass:[NSError class]]) {
    NSLog(@"Error: %@", value);
    return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    
    NSLog(@"%@",result);
    
    if (result == nil || [result count] == 0) {
        
        [[iToast makeText:@"没有记录"] show];
        return;
    
    }else {
        
        NSLog(@"?????");
        itemArr = [NSMutableArray array];
        
        for (SDZOperLog *node in result) {
            CXMLDocument *document = [[CXMLDocument alloc] initWithXMLString:[node serialize] options:0 error:nil];
            
            [self parseDire:document];
            
            [itemArr addObject:item];
        }
        
        NSUserDefaults *SaveDefaults = [NSUserDefaults standardUserDefaults];
        
        [SaveDefaults setObject:itemArr forKey:@"itemArr"];
        
        NSLog(@"%@",itemArr);
        
        ddTableViewController = [[DDTableViewController alloc] init];
        [self presentModalViewController:ddTableViewController animated:YES];
    }
}
//方式二:按节点查找
- (void) parseDire:(CXMLDocument *) document
{
    NSArray *OperLog = NULL;
    OperLog = [document nodesForXPath:@"//OperLog" error:nil];
    for (CXMLElement *element in OperLog)
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
//                                        NSLog(@"%@", [[element childAtIndex:i] stringValue]);
                }
            }
//            NSLog(@"%@", item);
        }
    }
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
