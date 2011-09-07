//
//  BadgerLargerAppDelegate.h
//  BadgerLarger
//
//  Created by Stefan Church on 04/09/2011.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BadgerLargerViewController;

@interface BadgerLargerAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet BadgerLargerViewController *viewController;

@end
