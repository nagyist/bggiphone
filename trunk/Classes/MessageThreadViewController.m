/*
 Copyright 2010 Petteri Kamppuri
 
 Licensed under the Apache License, Version 2.0 (the "License"); 
 you may not use this file except in compliance with the License. 
 You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0 
 
 Unless required by applicable law or agreed to in writing, software distributed under the 
 License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, 
 either express or implied. See the License for the specific 
 language governing permissions and limitations under the License. 
 */ 

//
//  MessageThreadViewController.m
//  BGG
//
//  Created by Petteri Kamppuri on 3.1.2010.
//  Copyright 2010 Petteri Kamppuri. All rights reserved.
//

#import "MessageThreadViewController.h"
#import "BGGThread.h"
#import "BGGMessage.h"
#import "BGGHTMLScraper.h"
#import "HtmlTemplate.h"


@implementation MessageThreadViewController

@synthesize webView;
@synthesize loadingView;
@synthesize thread;

#pragma mark GameForumsViewController overrides

-(void) updateViews
{
	if ( items == nil )
	{
		webView.hidden = YES;
		[loadingView startAnimating];
		loadingView.hidden = NO;
	}
	else
	{
		NSString *templateFilePath = [NSString stringWithFormat:@"%@/thread_messages_template.html", [[NSBundle mainBundle] bundlePath]];
		
		NSMutableString *messagesHTML = [NSMutableString stringWithCapacity:3000];
		
		for(BGGMessage *message in items)
		{
			// TODO: Make a separate template for a single message
			
			[messagesHTML appendString:@"<div class=\"message\">"];
			
			[messagesHTML appendString:@"<div class=\"header\">"];
			[messagesHTML appendString:@"<span class=\"username\">"];
			[messagesHTML appendString:message.username];
			[messagesHTML appendString:@"</span>"];
			[messagesHTML appendString:@" (<span class=\"nickname\">"];
			[messagesHTML appendString:message.nickname];
			[messagesHTML appendString:@"</span>)<br>"];
			[messagesHTML appendString:@"<span class=\"postdate\">"];
			[messagesHTML appendString:message.postDate];
			[messagesHTML appendString:@"</span>"];
			[messagesHTML appendString:@"</div>"];
			
			[messagesHTML appendString:@"<div class=\"content\">"];
			[messagesHTML appendString:message.contents];
			[messagesHTML appendString:@"</div>"];
			
			[messagesHTML appendString:@"</div>"];
		}
		
		NSMutableDictionary *params = [NSMutableDictionary dictionary];
		
		[params setObject:self.thread.title forKey:@"#!title#"];
		[params setObject:messagesHTML forKey:@"#!messages#"];
		
		HtmlTemplate *messagesTemplate = [[[HtmlTemplate alloc] initWithFileName:templateFilePath] autorelease];
		
		NSString * pageHTML = [messagesTemplate allocMergeWithData:params];
		[pageHTML autorelease]; // Against Cocoa conventions...
		
		
		[loadingView stopAnimating];
		loadingView.hidden = YES;
		webView.hidden = NO;
		
		
		// set the web view to load it
		NSString *path = [[NSBundle mainBundle] bundlePath];
		NSURL *baseURL = [NSURL fileURLWithPath:path];
		
		[webView loadHTMLString:pageHTML baseURL:baseURL];
	}
}

-(NSString *) urlStringForLoading
{
	return [@"http://www.boardgamegeek.com" stringByAppendingString:self.thread.threadURL];
}

-(id) resultsFromDocument:(NSString *)document withHTMLScraper:(BGGHTMLScraper *)htmlScraper
{
	return [htmlScraper scrapeMessagesFromThread:document];
}

#pragma mark Public

-(id) init
{
	if((self = [super initWithNibName:@"GameInfo" bundle:nil]) != nil)
	{
		
	}
	return self;
}

-(void) dealloc
{
	[thread release];
	[loadingView release];
	[webView release];
	
	[super dealloc];
}

@end