//
//  StoryMainScene.m
//  Middleton
//
//  Created by cheenar gupte on 5/23/16.
//  Copyright © 2016 CBAJV. All rights reserved.
//

#import "StoryMainScene.h"
#import "MenuScene.h"

@implementation StoryMainScene
@synthesize storyPosition;

-(void)home
{
    [self setupDefaultScene];
    storyPosition = 0;
}

-(void)setupDefaultScene
{
    [self setupBackground:@"background_middleton_ledge"];
    [self setupCharacter:@"mryoung_trans" withScale:.34];
    self.characterImage.alpha = 0.0;
    [self setCharacterPosition:LEFT];
    [self setMessageBoxText:@[@"Hello there!", @"Welcome to Middleton High School"]];
    [self setMessageTitleText:@"Mr. Young"];
    
    [self options].alpha = 0.0;
}

-(id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if(self)
    {
        SKSpriteNode *home = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"home"]];
        home.name = @"home";
        home.zPosition = 100;
        home.colorBlendFactor = 1.0;
        home.color = [SKColor whiteColor];
        [home setScale:0.05];
        home.alpha = 0.5;
        home.position = CGPointMake((home.frame.size.width/2) + 20, self.frame.size.height - (home.frame.size.height / 2) - 20);
        [self addChild:home];
        
        storyPosition = 0;
        [self setupDefaultScene];
    }
    return self;
}

-(void)didMoveToView:(SKView *)view
{
    if([self actionForKey:@"music"] == nil)
    {
        [self runAction:[SKAction repeatActionForever:[SKAction playSoundFileNamed:@"bg.mp3" waitForCompletion:YES]] withKey:@"music"];
    }
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    BOOL shouldAdvanceStory = NO;
    NSObject *tempData=nil;
    
    if([[self childNodeWithName:@"home"] containsPoint:[[touches anyObject] locationInNode:self]])
    {
        MenuScene *scene = [[MenuScene alloc] initWithSize:self.frame.size];
        [self.view presentScene:scene transition:[SKTransition flipHorizontalWithDuration:0.5]];
    }
    else
    {
        int y = -1;
        
        if(storyPosition == (y+=1)) //0
        {
            [self setMessageBoxText:@[@"I will guide you through an", @"interactive tour of my school."]];
            shouldAdvanceStory = YES;
        }
        
        if(storyPosition == (y+=1)) //1
        {
            [self setMessageBoxText:@[@"What tour option would you prefer?"]];
            
            //MOD
            [self setOptionChoicesText:@[@"Guided Tour", @"Free Roam"]];
            [self showOptions:YES];
            
            shouldAdvanceStory = YES;
        }
        
        if(storyPosition == (y+=1)) //2
        {
            CGPoint touch = [[touches anyObject] locationInNode:self];
            for(SKShapeNode *node in self.options.children)
            {
                if([node containsPoint:touch])
                {
                    NSLog(@"touched: %@", ((SKLabelNode *)[node childNodeWithName:@"option_text"]).text);
                    storyPosition++;
                    shouldAdvanceStory = YES;
                    tempData = ((SKLabelNode *)[node childNodeWithName:@"option_text"]).text;
                }
            }
        }
        
        if(storyPosition == (y+=1)) //3
        {
            [self showTitleBox:NO];
            [self showOptions:NO];
            [self setCharacterPosition:MIDDLE];
            [self setMessageBoxText:@[
                                      [NSString stringWithFormat:@"You've touched me %@", (NSString *)tempData]
                                      ]];
        }
        
        if(shouldAdvanceStory) storyPosition++;
    }
}

@end
