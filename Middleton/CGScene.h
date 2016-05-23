//
//  CGScene.h
//  Middleton
//
//  Created by cheenar gupte on 5/23/16.
//  Copyright © 2016 CBAJV. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum _CharacterPosition
{
    LEFT,
    MIDDLE,
    RIGHT
}CharacterPosition;

@interface CGScene : SKScene
{
    
}

-(void)setupBackground:(NSString *)imageName;
-(void)setupCharacter: (NSString *)characterImageName withScale:(float)scalef;


@property SKSpriteNode *backgroundImage;
@property SKSpriteNode *characterImage;

-(void)setCharacterPosition:(CharacterPosition)pos;

-(id)initWithSize:(CGSize)size;

@end
