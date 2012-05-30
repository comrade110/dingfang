//
//  BIDTaskListController.m
//  dingfang
//
//  Created by user on 12-5-16.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "BIDTaskListController.h"

@interface BIDTaskListController ()

@end

@implementation BIDTaskListController

@synthesize tasks,tasks2,areaArrs,areaButton, webData, soapResults, xmlParser;

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
    
    
    self.tasks = [NSArray arrayWithObjects:
                  @"上海贝轩大公馆",
                  @"上海虹桥迎宾馆",
                  @"上海华亭宾馆",
                  @"上海宝安大酒店",
                  @"上海恒硕公寓酒店",
                  @"陕西大厦商务酒店",
                  @"上海星程南浦瑞峰酒店",
                  @"北京亚运村、奥运村商圈四星级酒店",
                  @"上海富豪环球东亚酒店",
                  nil];
    
    
    self.tasks2 = [NSArray arrayWithObjects:
                   @"h1.jpg",
                   @"h2.jpg",
                   @"h3.jpg",
                   @"h4.jpg",
                   @"h5.jpg",
                   @"h6.jpg",
                   @"h7.jpg",
                   @"h8.jpg",
                   @"LCEOpAjXO_wood.jpeg",
                   nil];
    
    self.areaArrs = [NSArray arrayWithObjects:
                   @"南京西路商业区，近西康路",
                   @"虹桥地区，近虹古路",
                   @"八万人体育场地区",
                   @"浦东陆家嘴金融贸易区，近崂山东路",
                   @"虹桥地区",
                   @"南京西路商业区",
                   @"南外滩地区",
                   @"淮海路商业区",
                   @"豫园地区",
                   nil];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewDidUnload
{
    [super viewDidUnload];
    self.tasks = nil;
    self.tasks2 = nil;
    self.areaArrs = nil;
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
    return [tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Configure the cell...
    NSString *identifier = nil;
    identifier = @"plainCell";
    UITableViewCell *cell;
    
    NSString *task2 = [self.tasks2 objectAtIndex:indexPath.row];
    UIImageView *hotelImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 12, 65, 65)];
    [hotelImgView setImage:[UIImage imageNamed:task2]];
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        
    } else{ 
        NSArray *subviews = [[NSArray alloc] initWithArray:cell.contentView.subviews]; 
        for (UIView *subview in subviews) { 
            [subview removeFromSuperview]; 
        } 
    } 
    

    NSString *task = [self.tasks objectAtIndex:indexPath.row];
    
    UILabel *cellLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 7, 180, 30)];
    
    cellLabel.text = task;
    cellLabel.font = [UIFont systemFontOfSize:14.0f];
    
    
    NSString *areaArr = [self.areaArrs objectAtIndex:indexPath.row];
    
    UILabel *cellLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(100, 38, 130, 20)];
    
    cellLabel2.text = areaArr;
    cellLabel2.font = [UIFont systemFontOfSize:10.0f];
    cellLabel2.textColor = [UIColor grayColor];
    
    [cell.contentView addSubview:cellLabel];
    [cell.contentView addSubview:cellLabel2];
    [cell.contentView addSubview:hotelImgView];
    
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
