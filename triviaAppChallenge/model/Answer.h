//
//  Answer.h
//  triviaAppChallenge
//
//  Created by chris warner on 1/22/18.
//  Copyright © 2018 chris warner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Answer : NSObject

-(instancetype) initWithAnswer:(NSString *)answer correct:(BOOL)correctAnswer;
-(BOOL) isCorrect;
-(NSString *) text;
@end
