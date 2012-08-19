//
//  DetailViewController.h
//  navigationapp
//
//  Created by Nicholas on 8/19/12.
//  Copyright (c) 2012 Nicholas. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
