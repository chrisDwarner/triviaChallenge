//
//  AppTimerManager.m
//  triviaAppChallenge
//
//  Created by chris warner on 1/21/18.
//  Copyright © 2018 chris warner. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "AppTimerManager.h"
#import "AppEventObject.h"


@interface AppTimerManager ()

@property (nonatomic, strong) NSMutableDictionary *timerDict;
@end

@implementation AppTimerManager

+ (instancetype)sharedManager
{
    static AppTimerManager *sharedAppTimerManager = nil;
    static dispatch_once_t onceToken = 0;
    dispatch_once(&onceToken, ^{
        sharedAppTimerManager = [[self alloc] init];
    });
    return sharedAppTimerManager;
}

-(instancetype)init
{
    self = [super init];
    if (self != nil) {
        _timerDict  = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void) dealloc
{
    [self stopAllTimerEvents];
}

-(void) launchTimerForEventType:(SeatNotificationType)type withRunMode:(NSString *)runMode
{
    AppEventObject *eventObj = [[AppEventObject alloc ] initWithEvent:type];

    if (eventObj) {
        NSString *key = [NSString stringWithFormat:@"%d", type ];
        [_timerDict setObject:eventObj forKey:key];
    }
}

-(NSTimer *) getTimerForEvent:(SeatNotificationType)type
{
    AppEventObject *eventObj = nil;
    eventObj = (AppEventObject *)[_timerDict objectForKey:[NSString stringWithFormat:@"%d", type ]];
    return eventObj.timer;
}

-(BOOL)isTimerActiveForType:(SeatNotificationType)type
{
    AppEventObject *eventObj = nil;
    eventObj = (AppEventObject *)[_timerDict objectForKey:[NSString stringWithFormat:@"%d", type ]];
    return (eventObj != nil);
}

-(void)stopTimerForEvent:(SeatNotificationType)type
{
    AppEventObject *eventObj = nil;
    eventObj = (AppEventObject *)[_timerDict objectForKey:[NSString stringWithFormat:@"%d", type ]];

    if (eventObj != nil) {
        [eventObj invalidate];
    }
    [_timerDict removeObjectForKey:[NSString stringWithFormat:@"%d", type ]];
}

-(void)stopAllTimerEvents
{
    [[_timerDict allValues] makeObjectsPerformSelector:@selector(invalidate)];
    [_timerDict removeAllObjects];
}

@end
