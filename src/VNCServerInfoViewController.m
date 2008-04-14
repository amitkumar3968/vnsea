//
//  VNCServerInfoViewController.m
//  vnsea
//
//  Created by Chris Reed on 4/6/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "VNCServerInfoViewController.h"
#import "VNCServers.h"
#import "Constants.h"

//! Nav item title for when adding a new server.
#define kNavItemTitleNew @"Add Server"

//! Title for the navigation item for this controller's view.
#define kNavItemTitleEdit @"Edit Server"

//! Save button title.
#define kSaveButtonTitle @"Save"

//! Add button title.
#define kAddButtonTitle @"Add"

#define kTextFieldWidth							100.0	// initial width, but the table cell will dictact the actual width

@implementation VNCServerInfoViewController

@synthesize tableView = _tableView;
@synthesize isNew = _isNew;
@synthesize serverIndex = _serverIndex;
@synthesize serverInfo = _serverInfo;

- (id)init
{
	if (self = [super init])
	{
		// Initialize your view controller.
		self.title = kNavItemTitleEdit;
	}
	return self;
}

- (void)dealloc
{
	[_cells dealloc];
	[super dealloc];
}

- (UITextField *)createTextField
{
	CGRect frame = CGRectMake(0.0, 0.0, kTextFieldWidth, kTextFieldHeight);
	UITextField *textField = [[UITextField alloc] initWithFrame:frame];
   
	textField.borderStyle = UITextFieldBorderStyleNone;
    textField.textColor = [UIColor blackColor];
	textField.font = [UIFont systemFontOfSize:17.0];
    textField.placeholder = @"<enter text>";
    textField.backgroundColor = [UIColor whiteColor];
	textField.keyboardType = UIKeyboardTypeDefault;	// use the default type input method (entire keyboard)
	textField.returnKeyType = UIReturnKeyDone;
	textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
	textField.autocorrectionType = UITextAutocorrectionTypeNo;
	textField.clearButtonMode = UITextFieldViewModeNever;
	
	return textField;
}

- (void)loadView
{
	// Create table view cells for each server field.
	UICellTextField * nameCell = [[UICellTextField alloc] initWithFrame:CGRectZero];
	nameCell.delegate = self;
	nameCell.text = @"Name";
	nameCell.view = [self createTextField];
	
	UICellTextField * hostCell = [[UICellTextField alloc] initWithFrame:CGRectZero];
	hostCell.delegate = self;
	hostCell.text = @"Host";
	hostCell.view = [self createTextField];
	
	UICellTextField * passwordCell = [[UICellTextField alloc] initWithFrame:CGRectZero];
	passwordCell.delegate = self;
	passwordCell.text = @"Password";
	passwordCell.view = [self createTextField];
	passwordCell.view.secureTextEntry = YES;
	
	_cells = [[NSArray arrayWithObjects:nameCell, hostCell, passwordCell, nil] retain];
	
	// Create a custom view hierarchy.
	UITableView *view = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame style:UITableViewStyleGrouped];
	view.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	view.dataSource = self;
	view.delegate = self;
	self.tableView = view;
	self.view = view;
	[view release];
	
	// Set up navigation item.
	UIButton * button = [UIButton buttonWithType:UIButtonTypeNavigationDone];
	NSString * buttonTitle;
	if (self.isNew)
	{
		buttonTitle = kAddButtonTitle;
	}
	else
	{
		buttonTitle = kSaveButtonTitle;
	}
	[button setTitle:buttonTitle forStates:UIControlStateNormal];
	[button addTarget:self action:@selector(saveServer:) forControlEvents:UIControlEventTouchUpInside];
	
	self.navigationItem.customRightView = button;
	
	// The title changes depending on if we're editing and old server or adding a new one.
	if (self.isNew)
	{
		self.navigationItem.title = kNavItemTitleNew;
	}
	else
	{
		self.navigationItem.title = kNavItemTitleEdit;
	}
	
	// Update cell text field values to match the server info.
	[self updateFieldValues];
}

- (void)updateFieldValues
{
	UICellTextField * cell;
	
	cell = [_cells objectAtIndex:kServerNameCellIndex];
	cell.view.text = [_serverInfo objectForKey:RFB_NAME];
	
	cell = [_cells objectAtIndex:kServerHostCellIndex];
	cell.view.text = [_serverInfo objectForKey:RFB_HOSTANDPORT];
	
	cell = [_cells objectAtIndex:kServerPasswordCellIndex];
	cell.view.text = [_serverInfo objectForKey:RFB_PASSWORD];
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

- (void)saveServer:(id)sender
{
	[self.navigationController popViewControllerAnimated:YES];
}

//! Custom getter implementation. Makes a mutable copy of the @a info argument.
- (void)setServerInfo:(NSDictionary *)info
{
	id temp = _serverInfo;
	_serverInfo = [info mutableCopy];
	[temp release];
}

#pragma mark -Table data source-

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section
{
	return _cells.count;
}

#pragma mark -Table delegate-

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	return [_cells objectAtIndex:indexPath.row];
}

@end
