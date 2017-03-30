//
//  CustomLabel.m
//  RVCalendarWeekView
//
//  Created by Leonid on 30.03.17.
//  Copyright © 2017 revo. All rights reserved.
//

#import "CustomLabel.h"

@implementation CustomLabel

-(void)drawTextInRect:(CGRect)rect {
    if ([self attributedText] == nil) {
        [super drawTextInRect:rect];
    }
    NSOperatingSystemVersion ios10_3_0 = (NSOperatingSystemVersion){10,0,3};
    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion: ios10_3_0]) {
        [[self attributedText] drawInRect:rect];
    } else {
        [super drawTextInRect:rect];
    }
}

@end
