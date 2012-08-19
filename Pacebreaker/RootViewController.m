//
//  RootViewController.m
//  Pacebreaker
//
//  Created by Nicholas on 8/18/12.
//  Copyright (c) 2012 Nicholas. All rights reserved.
//

#import "RootViewController.h"

#import "BrowseTabBarController.h"

@interface RootViewController ()
@property (          strong, nonatomic) SocketIO        *socketIO;
@end

@implementation RootViewController
@synthesize socketIO        = _socketIO;

- (void)viewDidLoad
{
    [super viewDidLoad];

    BrowseTabBarController *browseViewController = [[BrowseTabBarController alloc] init];
    
    [self addChildViewController:browseViewController];
    [self.view addSubview:browseViewController.view];
    
    self.socketIO = [[SocketIO alloc] initWithDelegate:self];
    self.socketIO.useSecure = NO;
    [self.socketIO connectToHost:@"localhost" onPort:3000];
}

- (void) socketIODidConnect:(SocketIO *)socket{
    NSLog(@"We connected....");
    [self.socketIO sendMessage:@"Hello Pace Breaker"];
}

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSLog(@"didReceiveEvent()");
    
    SocketIOCallback cb = ^(id argsData) {
        NSDictionary *response = argsData;
        // do something with response
        NSLog(@"ack arrived: %@", response);
    };
    [self.socketIO sendMessage:@"hello back!" withAcknowledge:cb];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
