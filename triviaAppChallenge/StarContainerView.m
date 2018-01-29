//
//  StarContainerView.m
//  triviaAppChallenge
//
//  Created by chris warner on 1/22/18.
//  Copyright © 2018 chris warner. All rights reserved.
//

#import "StarContainerView.h"

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


@implementation StarContainerView

-(void) setLevel:(NSInteger)level
{
    for (UIImageView *imageView in self.starImageViewArray)
    {
        NSString *imageName = @"LevelStarIconOff";
        NSInteger tag = imageView.tag;
        if (tag < level)
            imageName = @"LevelStarIcon";

        [imageView setImage:[UIImage imageNamed:imageName]];
    }
}

@end
