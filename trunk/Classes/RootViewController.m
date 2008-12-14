/*
 Copyright 2008 Ryan Christianson
 
 Licensed under the Apache License, Version 2.0 (the "License"); 
 you may not use this file except in compliance with the License. 
 You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 
 
 Unless required by applicable law or agreed to in writing, software distributed under the 
 License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
 either express or implied. See the License for the specific 
 language governing permissions and limitations under the License. 
 */ 

//
//  RootViewController.m
//  BGG
//
//  Created by RYAN CHRISTIANSON on 10/16/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "RootViewController.h"
#import "BGGAppDelegate.h"
#import "SearchUIViewController.h"
#import "SettingsUIViewController.h"
#import "PlistSettings.h"
#import "XmlSearchReader.h"
#import "BoardGameSearchResultsTableViewController.h"
#import "AboutViewController.h"
#import "Beacon.h"




@implementation RootViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	
	if ( indexPath.row == SEARCH_MENU_CHOICE ) {
		cell.text = NSLocalizedString( @"Search" , @"search menu item" );
		cell.image = [UIImage imageNamed:@"search.png" ];
	}
	else if ( indexPath.row == PICK_GAME_CHOICE ) {
		cell.text = NSLocalizedString(@"Search Owned Game" , @"pick game menu item" );
		cell.image = [UIImage imageNamed:@"search_own.png" ];
	}
	else if ( indexPath.row == OWNED_MENU_CHOICE ) {
		cell.text = NSLocalizedString(@"Games Owned" , @"games owned menu item" );
		cell.image = [UIImage imageNamed:@"own.png" ];
	}	
	else if ( indexPath.row == WISH_MENU_CHOICE ) {
		cell.text = NSLocalizedString( @"Games On Wishlist" , @"games on wishlist menu item" );
		cell.image = [UIImage imageNamed:@"wish.png" ];
	}	
	else if ( indexPath.row == SETTINGS_MENU_CHOICE ) {
		cell.text = NSLocalizedString( @"Settings" , @"settings menu item" );
		cell.image = [UIImage imageNamed:@"settings.png" ];
	}		
	else if ( indexPath.row == ABOUT_MENU_CHOICE ) {
		cell.text = NSLocalizedString( @"About" , @"about menu item" );
		cell.image = [UIImage imageNamed:@"about.png" ];
	}		
	
    // Set up the cell
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self loadMenuItem:indexPath.row];
}

- (void) loadMenuItem:(NSInteger) menuItem {


    
	BGGAppDelegate *appDelegate = (BGGAppDelegate *) [[UIApplication sharedApplication] delegate];
	[appDelegate loadMenuItem:menuItem];
	
}



- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = NSLocalizedString( @"BGG", @"BGG app title" );
	
	
	UIImageView * headerView = [[UIImageView alloc] initWithImage:  [UIImage imageNamed:@"header.png"]];
	
	self.tableView.tableHeaderView = headerView;
	
	[headerView release];
	
	
	//UIImageView * footerView = [[UIImageView alloc] initWithImage:  [UIImage imageNamed:@"footer.png"]];
	
	//self.tableView.tableFooterView = footerView;
	
	//[footerView release];
	
	
    // Uncomment the following line to add the Edit button to the navigation bar.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



/*
// Override to support editing the list
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support conditional editing of the list
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support rearranging the list
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the list
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
}
*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end

