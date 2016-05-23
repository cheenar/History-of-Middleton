//
//  GameScene.m
//  Middleton
//
//  Created by cheenar gupte on 5/20/16.
//  Copyright (c) 2016 CBAJV. All rights reserved.
//

#import "GameScene.h"
#import "MenuScene.h"

#define COLOR(r,g,b,a) [SKColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HEIGHT(x) self.frame.size.height/x
#define WIDTH(x) self.frame.size.width/x
#define HEI(s,x) s.frame.size.height/x
#define WID(s,x) s.frame.size.width/x

@interface GameScene()
{
    BOOL isAnimationSeqComp;
    BOOL isSwipingUp;
}
@end

@implementation GameScene

-(void)setupInitialScreen
{
    SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"middleton_background.png"]];
    background.zPosition = 0;
    background.size = CGSizeMake(WIDTH(1), HEIGHT(1));
    background.name = @"background";
    background.position = CGPointMake(WIDTH(2), HEIGHT(2));
    [self addChild:background];
    
    SKSpriteNode *middletonLogo = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"middleton.png"]];
    middletonLogo.zPosition = 1;
    middletonLogo.name = @"logo";
    [middletonLogo setScale:0.2];
//[middletonLogo runAction:[SKAction rotateByAngle:3.14 duration:2.0]];
    middletonLogo.position = CGPointMake(WIDTH(2), HEIGHT(2) + 20);
    [self addChild:middletonLogo];
    
    SKLabelNode *authors = [SKLabelNode labelNodeWithFontNamed:@"PingFangHK-Thin"];
    authors.zPosition = 1;
    authors.text = @"Cheenar | Brian | Alec | Jeff | Varun";
    authors.fontSize = 24;
    authors.fontColor = [SKColor whiteColor];
    authors.position = CGPointMake(WIDTH(2), HEIGHT(2) - (middletonLogo.frame.size.height / 2) - (authors.frame.size.height  / 2) - 15);
    authors.name = @"authors_text";
    [self addChild:authors];
    
    [self runAction:[SKAction sequence:@[[SKAction waitForDuration:1.2], [SKAction runBlock:^{
        [authors runAction:[SKAction sequence:@[
                                                
                                                [SKAction fadeAlphaTo:0.0 duration:1.0],
                                                [SKAction runBlock:^{
            [authors setText:@"APUSH 1 - 2"]; }],
                                                [SKAction fadeAlphaTo:1.0 duration:1.0],
                                                [SKAction waitForDuration:0.3],
                                                [SKAction runBlock:^{ isAnimationSeqComp = YES; }]
                                                
                                                ]] completion:^{
            [authors runAction:[SKAction sequence:@[[SKAction fadeOutWithDuration:1.0], [SKAction waitForDuration:1.0]]]];
            [middletonLogo runAction:[SKAction sequence:@[[SKAction fadeOutWithDuration:1.0], [SKAction waitForDuration:1.0]]] completion:^{
                [self.view presentScene:[[MenuScene alloc] initWithSize:self.frame.size] transition:[SKTransition fadeWithDuration:0.0]];
            }];
        }];
    }]]]];
}

-(void)didMoveToView:(SKView *)view
{
    isAnimationSeqComp = NO;
    
    [self setBackgroundColor:[SKColor whiteColor]];
    [self setupInitialScreen];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
}

-(void)update:(CFTimeInterval)currentTime
{
    
}

@end
