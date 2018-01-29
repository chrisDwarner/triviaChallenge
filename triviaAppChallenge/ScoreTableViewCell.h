//
//  ScoreTableViewCell.h
//  triviaAppChallenge
//
//  Created by chris warner on 1/23/18.
//  Copyright © 2018 chris warner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ScoreTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
@property (weak, nonatomic) IBOutlet UILabel *questionLabel;

@end
