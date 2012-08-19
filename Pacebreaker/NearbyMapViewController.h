//
//  NearbyMapViewController.h
//  Pacebreaker
//
//  Created by Nicholas on 8/18/12.
//  Copyright (c) 2012 Nicholas. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>

@interface NearbyMapViewController : UIViewController<MKMapViewDelegate>
{
IBOutlet UITextField *addressField;
IBOutlet UIButton *goButton;
IBOutlet MKMapView *mapView;
}

@property NSMutableArray *events;

@end
