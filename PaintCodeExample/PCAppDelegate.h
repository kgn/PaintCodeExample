//
//  PCAppDelegate.h
//  PaintCodeExample
//
//  Created by David Keegan on 3/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PCViewController;

@interface PCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) PCViewController *viewController;

@end
