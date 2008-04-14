//
//  VNCServerInfoViewController.h
//  vnsea
//
//  Created by Chris Reed on 4/6/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UICellTextField.h"

//! Indices for the table cells.
enum
{
	kServerNameCellIndex = 0,
	kServerHostCellIndex,
	kServerPasswordCellIndex
};

/*!
 * @brief Manages a view to edit VNC server attributes.
 */
@interface VNCServerInfoViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, EditableTableViewCellDelegate>
{
	BOOL _isNew;				//!< True if adding a new server.
	UITableView * _tableView;	//!< The preferences-style table view owned by this controller.
	int _serverIndex;			//!< Index of server being edited.
	NSMutableDictionary * _serverInfo;	//!< Information about the server being edited.
	NSArray * _cells;			//!< Array of table cells for each edit field.
}

@property(nonatomic, retain) UITableView * tableView;
@property(assign) BOOL isNew;
@property(assign) int serverIndex;
@property(nonatomic, copy) NSDictionary * serverInfo;

- (void)saveServer:(id)sender;

- (void)updateFieldValues;

@end
