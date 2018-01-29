//
//  Answer.m
//  triviaAppChallenge
//
//  Created by chris warner on 1/22/18.
//  Copyright © 2018 chris warner. All rights reserved.
//

#import "Answer.h"
#import "NSString+(Util).h"

@interface Answer ()
@property (nonatomic, strong) NSString *answer;
@property (nonatomic, assign) BOOL correct;
@end
@implementation Answer

-(instancetype) initWithAnswer:(NSString *)answer correct:(BOOL)correctAnswer
{
    self = [super init];
    if (self) {
        self.answer = answer;
        self.correct = correctAnswer;
    }
    return self;
}

-(BOOL) isCorrect
{
    return _correct;
}

-(NSString *) text
{
    return [_answer decodeHTMLString];
}

@end
