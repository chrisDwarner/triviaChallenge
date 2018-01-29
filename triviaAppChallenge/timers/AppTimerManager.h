//
//  AppTimerManager.h
//  triviaAppChallenge
//
//  Created by chris warner on 1/21/18.
//  Copyright © 2018 chris warner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppTimerManager : NSObject

+ (instancetype)sharedManager;

-(void) launchTimerForEventType:(SeatNotificationType)type withRunMode:(NSString *)runMode;
-(NSTimer *) getTimerForEvent:(SeatNotificationType)type;
-(BOOL)isTimerActiveForType:(SeatNotificationType)type;
-(void)stopTimerForEvent:(SeatNotificationType)type;
-(void)stopAllTimerEvents;
@end
