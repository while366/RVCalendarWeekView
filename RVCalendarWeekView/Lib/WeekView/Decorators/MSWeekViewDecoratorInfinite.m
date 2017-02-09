//
//  MSWeekViewDecoratorInfinite.m
//  RVCalendarWeekView
//
//  Created by Badchoice on 1/9/16.
//  Copyright © 2016 revo. All rights reserved.
//

#import "MSWeekViewDecoratorInfinite.h"
#import "NSDate+Easy.h"

#define DAYS_TO_LOAD 30
@interface MSWeekView()
    -(void)groupEventsByDays;
@end

@implementation MSWeekViewDecoratorInfinite

+(__kindof MSWeekView*)makeWith:(MSWeekView*)weekView andDelegate:(id<MSWeekViewInfiniteDelegate>)delegate{
    MSWeekViewDecoratorInfinite * weekViewDecorator = [super makeWith:weekView];
    weekViewDecorator.infiniteDelegate = delegate;
    return weekViewDecorator;
}

//======================================================
#pragma mark - INFINITE SCROLL
//======================================================
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [super scrollViewDidScroll:scrollView];

    NSInteger currentOffset = scrollView.contentOffset.x;
    NSInteger maximumOffset = scrollView.contentSize.width - scrollView.frame.size.width;
//    NSInteger minimumOffset = - scrollView.contentSize.width / 2 - scrollView.frame.size.width;
    // Change 10.0 to adjust the distance from side
    if (maximumOffset - currentOffset <= 10.0 && !mLoading /*&& mShouldLoadMore*/) {
        //NSLog(@"Load more if necessary");
        [self loadNextDays];
    }
    if (currentOffset <= 100 && !mLoading) {
        [self loadPreviousDays];
    }
}

-(void)loadPreviousDays {
    mLoading = true;
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSDate * startDate  = [self.baseWeekView.firstDay addDays:-5];
        NSDate * endDate    = self.baseWeekView.firstDay;
        self.baseWeekView.daysToShow += 5;
        if(self.infiniteDelegate){
            if(![self.infiniteDelegate weekView:self.baseWeekView newDaysLoaded:startDate to:endDate]){
                [self.baseWeekView reloadWhenSwipe:false];
            }
        }
        else {
            [self.baseWeekView reloadWhenSwipe:false];
        }
        mLoading = false;
    });
}

-(void)loadNextDays{
    mLoading = true;
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSDate * startDate  = [[self.baseWeekView.firstDay   addDays:self.baseWeekView.daysToShow + 1] addDays: 5];
        NSDate * endDate    = [startDate                    addDays:5                 - 1];
        self.baseWeekView.daysToShow += 5;
        if(self.infiniteDelegate){
            if(![self.infiniteDelegate weekView:self.baseWeekView newDaysLoaded:startDate to:endDate]){
                [self.baseWeekView reloadWhenSwipe:true];
            }
        }
        else {
            [self.baseWeekView reloadWhenSwipe:true];
        }
        mLoading = false;
    });    
}


@end
