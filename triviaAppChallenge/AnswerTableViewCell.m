//
//  AnswerTableViewCell.m
//  triviaAppChallenge
//
//  Created by chris warner on 1/22/18.
//  Copyright © 2018 chris warner. All rights reserved.
//

#import "AnswerTableViewCell.h"

@implementation AnswerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _answerText.layer.cornerRadius = 14;
    _answerText.layer.borderColor = [UIColor grayColor].CGColor;
    _answerText.layer.borderWidth = 3;
    _answerText.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
