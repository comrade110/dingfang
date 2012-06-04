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

@synthesize areaButton,cityArr,cityV;

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
    
    
    SDZUserService *userService = [SDZUserService service];
    userService.logging = YES;
    [userService createSession:self action:@selector(createSessionHandler:)];
    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)cityValue:(NSString*)fromValue
{
    cityV = fromValue;
    
    
    NSLog(@"11111 %@ 11111",cityV);
}

- (void) createSessionHandler:(id)value {
    
	// Handle errors
	if([value isKindOfClass:[NSError class]]) {
		NSLog(@"error:%@", value);
		return;
	}
	// Handle faults
	if([value isKindOfClass:[SoapFault class]]) {
		NSLog(@"fault:%@", value);
		return;
	}
    NSString *userSession = (NSString *)value;
    
	// Do something with the NSString* result
	NSLog(@"createSession returned the Session: %@", userSession);
    
    SDZYuDingRoomService *service = [SDZYuDingRoomService service];
    service.logging = YES;        
    [service findAllCity:self action:@selector(findAllCityHandle:) sessionId:userSession];
    
    
    
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
    
    [areaButton setTitle:[cityArr objectAtIndex:0] forState:UIControlStateNormal];
    
    [self.tableView reloadData];
    
    cityListViewController *cityLisView = [self.storyboard instantiateViewControllerWithIdentifier:@"cityLisView"];
    
    cityLisView.delegate = self;
    
    [self cityValue:cityV];
    
    NSLog(@"99999 %@ 99999",cityV);
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    return [cityArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    NSString *identifier = nil;
    identifier = @"plainCell";
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


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}



@end
