//
//  VNCServers.m
//  vnsea
//
//  Created by Chris Reed on 4/6/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "VNCServers.h"

// Class extension for private methods.
@interface VNCServers ()

- (NSDictionary *)defaultServerInfo;
- (NSString *)serversFilePath;

@end

@implementation VNCServers

@synthesize servers = _servers;

+ sharedServers
{
	static id sharedObject = nil;
	
	if (!sharedObject)
	{
		sharedObject = [[self alloc] init];
	}
	
	return sharedObject;
}

- init
{
	self = [super init];
	if (self)
	{
		NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
		_documentsDirectory = [[paths objectAtIndex:0] retain];
		
		// Go ahead and load the servers file.
		[self load];
		
		
		NSMutableArray * array = [NSMutableArray array];
		
		NSMutableDictionary * dict = (NSMutableDictionary *)[self defaultServerInfo];
		[dict setObject:@"himiko" forKey:RFB_NAME];
		[dict setObject:@"himiko.local" forKey:RFB_HOSTANDPORT];
		[array addObject:dict];
		
		dict = (NSMutableDictionary *)[self defaultServerInfo];
		[dict setObject:@"creed" forKey:RFB_NAME];
		[dict setObject:@"creed.sgtl.sigmatel.com" forKey:RFB_HOSTANDPORT];
		[array addObject:dict];
		
		self.servers = array;
	}
	
	return self;
}

- (void)dealloc
{
	[_documentsDirectory release];
	[_servers release];
	[super dealloc];
}

- (NSDictionary *)defaultServerInfo
{
	NSMutableDictionary * info = [NSMutableDictionary dictionary];
	
	[info setObject:@"" forKey:RFB_NAME];
	[info setObject:@"" forKey:RFB_HOSTANDPORT];
	[info setObject:@"" forKey:RFB_PASSWORD];
	[info setObject:[NSNumber numberWithBool:YES] forKey:RFB_REMEMBER];
	[info setObject:[NSNumber numberWithInt:0] forKey:RFB_DISPLAY];
	[info setObject:@"Default" forKey:RFB_LAST_PROFILE];
	[info setObject:[NSNumber numberWithBool:NO] forKey:RFB_SHARED];
	[info setObject:[NSNumber numberWithInt:16] forKey:RFB_PIXEL_DEPTH];
	[info setObject:[NSNumber numberWithBool:NO] forKey:RFB_FULLSCREEN];
	[info setObject:[NSNumber numberWithBool:NO] forKey:RFB_VIEWONLY];
	return info;
}

//! @brief Customer setter for the @c servers property that makes a mutable copy.
- (void)setServers:(NSArray *)theServers
{
	NSMutableArray * temp = _servers;
	_servers = [theServers mutableCopy];
	[temp release];
}

- (NSString *)serversFilePath
{
	return [_documentsDirectory stringByAppendingPathExtension:kServersFileName];
}

- (unsigned)numberOfServers
{
	return [_servers count];
}

- (void)load
{
	NSDictionary * dict = [NSDictionary dictionaryWithContentsOfFile:[self serversFilePath]];
	
	// The result will be nil if there was an error such as a missing file.
	if (dict == nil)
	{
		self.servers = [NSArray array];
	}
	else
	{
		// Check file format version
		int formatVersion = [[dict objectForKey:kServerFileVersionKey] intValue];

		if (formatVersion != kServerFileCurrentVersion)
		{
			// Unrecognised version, so throw everything away.
			self.servers = [NSArray array];
		}

		// Save off the array of servers from the file.
		self.servers = [dict objectForKey:kServerArrayKey];
	}
}

- (void)save
{
	NSDictionary * dict = [NSDictionary dictionaryWithObjectsAndKeys:
							_servers, kServerArrayKey,
							[NSNumber numberWithInt:kServerFileCurrentVersion], kServerFileVersionKey];
	[dict writeToFile:[self serversFilePath] atomically:YES];
}

- (NSDictionary *)serverAtIndex:(unsigned)index
{
	return [_servers objectAtIndex:index];
}

- (unsigned)createNewServer
{
	NSDictionary * newServer = [self defaultServerInfo];
	int count = _servers.count;
	[_servers addObject:newServer];
	return count;
}

@end
