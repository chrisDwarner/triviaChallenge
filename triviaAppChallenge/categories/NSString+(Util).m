//
//  NSString+(Util).m
//  triviaAppChallenge
//
//  Created by chris warner on 1/22/18.
//  Copyright © 2018 chris warner. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSString+(Util).h"


@implementation NSString (Util)

-(NSString *) decodeHTMLString
{
    NSString *value = nil;
    NSData* stringData = [self dataUsingEncoding:NSUTF8StringEncoding];
    if (stringData) {
        NSDictionary* options = @{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType};
        NSAttributedString* decodedAttributedString = [[NSAttributedString alloc] initWithData:stringData options:options documentAttributes:NULL error:NULL];
        NSString* decodedString = [decodedAttributedString string];
        value = decodedString;
    }
    
    return value;
}
@end
