//
//  RootViewController.h
//  Pacebreaker
//
//  Created by Nicholas on 8/18/12.
//  Copyright (c) 2012 Nicholas. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketIO.h"


@interface RootViewController : UIViewController <UIPageViewControllerDelegate, SocketIODelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

@end
