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
@synthesize characterImage, backgroundImage, messageBox, messageTitle, optionsChoices, options;

-(void)setupBackground:(NSString *)imageName
{
    if(backgroundImage != nil)
    {
        [backgroundImage removeFromParent];
        backgroundImage = nil;
    }
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
    if(characterImage != nil)
    {
        [characterImage removeFromParent];
        characterImage = nil;
    }
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
    
    for(int i = 0; i < 3; i++)
    {
        SKLabelNode *text = [SKLabelNode labelNodeWithFontNamed:@"PingFangHK-Thin"];
        text.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        text.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        text.fontSize = 26;
        text.alpha = 1.0;
        text.name = [NSString stringWithFormat:@"text_%i", i];
        text.zPosition = 2;
        text.text = @"XYZxyz";
        text.position = CGPointMake(20, messageBox.frame.size.height - (text.frame.size.height * (i + 1)) - 0);
        text.fontColor = [SKColor whiteColor];
        text.text = @"";
        [messageBox addChild:text];
    }
}

-(void) setupMessageTitle:(NSString *)title
{
    float x = .9;
    float y = .1;
    int fontSize = 26;
    messageTitle = [SKShapeNode shapeNodeWithRect:CGRectMake(0, 0,self.frame.size.width * x, self.frame.size.height * y) cornerRadius:10.0];
    messageTitle.position = CGPointMake(messageBox.position.x, messageBox.frame.size.height + (messageTitle.frame.size.height / 24) + 30);
    messageTitle.fillColor = COLOR(64,64,64,0.67);
    messageTitle.lineWidth = 0.0;
    messageTitle.name = @"messageTitle";
    messageTitle.zPosition = 2;
    if(![self.children containsObject:messageTitle])
    {
        [self addChild:messageTitle];
        NSLog(@"makd bnox");
    }
    
    SKLabelNode *text = [SKLabelNode labelNodeWithFontNamed:@"PingFangHK-Thin"];
    text.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
    text.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    text.fontSize = fontSize;
    text.alpha = 1.0;
    text.name = [NSString stringWithFormat:@"text_title"];
    text.zPosition = 2;
    text.text = title;
    text.position = CGPointMake(20, messageTitle.frame.size.height - (text.frame.size.height) + 5);
    text.fontColor = [SKColor whiteColor];
    text.text = @"";
    [messageTitle addChild:text];
}

-(void) setupOptions:(NSArray *)choices
{
    self.optionsChoices = choices;
    if(options == nil)
    {
        if(![[self children] containsObject:options])
        {
            options = [SKNode node];
        }
    }
    else
    {
        for(SKNode *n in options.children)
        {
            [n removeFromParent];
        }
    }
    [options setPosition:CGPointMake(0, 0)];
    options.zPosition = 3;
    options.name = @"options";
    options.alpha = 0.0;
    
    for(int i = 0; i < optionsChoices.count; i++)
    {
        SKShapeNode *optionButton = [SKShapeNode shapeNodeWithRect:CGRectMake(0, 0, self.frame.size.width * 0.34, self.frame.size.height / 7.0) cornerRadius:10];
        optionButton.position = CGPointMake(WIDTH(2) - (optionButton.frame.size.width / 2) , HEIGHT(1) - ((optionButton.frame.size.height / 2)) - 50 - (optionButton.frame.size.height * (i)));
        NSLog(@"%fi,%fi", optionButton.position.x, optionButton.position.y);
        optionButton.zPosition = 1;
        optionButton.lineWidth = 0.0;
        optionButton.name = [NSString stringWithFormat:@"option_%i", i];
        optionButton.fillColor = COLOR(30, 30, 30, 0.8);
        
        SKLabelNode *text = [SKLabelNode labelNodeWithFontNamed:@"PingFangHK-Thin"];
        text.name = [NSString stringWithFormat:@"option_text"];
        text.fontSize = 24;
        text.text = [choices objectAtIndex:i];
        text.position = CGPointMake(optionButton.frame.size.width/2, (optionButton.frame.size.height/2) - (text.frame.size.height/2));
        [optionButton addChild:text];
        
        [options addChild:optionButton];
        
    }
    
    if(![[self children] containsObject:options])
    {
         [self addChild:options];
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
        //setup the message
        [self setupMessageBox];
        [self setupMessageTitle:@"XYZxyz"];
        [self setupOptions:@[@"test", @"poop"]];
    }
    return self;
}

-(void)setCharacterPosition:(CharacterPosition)pos
{
    if(characterImage != nil)
    {
        CGPoint position = CGPointMake(0, 0);
        switch(pos)
        {
            case LEFT:
                position = CGPointMake((self.frame.size.width / 8 )+ 40, CHARACTER_POS_Y);
                break;
            case RIGHT:
                position = CGPointMake((self.frame.size.width) - (self.frame.size.width / 8) - 40, CHARACTER_POS_Y);
                break;
            case MIDDLE:
                position = CGPointMake(self.frame.size.width/2, CHARACTER_POS_Y);
                break;
            default:
                @throw [NSException exceptionWithName:@"Invalid Position" reason:@"Invalid position fed for character position" userInfo:nil];
                break;
        }
        [characterImage runAction:[SKAction sequence:@[
                                                       
                                                       [SKAction fadeOutWithDuration:0.2],
                                                       [SKAction moveTo:position duration:0.0],
                                                       [SKAction fadeInWithDuration:0.2]
                                                       
                                                       ]]];
    }
    else
    {
        @throw [NSException exceptionWithName:@"Character Not Initialized" reason:@"Character obejct was nil, tried setting the character position" userInfo:nil];
    }
}

-(void)setMessageBoxText:(NSArray *)lines
{
    NSMutableArray *data = [NSMutableArray array];
    for(int i = 0; i < 3; i++)
    {
        if(i < lines.count)
        {
            [data addObject:[lines objectAtIndex:i]];
        }
        else
        {
            [data addObject:@""];
        }
    }
    for(int i = 0; i < data.count; i++)
    {
        SKLabelNode *text = (SKLabelNode *)[messageBox childNodeWithName:[NSString stringWithFormat:@"text_%i", i]];
        [text runAction:[SKAction sequence:@[
                                             
                                             [SKAction fadeOutWithDuration:0.2],
                                             [SKAction runBlock:^{
            text.text = [data objectAtIndex:i];
        }],
                                             [SKAction fadeInWithDuration:0.2]
                                             
                                             ]]];
    }
}

-(void)setMessageTitleText:(NSString *)title
{
    if(messageTitle != nil)
    {
        SKLabelNode *text = (SKLabelNode *) [messageTitle childNodeWithName:@"text_title"];
        text.text = title;
    }
}

-(void)setOptionChoicesText:(NSArray *)ops
{
    [self setupOptions:ops];
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

-(void)showOptions:(BOOL)shouldShow
{
    float opacity = shouldShow ? 1.0 : 0.0;
    if(options != nil)
        [options runAction:[SKAction fadeAlphaTo:opacity duration:1.0]];
    else
        @throw [NSException exceptionWithName:@"Failed to show messagebox" reason:@"the message box was no initialized" userInfo:nil];
}

-(BOOL)areOptionsVisible
{
    return options.alpha > 0;
}

@end
