//
//  MenuScene.m
//  Middleton
//
//  Created by cheenar gupte on 5/21/16.
//  Copyright © 2016 CBAJV. All rights reserved.
//

#import "MenuScene.h"
#import "StoryMainScene.h"

#define COLOR(r,g,b,a) [SKColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HEIGHT(x) self.frame.size.height/x
#define WIDTH(x) self.frame.size.width/x
#define HEI(s,x) s.frame.size.height/x
#define WID(s,x) s.frame.size.width/x

@interface MenuScene()
{
    
}
@end

@implementation MenuScene

-(void)makeButtonWithTitle:(NSString *)title withPosition:(CGPoint)location
{
    SKShapeNode *button = [SKShapeNode shapeNodeWithRect:CGRectMake(0, 0, 300, 80) cornerRadius:12];
    button.position = CGPointMake(location.x - (button.frame.size.width / 2), location.y - (button.frame.size.height / 2));
    button.alpha = 0.0;
    button.name = title;
    button.zPosition = 1;
    button.lineWidth = 0.0;
    button.fillColor = COLOR(161, 23, 84, 0.8);
    [self addChild:button];
    
    SKLabelNode *text = [SKLabelNode labelNodeWithFontNamed:@"PingFangHK-Ultralight"];
    text.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    text.verticalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    text.fontSize = 36;
    text.alpha = 1.0;
    text.zPosition = 2;
    text.text = title;
    text.position = CGPointMake(button.frame.size.width / 2, (button.frame.size.height / 2) - (text.frame.size.height / 2));
    text.fontColor = [SKColor whiteColor];
    [button addChild:text];
    
    [button runAction:[SKAction fadeInWithDuration:1.5]];
    
    NSLog(@"makd button");
}

-(void)setupInitial
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"middleton_background.png"]];
    background.zPosition = 0;
    background.size = CGSizeMake(WIDTH(1), HEIGHT(1));
    background.name = @"background";
    background.position = CGPointMake(WIDTH(2), HEIGHT(2));
    [self addChild:background];
    
    SKLabelNode *text = [SKLabelNode labelNodeWithFontNamed:@"PingFangHK-Ultralight"];
    text.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    text.verticalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    text.fontSize = 72;
    text.alpha = 1.0;
    text.zPosition = 2;
    text.text = @"History of Middleton";
    text.position = CGPointMake(WIDTH(2), HEIGHT(1) - text.frame.size.height);
    text.fontColor = [SKColor whiteColor];
    [self addChild:text];
    
    [self makeButtonWithTitle:@"Story" withPosition:CGPointMake(WIDTH(2), HEIGHT(2) - 20)];
    //[self makeButtonWithTitle:@"Resources" withPosition:CGPointMake(WIDTH(2), HEIGHT(2) - 120)];
}

-(void)didMoveToView:(SKView *)view
{
    [self setupInitial];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint touch = [[touches anyObject] locationInNode:self];
    if([[self childNodeWithName:@"Story"] containsPoint:touch])
    {
        StoryMainScene *scene = [[StoryMainScene alloc] initWithSize:self.frame.size];
        [self.view presentScene:scene transition:[SKTransition flipHorizontalWithDuration:0.5]];
    }
    if([[self childNodeWithName:@"Resources"] containsPoint:touch])
    {
        NSLog(@"what resources?");
    }
}

@end
