//
//  GameManager.h
//  triviaAppChallenge
//
//  Created by chris warner on 1/22/18.
//  Copyright © 2018 chris warner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Question.h"

@interface GameManager : NSObject

+(instancetype _Nonnull ) sharedInstance;

-(void) fetchQuestionsWithCompletion:(void (^_Nonnull)(NSError * _Nullable error))completionHandler;
-(NSArray *_Nullable) questions;
-(NSArray *_Nullable) results;
-(Question *_Nullable) nextQuestion;
-(BOOL) isFinished;
-(void) updateResultsWithQuestion:(Question *_Nullable)question completion:(void (^_Nullable)(void))completionHandler;
@end
