//
//  ViewController.m
//  triviaAppChallenge
//
//  Created by chris warner on 1/21/18.
//  Copyright © 2018 chris warner. All rights reserved.
//

#import "ViewController.h"
#import "GameManager.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *beginButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    CABasicAnimation  *anim = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.duration = 0.25;
    anim.repeatCount = HUGE_VALF;
    anim.autoreverses = YES;
    anim.fromValue = [NSNumber numberWithFloat:1.0];
    anim.toValue = [NSNumber numberWithFloat:1.10];
    [self.beginButton.layer addAnimation:anim forKey:@"transform.scale"];
}

-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_beginButton.layer removeAnimationForKey:@"transform.scale"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)beginButtonAction:(id)sender {
    [_beginButton.layer removeAnimationForKey:@"transform.scale"];

    GameManager *manager = [GameManager sharedInstance];

    if (manager) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        });
        [manager fetchQuestionsWithCompletion:^(NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            });

            if (!error) {
                [self performSegueWithIdentifier:@"startQuizSegue" sender:sender];
            }
            else {
                // todo: show alert on error.
            }
        }];
    }
}


- (IBAction)unwindRestartQuiz:(UIStoryboardSegue *)unwindSegue
{
}

@end
