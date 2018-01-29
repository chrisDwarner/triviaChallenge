//
//  Question.m
//  triviaAppChallenge
//
//  Created by chris warner on 1/21/18.
//  Copyright © 2018 chris warner. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Question.h"
#import "Answer.h"
#import "NSString+(Util).h"

@interface Question ()
@property (nonatomic, strong) NSDictionary *info;
@property (nonatomic, strong) Answer *selectedAnswer;

@end

@implementation Question

-(instancetype) initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.info = [NSDictionary dictionaryWithDictionary:dict];
    }

    return self;
}

-(NSString *) question
{
    NSString *value = [self.info objectForKey:@"question"];
    if (value && [value isKindOfClass:[NSNull class]]) {
        value = nil;
    }
    else {
        NSString *decoded = [value decodeHTMLString];
        value = decoded;
    }
    return value;

}

-(NSString *) category
{
    NSString *value = [self.info objectForKey:@"category"];
    if (value && [value isKindOfClass:[NSNull class]]) {
        value = nil;
    }
    return value;
}

-(NSString *) type
{
    NSString *value = [self.info objectForKey:@"type"];
    if (value && [value isKindOfClass:[NSNull class]]) {
        value = nil;
    }
    return value;
}

-(Answer *) correctAnswer
{
    NSString *value = [self.info objectForKey:@"correct_answer"];
    if (value && [value isKindOfClass:[NSNull class]]) {
        value = nil;
    }
    if (value) {
        Answer *answer = [[Answer alloc] initWithAnswer:value correct:YES];
        return answer;
    }
    return nil;
}

-(NSString *) difficulty
{
    NSString *value = [self.info objectForKey:@"difficulty"];
    if (value && [value isKindOfClass:[NSNull class]]) {
        value = nil;
    }
    return value;
}

-(NSArray *) answers
{
    // put all the answers into a Set
    NSMutableSet *set = [[NSMutableSet alloc] init];

    // get the incorrect answers
    NSArray *array = [self.info objectForKey:@"incorrect_answers"];
    if (array) {
        NSMutableArray *results = [[NSMutableArray alloc] init];
        for (NSString *text in array) {
            Answer *answer = [[Answer alloc] initWithAnswer:text correct:NO];
            [results addObject:answer];
        }
        [set addObjectsFromArray:results];
    }
    // get the correct answer
    Answer *correct = [self correctAnswer];

    [set addObject:correct];

    // now get the array of values in some order
    if (set.count) {
        array = [set allObjects];
        return array;
    }
    return nil;
}

-(void) selectAnswer:(Answer *)answer
{
    _selectedAnswer = answer;
}

-(BOOL) isCorrect
{
    if (_selectedAnswer) {
        BOOL value = _selectedAnswer.isCorrect;
        return value;
    }
    return NO;
}
@end
