//
//  cityListViewController.m
//  dingfang
//
//  Created by user on 12-6-1.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "cityListViewController.h"
#import "SDZYuDingRoomService.h"
#import "SDZUserService.h"

@interface cityListViewController ()


@end



@implementation cityListViewController

@synthesize userSession,cityArr,citySelTag;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    mySession = [userDefaults objectForKey:@"mySessionKey"];
    
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
    cityArr = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
    
}

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
//    NSLog(@"we have %@ city",[NSNumber numberWithInt:cityArr.count]); 
//    for (int i = 0; i < [cityArr count]; i++) {
//        NSLog(@"----%@------",[cityArr objectAtIndex:i]);
//    }  
    
    
    
    [self.tableView reloadData];
    
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
    return [self.cityArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{   

    NSString *identifier = nil;
    identifier = @"cityCell";
    UITableViewCell *cell;
    NSString *city = [self.cityArr objectAtIndex:indexPath.row];
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    } else{ 
        NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews]; 
        for (UIView *subview in subviews) { 
            [subview removeFromSuperview]; 
        } 
    } 
    UILabel *cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 180, 30)];
    
    cellLabel.text = city;
    cellLabel.font = [UIFont systemFontOfSize:16.0f];
    [cell.contentView addSubview:cellLabel];
    
    return cell;
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
    citySelTag = [cityArr objectAtIndex:indexPath.row];
    
    NSUserDefaults *SaveDefaults = [NSUserDefaults standardUserDefaults];
    [SaveDefaults setObject: citySelTag forKey:@"citySelKey"];
    
//    NSLog(@"cacaca  %@ cacaca",citySelTag);
}

@end
