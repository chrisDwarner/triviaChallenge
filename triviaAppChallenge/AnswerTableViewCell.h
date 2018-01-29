//
//  AnswerTableViewCell.h
//  triviaAppChallenge
//
//  Created by chris warner on 1/22/18.
//  Copyright © 2018 chris warner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Answer.h"


@interface AnswerTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *answerText;
@property (nonatomic, strong) Answer *answer;
@end
