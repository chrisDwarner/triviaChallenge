//
//  QuestionHeaderView.h
//  triviaAppChallenge
//
//  Created by chris warner on 1/22/18.
//  Copyright © 2018 chris warner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarContainerView.h"

@interface QuestionHeaderView : UITableViewHeaderFooterView
@property (weak, nonatomic) IBOutlet UILabel *category;
@property (weak, nonatomic) IBOutlet UILabel *question;
@property (nonatomic) IBOutlet StarContainerView *starContainerView;

@end
