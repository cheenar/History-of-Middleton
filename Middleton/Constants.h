//
//  Constants.h
//  Middleton
//
//  Created by cheenar gupte on 5/23/16.
//  Copyright © 2016 CBAJV. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#define RM
#define COLOR(r,g,b,a) [SKColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

typedef enum _Guides
{
    MR_YOUNG,
    MS_MOORE,
    MS_SCOTT,
    BRIAN
}Guides;

@interface Constants : NSObject
{
}

@property NSString *playerName;
@property NSString *tourGuideName;
@property NSString *tourGuideImage;

+(Constants *) constants;

-(void)debug;

@end
