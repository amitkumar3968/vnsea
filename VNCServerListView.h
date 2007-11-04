//
//  VNCServerListView.h
//  vnsea
//
//  Created by Chris Reed on 9/9/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "ServerBase.h"

//! @brief Style constants for table cell disclosure buttons.
enum _disclosure_style
{
	kDisclosureStyleDefault = 0,
	kDisclosureStyleButton
};

//! @brief Navigation bar button indices.
enum _server_list_navbar_buttons
{
	kNavBarEditButton = 0,
	kNavBarPrefsButton = 1
};

/*!
 * @brief This view manages an editble list of servers.
 */
@interface VNCServerListView : UIView
{
	id _delegate;
	id _navBar;
	id _serverTable;
	id _serverColumn;
	id _buttonBar;
	id _addButton;
	NSArray * _servers;
}

- (void)setDelegate:(id)newDelegate;
- (id)delegate;

- (void)setServerList:(NSArray *)list;

- (void)addNewServer:(id)sender;

@end

@interface VNCServerListView (DelegateMethods)

- (void)serverSelected:(int)serverIndex;

- (void)editServer:(int)serverIndex;

- (void)addNewServer;

- (void)displayPrefs;

@end
