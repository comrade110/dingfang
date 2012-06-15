//
//  BIDTaskListController.m
//  dingfang
//
//  Created by user on 12-5-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BIDTaskListController.h"
#import "SDZYuDingRoomService.h"
#import "SDZUserService.h"


@implementation BIDTaskListController

@synthesize listView,areaButton,cityArr,cityV,hotelArr,orderParameter;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    listView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, 340) style:UITableViewStylePlain];
    listView.delegate = self;
    listView.dataSource = self;
    [self.view addSubview:listView];
    
    
    listView.contentSize =CGSizeMake(320, 364);
    
    
	_refreshHeaderView=[[EGORefreshTableHeaderView alloc] initWithFrame:
						CGRectMake(0, listView.contentSize.height, 320, 480)];
	_refreshHeaderView.delegate=self;
	[listView addSubview:_refreshHeaderView];
	
    
    NSInteger initCount = 1;
    
    NSUserDefaults *SaveDefaults = [NSUserDefaults standardUserDefaults];
    [SaveDefaults setInteger:initCount forKey:@"initCount"];
    
    self.view.frame=CGRectMake(0,0, 320, 460);
    
    
    
    mySession = [SaveDefaults objectForKey:@"userSessionKey"];
    
    SDZYuDingRoomService *service = [SDZYuDingRoomService service];
    service.logging = YES;        
    [service findAllCity:self action:@selector(findAllCityHandle:) sessionId:mySession];  
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


//    获取城市列表

- (void)findAllCityHandle:(id)value
{
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    self.cityArr = (NSMutableArray*)value;
    
    [areaButton setTitle:[self getCityName] forState:UIControlStateNormal];
    
    
    orderParameter = nil;
    
    SDZYuDingRoomService *service = [SDZYuDingRoomService service];
    service.logging = YES;        
    [service findYuDingRoomByCondition:self action:@selector(findYuDingRoomByConditionHandle:) sessionId:mySession hotelId:nil hotelName:nil cityName:cityV hotelDengJi:nil minPrice:nil maxPrice:nil orderByCondition:orderParameter pageNo:1 perPageNum:7];
    
    [self.listView reloadData];
    
}

//   按城市获取该城市的酒店列表

-(void)findYuDingRoomByConditionHandle:(id)value
{
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    NSMutableArray *result = (NSMutableArray *)value;
    
    self.hotelArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i <((NSMutableArray *)result).count; i++) {
        
        SDZYuDingRoom *myObj = [result objectAtIndex:i];
        
        [hotelArr addObject:[myObj serialize]];   // [myObj serialize]序列化数组元素，否则不能解析
        
    }
    
    [self.listView reloadData];
    
    
}

