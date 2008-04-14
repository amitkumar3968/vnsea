//
//  vnsea2AppDelegate.m
//  vnsea2
//
//  Created by Chris Reed on 4/5/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import "VnseaAppDelegate.h"
#import "VNCServerListViewController.h"

@implementation VnseaAppDelegate

@synthesize window = _window;
@synthesize navController = _navController;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	// Create our window.
	_window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	
	VNCServerListViewController * controller = [[VNCServerListViewController alloc] init];
	
	// Create the nav controller.
	_navController = [[UINavigationController alloc] initWithRootViewController:controller];
	[controller release];
    
    // Set up content view
//	self.contentView = [[[MyView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]] autorelease];

	[_window addSubview:_navController.view];
    
	// Show window
	[_window makeKeyAndVisible];
}

- (void)dealloc
{
//	[contentView release];
	[_window release];
	[super dealloc];
}

@end
