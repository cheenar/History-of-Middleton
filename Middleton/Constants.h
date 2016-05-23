//
//  Constants.h
//  Middleton
//
//  Created by cheenar gupte on 5/23/16.
//  Copyright © 2016 CBAJV. All rights reserved.
//

#import <Foundation/Foundation.h>

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

@end
