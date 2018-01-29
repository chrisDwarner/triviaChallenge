//
//  ScoreViewController.m
//  triviaAppChallenge
//
//  Created by chris warner on 1/22/18.
//  Copyright © 2018 chris warner. All rights reserved.
//

#import "ScoreViewController.h"
#import "GameManager.h"
#import "ScoreTableViewCell.h"

@interface ScoreViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *questions;

@end

@implementation ScoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    _questions = [[GameManager sharedInstance] results];
    NSInteger correctAnswerCount = 0;

    for (Question *item in _questions) {
        if (item.isCorrect) {
            correctAnswerCount++;
        }
    }
    NSString *score = [NSString stringWithFormat:@"%ld / %ld", correctAnswerCount, [_questions count]];
    _scoreLabel.text = score;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playAgainAction:(id)sender
{
    [self performSegueWithIdentifier:@"restartQuizSegue" sender:sender];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_questions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ScoreTableViewCell *cell = (ScoreTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"questionCell" forIndexPath:indexPath];

    // Configure the cell..
    Question *question = [_questions objectAtIndex:indexPath.row];
    cell.questionLabel.text = question.question;

    if (question.isCorrect) {
        cell.iconView.image = [UIImage imageNamed:@"right"];
    }
    else {
        cell.iconView.image = [UIImage imageNamed:@"wrong"];
    }
    return cell;
}


@end