-(void)findYuDingRoomByConditionContinueHandle:(id)value
{
    
    if ([value isKindOfClass:[NSError class]]) {
        NSLog(@"Error: %@", value);
        return;
    }
    if ([value isKindOfClass:[SoapFault class]]) {
        NSLog(@"Fault: %@", value);
        return;
    }
    
    NSMutableArray *result = (NSMutableArray *)value;
    
    for (int i = 0; i <((NSMutableArray *)result).count; i++) {
        
        SDZYuDingRoom *myObj = [result objectAtIndex:i];
        
        [hotelArr addObject:[myObj serialize]];   // [myObj serialize]序列化数组元素，否则不能解析
    }
    
    NSLog(@"--%d==",[hotelArr count]);
    
	int count=[hotelArr count];
    
	
	if(52*count>364)
	{
		listView.contentSize=CGSizeMake(320, 52*count);
		_refreshHeaderView.frame=CGRectMake(0, listView.contentSize.height, 320, 480);
		
	}
    [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0];
    [self.listView reloadData];
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


-(NSString *)getCityName
{
    if (cityV == NULL) {
        cityV = @"上海";
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    cityV = [userDefaults objectForKey:@"citySelKey"];
    [userDefaults synchronize];
    
    
    return cityV;
    
    
}
#pragma mark - IBAction

//       点击后按价格排序
- (IBAction)orderByPrice:(id)sender
{
    hotelArr = nil;
    
    if (orderParameter == nil) {
        orderParameter = @"1|true";
    }else if (orderParameter != @"1|true") {
        orderParameter = @"1|true";
    }else if(orderParameter != @"1|false"){
        orderParameter = @"1|false";
    }
    
    
    SDZYuDingRoomService *service = [SDZYuDingRoomService service];
    service.logging = YES; 
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger curCount = [userDefaults integerForKey:@"initCount"];
    curCount = 1;
    [userDefaults setInteger:curCount forKey:@"initCount"];
    
    [service findYuDingRoomByCondition:self action:@selector(findYuDingRoomByConditionHandle:) sessionId:mySession hotelId:nil hotelName:nil cityName:cityV hotelDengJi:nil minPrice:nil maxPrice:nil orderByCondition:orderParameter pageNo:1 perPageNum:7];
    listView.frame = CGRectMake(0, 40, 320, 340);
    listView.contentSize =CGSizeMake(320, 364);
    
    [_refreshHeaderView removeFromSuperview];
	_refreshHeaderView=[[EGORefreshTableHeaderView alloc] initWithFrame:
						CGRectMake(0, listView.contentSize.height, 320, 480)];
	_refreshHeaderView.delegate=self;
	[listView addSubview:_refreshHeaderView];
	
	[_refreshHeaderView refreshLastUpdatedDate];   
    
    
    
    [listView reloadData];
}
//       点击后按发布时间排序
- (IBAction)orderByTime:(id)sender
{
    hotelArr = nil;
    
    if (orderParameter == nil) {
        orderParameter = @"2|true";
    }else if (orderParameter != @"2|true") {
        orderParameter = @"2|true";
    }else if(orderParameter != @"2|false"){
        orderParameter = @"2|false";
    }
    
    
    SDZYuDingRoomService *service = [SDZYuDingRoomService service];
    service.logging = YES; 
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSInteger curCount = [userDefaults integerForKey:@"initCount"];
    curCount = 1;
    [userDefaults setInteger:curCount forKey:@"initCount"];
    
    [service findYuDingRoomByCondition:self action:@selector(findYuDingRoomByConditionHandle:) sessionId:mySession hotelId:nil hotelName:nil cityName:cityV hotelDengJi:nil minPrice:nil maxPrice:nil orderByCondition:orderParameter pageNo:1 perPageNum:7];
    
    listView.frame = CGRectMake(0, 40, 320, 340);
    listView.contentSize =CGSizeMake(320, 364);
    
    [_refreshHeaderView removeFromSuperview];
	_refreshHeaderView=[[EGORefreshTableHeaderView alloc] initWithFrame:
						CGRectMake(0, listView.contentSize.height, 320, 480)];
	_refreshHeaderView.delegate=self;
	[listView addSubview:_refreshHeaderView];
	
	[_refreshHeaderView refreshLastUpdatedDate];  
    
    [listView reloadData];
}
#pragma mark - 上拉刷新

//-(void)requestImage{
//		
//	//回到主线程跟新界面
//	[self performSelectorOnMainThread:@selector(dosomething) withObject:nil waitUntilDone:YES];
//    
//}

//此方法是开始读取数据
- (void)reloadTableViewDataSource{
	
	//should be calling your tableviews data source model to reload
	//put here just for demo
	_reloading = YES;
	NSLog(@"star");
    
    SDZYuDingRoomService *service = [SDZYuDingRoomService service];
    service.logging = YES; 
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSInteger curCount = [userDefaults integerForKey:@"initCount"];
    
    curCount+=1;
    
    NSLog(@"当前curcount = %d",curCount);
    [userDefaults setInteger:curCount forKey:@"initCount"];
    
    [service findYuDingRoomByCondition:self action:@selector(findYuDingRoomByConditionContinueHandle:) sessionId:mySession hotelId:nil hotelName:nil cityName:cityV hotelDengJi:nil minPrice:nil maxPrice:nil orderByCondition:orderParameter pageNo:curCount perPageNum:7];
    
    
    NSLog(@"当前数组元素个数为：%d",[hotelArr count]);
	//打开线程，读取网络图片
//        [NSThread detachNewThreadSelector:@selector(requestImage) toTarget:self withObject:nil];
    
    
}

//-(void)dosomething
//{
//	
//}


//此方法是结束读取数据
- (void)doneLoadingTableViewData{
	
	//  model should call this when its done loading
	_reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:listView];
	NSLog(@"end");
	
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:listView];
	
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:listView];
	
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
	
	[self reloadTableViewDataSource];
	//[self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.5];
	
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
	
	return _reloading; // should return if data source model is reloading
	
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return [NSDate date]; // should return date data source was last changed
	
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    return [hotelArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (hotelArr != NULL) {
        
        CXMLDocument *document = [[CXMLDocument alloc] initWithXMLString:[hotelArr objectAtIndex:indexPath.row] options:0 error:nil];
        CXMLDocument *document2 = [[CXMLDocument alloc] initWithXMLString:[hotelArr objectAtIndex:indexPath.row] options:0 error:nil];
        
        [self parseDire:document]; 
        [self parseDire2:document2]; 
        
    }  
    
    
    // Configure the cell...
    NSString *identifier = nil;
    identifier = @"plainCell";
    UITableViewCell *cell;
    
    NSString *hotelname = [item2 valueForKey:@"name"];
    NSString *roomType = [item valueForKey:@"roomType"];
    NSString *releaseTime = [item valueForKey:@"releaseTime"];
    cell = [listView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    } else{ 
        NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews]; 
        for (UIView *subview in subviews) { 
            [subview removeFromSuperview]; 
        } 
    } 
    
    UILabel *cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 220, 30)];
    
    cellLabel.text = [NSString stringWithFormat:@"%@%@%@",hotelname,roomType,releaseTime];
    cellLabel.font = [UIFont systemFontOfSize:12.0f];
    
    UILabel *priceLable = [[UILabel alloc] initWithFrame:CGRectMake(220, 10, 140, 30)];
    
    float pricefloat = [[item valueForKey:@"price"] floatValue];
    
    NSString *price = [NSString stringWithFormat:@"%.3f元",pricefloat];
    
    priceLable.text = price;
    
    cellLabel.font = [UIFont systemFontOfSize:12.0f];
    priceLable.textColor = [UIColor orangeColor];
    
    [cell.contentView addSubview:cellLabel];
    [cell.contentView addSubview:priceLable];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52.0;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString *hotelDesc = [hotelArr objectAtIndex:indexPath.row];
    
    [userDefaults setObject:hotelDesc forKey:@"descKey"];
    
    
    
    UIStoryboard*  sb = [UIStoryboard storyboardWithName:@"MainStoryboard"
                                                  bundle:nil];
        IntroTabViewController *introTabViewController = [sb instantiateViewControllerWithIdentifier:@"IntroTabViewController"];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:introTabViewController animated:YES];
    

}



@end
