//
//  StoryFreeRoamScene.h
//  Middleton
//
//  Created by Chad Carson on 5/26/16.
//  Copyright © 2016 CBAJV. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface StoryFreeRoamScene : SKScene
{
    NSArray *screens;
    int currentScreen;
    SKNode *showingScreen;
    
    SKSpriteNode *leftButton;
    SKSpriteNode *rightButton;
    
    SKShapeNode *cardView;
    BOOL isCardViewShowing;
}

@end
