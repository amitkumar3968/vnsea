//
//  VnseaAppDelegate.h
//  vnsea
//
//  Created by Chris Reed on 4/5/08.
//  Copyright __MyCompanyName__ 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 * @brief Application delegate class for vnsea.
 */
@interface VnseaAppDelegate : NSObject
{
	UIWindow * _window;
	UINavigationController * _navController;
//    MyView *contentView;
}

@property (nonatomic, retain) UIWindow * window;
@property (nonatomic, retain) UINavigationController * navController;
//@property (nonatomic, retain) MyView *contentView;

@end
