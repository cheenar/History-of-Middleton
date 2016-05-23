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
@synthesize characterImage, backgroundImage, messageBox, messageTitle;

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

-(void) setupMessageBox
{
    float x = .9;
    float y = .25;
    messageBox = [SKShapeNode shapeNodeWithRect:CGRectMake(0, 0, self.frame.size.width * x, self.frame.size.height * y) cornerRadius:10.0];
    messageBox.position = CGPointMake(WIDTH(2) - (messageBox.frame.size.width / 2), (messageBox.frame.size.height / 24) + 20);
    messageBox.fillColor = COLOR(30,30,30,0.67);
    messageBox.lineWidth = 0.0;
    messageBox.name = @"messageBox";
    messageBox.zPosition = 2;
    if(![self.children containsObject:messageBox])
    {
        [self addChild:messageBox];
        NSLog(@"makd bnox");
    }
    
    //hexagon
    SKSpriteNode *hexagon = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"hexagon"]];
    hexagon.zPosition = 1;
    [hexagon setScale:.1];
    hexagon.position = CGPointMake(messageBox.frame.size.width - (hexagon.frame.size.width/2) - 10, 20);
    hexagon.name = @"hexagon";
    [hexagon runAction:[SKAction repeatActionForever:[SKAction sequence:@[
                                                                          
                                                                          [SKAction scaleTo:.15 duration:0.5],
                                                                          [SKAction waitForDuration:1.0],
                                                                          [SKAction scaleTo:.1 duration:.5],
                                                                          [SKAction waitForDuration:1.0]
                                                                          
                                                                          ]]]];
    [hexagon runAction:[SKAction repeatActionForever:[SKAction rotateByAngle:3.14 duration:4.0]]];
    [messageBox addChild:hexagon];
    
    //messagebox lines
    SKLabelNode *text = [SKLabelNode labelNodeWithFontNamed:@"PingFangHK-Ultralight"];
    text.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    text.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    text.fontSize = 36;
    text.alpha = 1.0;
    text.zPosition = 2;
    text.text = @"testtest";
    text.position = CGPointMake(20, messageBox.frame.size.height - (text.frame.size.height) - 20);
    text.fontColor = [SKColor whiteColor];
    [messageBox addChild:text];
}

-(void) setupMessageTitle
{
    
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
        //setup the message
        [self setupMessageBox];
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

-(void)setMessageBoxText:(NSArray *)lines
{
    
}

-(void)setMessageTitleText:(NSString *)title
{
    
}

-(void)showMessageBox:(BOOL)shouldShow
{
    float opacity = shouldShow ? 1.0 : 0.0;
    if(messageBox != nil)
        [messageBox runAction:[SKAction fadeAlphaTo:opacity duration:1.0]];
    else
        @throw [NSException exceptionWithName:@"Failed to show messagebox" reason:@"the message box was no initialized" userInfo:nil];
}

-(void)showTitleBox:(BOOL)shouldShow
{
    float opacity = shouldShow ? 1.0 : 0.0;
    if(messageTitle != nil)
        [messageTitle runAction:[SKAction fadeAlphaTo:opacity duration:1.0]];
    else
        @throw [NSException exceptionWithName:@"Failed to show messagebox" reason:@"the message box was no initialized" userInfo:nil];
}

@end
