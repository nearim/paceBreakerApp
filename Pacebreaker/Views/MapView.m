//
//  MapViewController.m
//
//  Created by kadir pekel on 2/7/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MapView.h"


#define spanFactor 1.0

@interface MapView()

-(NSMutableArray *)decodePolyLine: (NSMutableString *)encoded;
-(void) updateRouteView;
-(NSArray*) calculateRoutesFrom:(CLLocationCoordinate2D) from to: (CLLocationCoordinate2D) to;
-(void) centerMap;

@end
@implementation MapView
@synthesize lineColor;
@synthesize mapView;

- (id) initWithFrame:(CGRect) frame
{
	self = [super initWithFrame:frame];
	if (self != nil) {
		self.mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-40)];
    mapView.mapType           = MKMapTypeStandard;
    mapView.scrollEnabled     = YES;
    mapView.zoomEnabled       = YES;
		mapView.showsUserLocation = YES;
		mapView.delegate          = self;
    NSLog(@"MapView view count b4    map added: %i", self.subviews.count);
		[self addSubview:mapView];
    NSLog(@"MapView view count after map added: %i", self.subviews.count);

		routeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, mapView.frame.size.width, mapView.frame.size.height)];
		routeView.userInteractionEnabled = NO;
    NSLog(@"MapView view count b4    rts added: %i", self.subviews.count);
		[mapView addSubview:routeView];
    NSLog(@"MapView view count after rts added: %i", self.subviews.count);
		
		self.lineColor = [UIColor colorWithWhite:0.2 alpha:0.5];
	}
	return self;
}

-(NSMutableArray *)decodePolyLine: (NSMutableString *)encoded {
	[encoded replaceOccurrencesOfString:@"\\\\" withString:@"\\"
								options:NSLiteralSearch
								  range:NSMakeRange(0, [encoded length])];
	NSInteger len = [encoded length];
	NSInteger index = 0;
	NSMutableArray *array = [[NSMutableArray alloc] init];
	NSInteger lat = 0;
	NSInteger lng = 0;
  
	while (index < len) {
		NSInteger b;
		NSInteger shift  = 0;
		NSInteger result = 0;
    
		do {
			b = [encoded characterAtIndex:index++] - 63;
			result |= (b & 0x1f) << shift;
			shift  += 5;
      
		} while (b >= 0x20);
    
		NSInteger dlat = ((result & 1) ? ~(result >> 1) : (result >> 1));
		lat += dlat;
		shift = 0;
		result = 0;
		
    do {
			b = [encoded characterAtIndex:index++] - 63;
			result |= (b & 0x1f) << shift;
			shift += 5;
		} while (b >= 0x20);
		
    NSInteger dlng = ((result & 1) ? ~(result >> 1) : (result >> 1));
		lng += dlng;
		NSNumber *latitude  = [[NSNumber alloc] initWithFloat:lat * 1e-5];
		NSNumber *longitude = [[NSNumber alloc] initWithFloat:lng * 1e-5];
		printf("[%f,", [latitude doubleValue]);
		printf("%f]", [longitude doubleValue]);
		CLLocation *loc = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
		[array addObject:loc];
	}
	
	return array;
}

-(NSArray*) calculateRoutesFrom:(CLLocationCoordinate2D) f to: (CLLocationCoordinate2D) t {
	NSString* saddr = [NSString stringWithFormat:@"%f,%f", f.latitude, f.longitude];
	NSString* daddr = [NSString stringWithFormat:@"%f,%f", t.latitude, t.longitude];
	
	NSString *apiUrlStr = [NSString stringWithFormat:@"http://maps.google.com/maps?output=dragdir&saddr=%@&daddr=%@", saddr, daddr];
	NSURL    *apiUrl    = [NSURL URLWithString:apiUrlStr];
	NSLog(@"api url: %@", apiUrl);
  NSError  *apiError;
	NSString *apiResponse   = [NSString stringWithContentsOfURL:apiUrl encoding:NSUTF8StringEncoding error:&apiError];
	NSString *encodedPoints = [apiResponse stringByMatching:@"points:\\\"([^\\\"]*)\\\"" capture:1L];
  NSLog(@"encodedPoints: %@", encodedPoints);
  
	return [self decodePolyLine:[encodedPoints mutableCopy]];
}

