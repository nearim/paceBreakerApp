//
//  SFHelperClass.m
//  OfficeHaus
//
//  Created by Steffen Frost on 2012 06 09.
//  Copyright (c) 2012 Carticipate, Inc. All rights reserved.
//

#import "SFHelperClass.h"

@implementation SFHelperClass

void MyLog(NSString *format, ...) {
  va_list argumentList;
  va_start(argumentList, format);
  NSLogv(format, argumentList);
  va_end(argumentList);
}

void NoLog(NSString *format, ...) {
  // Do nothing, we are in Production!
}

@end
