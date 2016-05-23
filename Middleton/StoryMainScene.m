//
//  StoryMainScene.m
//  Middleton
//
//  Created by cheenar gupte on 5/23/16.
//  Copyright © 2016 CBAJV. All rights reserved.
//

#import "StoryMainScene.h"

@implementation StoryMainScene

-(id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if(self)
    {
        [self setupBackground:@"background_middleton_ledge"];
        [self setupCharacter:@"mryoung_trans" withScale:.34];
        [self setCharacterPosition:LEFT];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view
{
}

@end
