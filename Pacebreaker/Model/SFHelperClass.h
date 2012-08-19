//
//  SFHelperClass.h
//  OfficeHaus
//
//  Created by Steffen Frost on 2012 06 09.
//  Copyright (c) 2012 Carticipate, Inc. All rights reserved.
//
// From http://www.youtube.com/watch?v=fX5WRzhJXAo&feature=channel&list=UL,
// Making NSLog cooler and better.  Will show the class, method, and line number the log gets called from.
// 

#import <Foundation/Foundation.h>

#define NSLog(format, ...) NoLog([NSString stringWithFormat:@"<%@> [%@] (Line %d): %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), __LINE__, format], ##__VA_ARGS__)

@interface SFHelperClass : NSObject

// C function declaration
void MyLog(NSString *format, ...);
void NoLog(NSString *format, ...);

@end
