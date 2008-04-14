//
//  VNCServerListViewController.m
//  vnsea
//
//  Created by Chris Reed on 4/5/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "VNCServerListViewController.h"
#import "VNCServers.h"
#import "ServerFromPrefs.h"
#import "VNCServerInfoViewController.h"

#define kNavItemTitle @"VNC Servers"

@implementation VNCServerListViewController

@synthesize tableView = _tableView;

- (id)init
{
	if (self = [super init])
	{
		// Initialize your view controller.
		self.title = kNavItemTitle;
	}
	return self;
}

- (void)dealloc
{
	[_tableView release];
	[super dealloc];
}

- (void)loadView
{
	// Create a custom view hierarchy.
	UITableView * view = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStylePlain];
	view.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
	view.dataSource = self;
	view.delegate = self;
	self.tableView = view;
	self.view = view;
	[view release];
	
	// Customise our nav item.
	UIButton * button = [UIButton buttonWithType:UIButtonTypeNavigation];
	[button setImage:[UIImage imageNamed:@"addicon.png"] forStates:UIControlStateNormal];
	[button addTarget:self action:@selector(addServer:) forControlEvents:UIControlEventTouchUpInside];
	
	self.navigationItem.customRightView = button;
	self.navigationItem.title = kNavItemTitle;
	self.navigationItem.backButtonTitle = @"Cancel";
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Return YES for supported orientations.
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview.
	// Release anything that's not essential, such as cached data.
}

- (void)addServer:(id)sender
{
	VNCServerInfoViewController * controller = [[VNCServerInfoViewController alloc] init];
	controller.isNew = YES;
	controller.serverIndex = [[VNCServers sharedServers] createNewServer];
	controller.serverInfo = [[VNCServers sharedServers] serverAtIndex:controller.serverIndex];
	NSLog(@"new server [%d] = %@", controller.serverIndex, controller.serverInfo);
	
	// Push controller onto the nav controller stack.
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
	
	[_tableView reloadData];
}

#pragma mark -Table data source-

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return [[VNCServers sharedServers] numberOfServers];
}

#pragma mark -Table delegate-

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	int serverIndex = indexPath.row;
	NSLog(@"indexPath = %@", indexPath);
	UITableViewCell * cell = [[UITableViewCell alloc] initWithFrame:[tableView rectForRowAtIndexPath:indexPath] reuseIdentifier:nil];
	NSDictionary * serverInfo = [[VNCServers sharedServers] serverAtIndex:serverIndex];
	cell.text = [serverInfo objectForKey:RFB_NAME];
	return cell;
}

//! All server rows will have the blue circular disclosure button that lets the
//! user open the editing view for that server.
- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellAccessoryDetailDisclosureButton;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
	NSLog(@"tapped disclosure button for %@", indexPath);
	
	// Create the view controller for editing the server info.
	VNCServerInfoViewController * controller = [[VNCServerInfoViewController alloc] init];
	controller.serverIndex = indexPath.row;
	controller.serverInfo = [[VNCServers sharedServers] serverAtIndex:indexPath.row];
	controller.isNew = NO;
	
	// Push the view controller into action.
	[self.navigationController pushViewController:controller animated:YES];
	[controller release];
}

//! All selection is disallowed.
//!
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	return nil;
}

@end
