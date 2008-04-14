//
//  VNCServerListViewController.h
//  vnsea
//
//  Created by Chris Reed on 4/5/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 * @brief View controller class for the main server list view.
 */
@interface VNCServerListViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
	UITableView * _tableView;	//!< The table view controlled by this view controller.
}

@property(nonatomic, retain) UITableView * tableView;

- (void)addServer:(id)sender;

@end
