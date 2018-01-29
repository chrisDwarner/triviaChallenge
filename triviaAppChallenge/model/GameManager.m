//
//  GameManager.m
//  triviaAppChallenge
//
//  Created by chris warner on 1/22/18.
//  Copyright © 2018 chris warner. All rights reserved.
//

#import "GameManager.h"
#import "Question.h"

@interface GameManager ()
@property (nonatomic, strong) NSArray *listOfQuestions;
@property (nonatomic, assign) NSUInteger currentQuestionIndex;
@property (nonatomic, strong) NSMutableArray *results;
@end

@implementation GameManager

+(instancetype) sharedInstance
{
    static id shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[self alloc] init];
    });
    return shared;
}

-(void) fetchQuestionsWithCompletion:(void (^_Nonnull)(NSError * _Nullable error))completionHandler
{
    // download the questions, then launch the quiz
    // todo: add options to control difficulty and question type.
    // The code can handle multiple choice or boolean questions by design.
//    NSString *stringUrl = @"https://opentdb.com/api.php?amount=10&difficulty=hard&type=boolean";
    NSString *stringUrl = @"https://opentdb.com/api.php?amount=10&type=boolean";
    NSURL *url = [NSURL URLWithString:stringUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];


    if (request) {
        NSURLSession *session = [NSURLSession sharedSession];

        [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];

        NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                NSLog(@"doh %@", error.localizedDescription);
            }
            else {
                if (location) {
                    NSData *data = [NSData dataWithContentsOfURL:location];
                    if (data) {
                        NSString *payload = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];

                        NSLog(@"%@", payload);

                        NSDictionary *container = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
                        if (container) {
                            NSArray *array = [container valueForKey:@"results"];
                            if (array.count) {
                                NSLog(@"%ld questions downloaded", [array count]);
                                NSMutableArray *results = [[NSMutableArray alloc] init];
                                // collect the list of dictionaries and put them into question objects
                                for (NSDictionary *dict in array) {
                                    Question *question = [[Question alloc] initWithDict:dict];
                                    if (question) {
                                        [results addObject:question];
                                    }
                                }

                                // store the list for later 
                                _listOfQuestions = results;
                                _currentQuestionIndex = 0;
                                _results = [NSMutableArray new];
                            }
                        }
                    }
                }
            }
            if (completionHandler) {
                completionHandler(error);
            }
        }];
        
        [downloadTask resume];
    }
}

-(NSArray *) questions
{
    return _listOfQuestions;
}

-(NSArray *_Nullable) results
{
    return _results;
}

-(Question *_Nullable) nextQuestion
{
    Question *question = nil;

    if (_listOfQuestions) {
        if (_currentQuestionIndex < _listOfQuestions.count) {
            question = [_listOfQuestions objectAtIndex:_currentQuestionIndex];
            _currentQuestionIndex++;
        }
    }

    return question;
}

-(BOOL) isFinished
{
    BOOL isFini = NO;

    if (_listOfQuestions) {
        if (_currentQuestionIndex >= _listOfQuestions.count) {
            isFini = YES;
        }
    }
    return isFini;
}

-(void) updateResultsWithQuestion:(Question *_Nullable)question completion:(void (^_Nullable)(void))completionHandler;
{
    [_results addObject:question];
    
    if (completionHandler) {
        completionHandler();
    }
}

@end
