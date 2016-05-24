//
//  CGScene.h
//  Middleton
//
//  Created by cheenar gupte on 5/23/16.
//  Copyright © 2016 CBAJV. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

#define COLOR(r,g,b,a) [SKColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

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

//messageboxes
@property SKShapeNode *messageBox;
@property SKShapeNode *messageTitle;

-(void) setupMessageBox;
-(void) setupMessageTitle:(NSString *)title;

-(void)setMessageBoxText:(NSArray *)lines;
-(void)setMessageTitleText:(NSString *)title;

-(void)showMessageBox:(BOOL)shouldShow;
-(void)showTitleBox:(BOOL)shouldShow;

//choices tab
@property SKNode *options;
@property NSArray *optionsChoices;

-(void)setupOptions:(NSArray *)choices;
-(void)showOptions:(BOOL)shouldShow;
-(void)setOptionChoicesText:(NSArray *)ops;

-(BOOL)areOptionsVisible;

//helper funcs
-(void)setCharacterPosition:(CharacterPosition)pos;

-(id)initWithSize:(CGSize)size;

@end
