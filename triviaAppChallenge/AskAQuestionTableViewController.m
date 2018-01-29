//
//  AskAQuestionTableViewController.m
//  triviaAppChallenge
//
//  Created by chris warner on 1/22/18.
//  Copyright © 2018 chris warner. All rights reserved.
//

#import "AskAQuestionTableViewController.h"
#import "Question.h"
#import "Answer.h"
#import "GameManager.h"
#import "QuestionHeaderView.h"
#import "AnswerTableViewCell.h"


static NSString *SectionHeaderViewIdentifier = @"SectionHeaderViewIdentifier";

@interface AskAQuestionTableViewController ()
@property (nonatomic, strong) Question *question;
@property (nonatomic, strong) NSArray *answers;
@end

@implementation AskAQuestionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    _question = [[GameManager sharedInstance] nextQuestion];

    if (_question) {
        // only want to do this once
        _answers = [_question answers];
    }

    UINib *sectionHeaderNib = [UINib nibWithNibName:@"QuestionHeaderView" bundle:nil];
    [self.tableView registerNib:sectionHeaderNib forHeaderFooterViewReuseIdentifier:SectionHeaderViewIdentifier];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_answers count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 254.0;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_question) {
        if (![_question.type isEqualToString:@"boolean"]) {
            return 70.0;
        }
    }
    return 100.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    QuestionHeaderView *sectionHeaderView = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:SectionHeaderViewIdentifier];

    sectionHeaderView.question.text = _question.question;
    sectionHeaderView.category.text = _question.category;

    if ([_question.difficulty isEqualToString:@"easy"]) {
        [sectionHeaderView.starContainerView setLevel:1];
    }

    if ([_question.difficulty isEqualToString:@"medium"]) {
        [sectionHeaderView.starContainerView setLevel:2];
    }

    if ([_question.difficulty isEqualToString:@"hard"]) {
        [sectionHeaderView.starContainerView setLevel:3];
    }

    if ([_question.difficulty isEqualToString:@"expert"]) {
        [sectionHeaderView.starContainerView setLevel:4];
    }

    return sectionHeaderView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AnswerTableViewCell *cell = (AnswerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"AnswerCellID" forIndexPath:indexPath];
    
    // Configure the cell..
    Answer *answer = [_answers objectAtIndex:indexPath.row];
    cell.answerText.text = answer.text;
    cell.answer = answer;

    if ([_question.type isEqualToString:@"boolean"]) {
        [cell.answerText setTextColor:[UIColor whiteColor]];
        
        if ([answer.text isEqualToString:@"True"]) {
            [cell.answerText setBackgroundColor:[UIColor colorWithRed:0.0 green:(143.0/255.0) blue:0.0 alpha:1]];
        }

        if ([answer.text isEqualToString:@"False"]) {
            [cell.answerText setBackgroundColor:[UIColor colorWithRed:(148.0/255.0) green:(17.0/255.0) blue:0.0 alpha:1]];
        }
    }
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Answer *answer = [_answers objectAtIndex:indexPath.row];
    
    [_question selectAnswer:answer];
    [[GameManager sharedInstance] updateResultsWithQuestion:_question completion:^{
        self.question = [[GameManager sharedInstance] nextQuestion];
        
        if (self.question) {
            // only want to do this once
            self.answers = [self.question answers];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        }
        else {
            if ([[GameManager sharedInstance] isFinished]) {
                [self performSegueWithIdentifier:@"showScoreSegue" sender:self];
            }
        }
    }];
}

@end
