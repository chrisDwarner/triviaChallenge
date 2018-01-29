//
//  Question.h
//  triviaAppChallenge
//
//  Created by chris warner on 1/21/18.
//  Copyright © 2018 chris warner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Answer.h"

@interface Question : NSObject

-(instancetype) initWithDict:(NSDictionary *)dict;
-(NSString *) question;
-(NSString *) category;
-(NSString *) type;
-(Answer *) correctAnswer;
-(NSString *) difficulty;
-(NSArray *) answers;

-(void) selectAnswer:(Answer *)answer;
-(BOOL) isCorrect;
@end
