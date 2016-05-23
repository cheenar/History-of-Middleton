//
//  CGScene.m
//  Middleton
//
//  Created by cheenar gupte on 5/23/16.
//  Copyright © 2016 CBAJV. All rights reserved.
//

#import "CGScene.h"

#define CHARACTER_POS_Y (self.frame.size.height/2)
#define HEIGHT(x) self.frame.size.height/x
#define WIDTH(x) self.frame.size.width/x
#define CENTER MIDDLE

@implementation CGScene
@synthesize characterImage, backgroundImage;

-(void)setupBackground:(NSString *)imageName
{
    backgroundImage = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:imageName]];
    backgroundImage.size = self.frame.size;
    backgroundImage.zPosition = 0;
    backgroundImage.name = @"backgroundImage";
    backgroundImage.position = CGPointMake(WIDTH(2), HEIGHT(2));
    if(![self.children containsObject:backgroundImage])
    {
        [self addChild:backgroundImage];
    }
}

-(void)setupCharacter: (NSString *)characterImageName withScale:(float)scalef
{
    characterImage = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:characterImageName]];
    [characterImage setScale:scalef];
    characterImage.zPosition = 1;
    characterImage.name = @"characterImage";
    [self setCharacterPosition:CENTER];
    if(![self.children containsObject:characterImage])
    {
        [self addChild:characterImage];
    }
}

-(id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if(self)
    {
        //setup the background image
        [self setupBackground:nil];
        //setup the character position;
        [self setupCharacter:nil withScale:1.0];
    }
    return self;
}

-(void)setCharacterPosition:(CharacterPosition)pos
{
    if(characterImage != nil)
    {
        switch(pos)
        {
            case LEFT:
                characterImage.position = CGPointMake(self.frame.size.width / 8, CHARACTER_POS_Y);
                break;
            case RIGHT:
                characterImage.position = CGPointMake((self.frame.size.width) - (self.frame.size.width / 8), CHARACTER_POS_Y);
                break;
            case MIDDLE:
                characterImage.position = CGPointMake(self.frame.size.width/2, CHARACTER_POS_Y);
                break;
            default:
                @throw [NSException exceptionWithName:@"Invalid Position" reason:@"Invalid position fed for character position" userInfo:nil];
                break;
        }
    }
    else
    {
        @throw [NSException exceptionWithName:@"Character Not Initialized" reason:@"Character obejct was nil, tried setting the character position" userInfo:nil];
    }
}

@end
