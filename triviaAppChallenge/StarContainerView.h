//
//  StarContainerView.h
//  triviaAppChallenge
//
//  Created by chris warner on 1/22/18.
//  Copyright © 2018 chris warner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StarContainerView : UIView
@property (nonatomic) IBOutletCollection(id) NSArray *starImageViewArray;
-(void) setLevel:(NSInteger)level;
@end
