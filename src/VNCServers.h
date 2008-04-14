//
//  VNCServers.h
//  vnsea
//
//  Created by Chris Reed on 4/6/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ServerInfoDefines.h"

//! Name of the servers data file.
#define kServersFileName @"servers.plist"

//! The top level dictionary key containing the array of server dictionaries in the
//! server settings file.
#define kServerArrayKey @"servers"

//! Top level dictionary key for the file format version.
#define kServerFileVersionKey @"version"

//! Current version of the server file format.
#define kServerFileCurrentVersion (1)

/*!
 * @brief Manages the list of VNC servers.
 */
@interface VNCServers : NSObject
{
	NSString * _documentsDirectory;
	NSMutableArray * _servers;
}

//! @brief Returns the shared singleton object for managing servers.
+ sharedServers;

@property(nonatomic, copy) NSArray * servers;
@property(readonly) unsigned numberOfServers;	//!< The current count of servers.

//! @brief Returns the path to the servers file.
- (NSString *)serversFilePath;

- (void)load;

- (void)save;

- (NSDictionary *)serverAtIndex:(unsigned)index;

//! @brief Will create and add a new server with default settings.
//!
//! @return The index of the new server.
- (unsigned)createNewServer;

@end
