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
@property (nonatomic, strong) NSString  *nameText;
@property (nonatomic, strong) UIColor *nameBackgroundColor;

+(instancetype)make:(NSDate*)start title:(NSString*)title subtitle:(NSString*)subtitle image:(UIImage*)image name:(NSString*)name color:(UIColor *)nameBackgroundColor;
+(instancetype)make:(NSDate*)start end:(NSDate*)end title:(NSString*)title subtitle:(NSString*)subtitle image:(UIImage*)image name:(NSString*)name color:(UIColor *)nameBackgroundColor;

+(instancetype)make:(NSDate*)start duration:(int)minutes title:(NSString*)title subtitle:(NSString*)subtitle image:(UIImage*)image name:(NSString*)name color:(UIColor *)nameBackgroundColor;

- (NSDate *)day;

@end
