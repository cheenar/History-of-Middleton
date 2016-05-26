//
//  Constants.m
//  Middleton
//
//  Created by cheenar gupte on 5/23/16.
//  Copyright © 2016 CBAJV. All rights reserved.
//

#import "Constants.h"

@implementation Constants
@synthesize playerName, tourGuideName, tourGuideImage;

//i_vars
Constants *_constants;

//accessor
+(Constants *)constants
{
    if(_constants == nil)
    {
        _constants = [[Constants alloc] init];
    }
    return _constants;
}

-(id)init
{
    self = [super init];
    if(self)
    {
        
    }
    return self;
}


-(void)debug
{
    NSLog(@"constants");
}

@end
