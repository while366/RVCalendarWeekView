//
//  AKEvent.h
//  Example
//
//  Created by ak on 18.01.2016.
//  Copyright © 2016 Eric Horacek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DateTools/DTTimePeriod.h>
#import <UIKit/UIKit.h>

@interface MSEvent : DTTimePeriod

@property (nonatomic, strong) NSString  *title;
@property (nonatomic, strong) NSString  *location;
@property (nonatomic, strong) UIImage  *image;

+(instancetype)make:(NSDate*)start title:(NSString*)title subtitle:(NSString*)subtitle image:(UIImage*)image;
+(instancetype)make:(NSDate*)start end:(NSDate*)end title:(NSString*)title subtitle:(NSString*)subtitle image:(UIImage*)image;

+(instancetype)make:(NSDate*)start duration:(int)minutes title:(NSString*)title subtitle:(NSString*)subtitle image:(UIImage*)image;

- (NSDate *)day;

@end