-(void) centerMap {
	MKCoordinateRegion region;

	CLLocationDegrees maxLat = -90;
	CLLocationDegrees maxLon = -180;
	CLLocationDegrees minLat = 90;
	CLLocationDegrees minLon = 180;
  
	for(int idx = 0; idx < routes.count; idx++)
	{
		CLLocation* currentLocation = [routes objectAtIndex:idx];
		if(currentLocation.coordinate.latitude  > maxLat) {
			maxLat = currentLocation.coordinate.latitude;
    }
		if(currentLocation.coordinate.latitude  < minLat) {
			minLat = currentLocation.coordinate.latitude;
    }
		if(currentLocation.coordinate.longitude > maxLon) {
			maxLon = currentLocation.coordinate.longitude;
    }
		if(currentLocation.coordinate.longitude < minLon) {
			minLon = currentLocation.coordinate.longitude;
    }
	}
	region.center.latitude     = (maxLat + minLat) / 2;
	region.center.longitude    = (maxLon + minLon) / 2;
	region.span.latitudeDelta  = (maxLat - minLat)    ;
	region.span.longitudeDelta = (maxLon - minLon)    ;
  
  // Determine coefficients for calculating mapSpan
  double listenRadiusMeters = 1000;	// 1 km
  double metersPerDegLat	  = 111000;	
  double metersPerDegLon	  = 111000 * cos ( ((2*M_PI)/360) * wayPointCoordinate.latitude );  	
  
  // Calculate mapSpan
  MKCoordinateSpan mapSpan;
  mapSpan.latitudeDelta	  = ((listenRadiusMeters / metersPerDegLat) * spanFactor); // ( (km / 111 km per degree) * 120% coefficient)
  mapSpan.longitudeDelta	= ((listenRadiusMeters / metersPerDegLon) * spanFactor);
  
  // Zoom down to with small mapRegion
  MKCoordinateRegion mapRegion;
  mapRegion.span	 = mapSpan;
  mapRegion.center = wayPointCoordinate;
	
//[mapView setRegion:region animated:YES];
  [mapView setRegion:mapRegion animated:YES];

}

-(void) showRouteFrom: (WayPoint*) f to:(WayPoint*) t {
	
    if(routes) {
        //[mapView removeAnnotations:[mapView annotations]];
    }

    WayPointAnnotation* from = [[WayPointAnnotation alloc] initWithWayPoint:f];
    WayPointAnnotation* to   = [[WayPointAnnotation alloc] initWithWayPoint:t];

    // Added by Steffen
    wayPointCoordinate = to.coordinate;

    [mapView addAnnotation:from];
    [mapView addAnnotation:to];

    routes = [self calculateRoutesFrom:from.coordinate to:to.coordinate];

    [self updateRouteView];
    [self centerMap];
}

-(void) updateRouteView {
	CGContextRef context = 	CGBitmapContextCreate(nil, 
												  routeView.frame.size.width, 
												  routeView.frame.size.height, 
												  8, 
												  4 * routeView.frame.size.width,
												  CGColorSpaceCreateDeviceRGB(),
												  kCGImageAlphaPremultipliedLast);
	
	CGContextSetStrokeColorWithColor(context, lineColor.CGColor);
	CGContextSetRGBFillColor        (context, 0.0, 0.0, 1.0, 1.0);
	CGContextSetLineWidth           (context, 3.0);
	
	for(int i = 0; i < routes.count; i++) {
		CLLocation* location = [routes objectAtIndex:i];
		CGPoint point = [mapView convertCoordinate:location.coordinate toPointToView:routeView];
		
		if(i == 0) {
			CGContextMoveToPoint(context, point.x, routeView.frame.size.height - point.y);
		} else {
			CGContextAddLineToPoint(context, point.x, routeView.frame.size.height - point.y);
		}
	}
	
	CGContextStrokePath(context);
	
	CGImageRef image = CGBitmapContextCreateImage(context);
	UIImage* img = [UIImage imageWithCGImage:image];
	
	routeView.image = img;
	CGContextRelease(context);

}

#pragma mark mapView delegate functions
- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated
{
	routeView.hidden = YES;
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
	[self updateRouteView];
	routeView.hidden = NO;
	[routeView setNeedsDisplay];
}


@end
