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
//  DownloadGameInfoOperation.m
//  BGG
//
//  Created by RYAN CHRISTIANSON on 10/28/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "DownloadGameInfoOperation.h"

#import "GameInfoViewController.h";
#import "GameActionsViewController.h";
#import "BBGSearchResult.h"
#import "FullGameInfo.h";
#import "XmlGameInfoReader.h"
#import "DbAccess.h"
#import "BGGAppDelegate.h"

@implementation DownloadGameInfoOperation

@synthesize tabBarController;
@synthesize statsController;
@synthesize infoController;
@synthesize actionsController;
@synthesize searchResult;


- (id) init {
	self = [super init];
	if (self != nil) {
		isExe = NO;
		isDone = NO;
	}
	return self;
}

- (void) doTheWork {
	
	[self willChangeValueForKey:@"isExecuting"];
	isExe=YES;
	[self didChangeValueForKey:@"isExecuting"];	
	
	[NSThread sleepForTimeInterval:1.0];

	
	NSAutoreleasePool *autoreleasepool = [[NSAutoreleasePool alloc] init];
	
	
	BGGAppDelegate *appDelegate = (BGGAppDelegate *) [[UIApplication sharedApplication] delegate];
	
	fullGameInfo = [appDelegate getFullGameInfoByGameIdFromBGG:searchResult.gameId];	
	[fullGameInfo retain];
		
		
	if ( [self isCancelled] == NO ) {
		[self performSelectorOnMainThread:@selector(updateControllers) withObject:self waitUntilDone:YES];	
	}
	
	
	[autoreleasepool release];
	

	
	[self willChangeValueForKey:@"isExecuting"];
	[self willChangeValueForKey:@"isFinished"];
	isExe=NO;
	isDone=YES;
	[self didChangeValueForKey:@"isFinished"];
	[self didChangeValueForKey:@"isExecuting"];
	
}


-(void) updateControllers {
	
	if ( fullGameInfo == nil )  {
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error", @"error title.")
														message:NSLocalizedString(@"Error downloading game information. Check your network connection. It is also possible that the boardgamegeek.com website is down.", @"error download game.")
													   delegate:self cancelButtonTitle:NSLocalizedString(@"OK",@"okay button") otherButtonTitles: nil];
		[alert show];	
		[alert release];
		
		
		BGGAppDelegate *appDelegate = (BGGAppDelegate *) [[UIApplication sharedApplication] delegate];
		
		
		[appDelegate.navigationController popViewControllerAnimated:YES];
		
		
		return;
	}
	
	
	if ( [self isCancelled] == NO ) {
		tabBarController.title = fullGameInfo.title;
		BGGAppDelegate *appDelegate = (BGGAppDelegate *) [[UIApplication sharedApplication] delegate];
		[appDelegate.navigationController setTitle:fullGameInfo.title];
	}
	
	
	if ( [self isCancelled] == NO ) {
		[infoController updateForGameInfo: fullGameInfo];
	}
	if ( [self isCancelled] == NO ) {
		[statsController updateForGameStats:fullGameInfo];
	}
	if ( [self isCancelled] == NO ) {
		actionsController.fullGameInfo = fullGameInfo;
	}	
}

- (void)start {
	
	
	[NSThread detachNewThreadSelector:@selector(doTheWork) toTarget:self withObject:nil];
	

}

- (BOOL)isConcurrent {
	return YES;
}

- (BOOL)isExecuting {
	return isExe;
}


- (BOOL)isFinished {
	return isDone;
}

- (void) dealloc
{
	[tabBarController release];
	[fullGameInfo release];
	[statsController release];
	[infoController release];
	[actionsController release];
	[searchResult release];	
	
	
	[super dealloc];
}



@end
