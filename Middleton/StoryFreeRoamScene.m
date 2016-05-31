//
//  StoryFreeRoamScene.m
//  Middleton
//
//  Created by Chad Carson on 5/26/16.
//  Copyright © 2016 CBAJV. All rights reserved.
//

#import "StoryFreeRoamScene.h"
#import "MenuScene.h"
#import "Constants.h"

#define COUNT(arr) [arr count]

@interface StoryFreeRoamScene()
{
    
}
@end

@implementation StoryFreeRoamScene

-(SKTexture *)blurredTexture:(NSString *)tex withBlur:(BOOL)sb
{
    SKTexture *texture = [SKTexture textureWithImageNamed:tex];
    if(!sb) return texture;
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [gaussianBlurFilter setDefaults];
    [gaussianBlurFilter setValue:[CIImage imageWithCGImage:[texture CGImage]] forKey:kCIInputImageKey];
    [gaussianBlurFilter setValue:@20 forKey:kCIInputRadiusKey];
    
    CIImage *outputImage = [gaussianBlurFilter outputImage];
    CIContext *context   = [CIContext contextWithOptions:nil];
    CGRect rect          = [outputImage extent];
    rect.origin.x        += (rect.size.width  - texture.size.width ) / 2;
    rect.origin.y        += (rect.size.height - texture.size.height) / 2;
    rect.size            = texture.size;
    CGImageRef cgimg     = [context createCGImage:outputImage fromRect:rect];
    UIImage *image       = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    texture = [SKTexture textureWithImage:image];
    return texture;
}

-(SKTexture *)blurredTextureWithTexture:(SKTexture *)tex withBlur:(BOOL)sb
{
    SKTexture *texture = tex;
    if(!sb) return texture;
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [gaussianBlurFilter setDefaults];
    [gaussianBlurFilter setValue:[CIImage imageWithCGImage:[texture CGImage]] forKey:kCIInputImageKey];
    [gaussianBlurFilter setValue:@20 forKey:kCIInputRadiusKey];
    
    CIImage *outputImage = [gaussianBlurFilter outputImage];
    CIContext *context   = [CIContext contextWithOptions:nil];
    CGRect rect          = [outputImage extent];
    rect.origin.x        += (rect.size.width  - texture.size.width ) / 2;
    rect.origin.y        += (rect.size.height - texture.size.height) / 2;
    rect.size            = texture.size;
    CGImageRef cgimg     = [context createCGImage:outputImage fromRect:rect];
    UIImage *image       = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    texture = [SKTexture textureWithImage:image];
    return texture;
}

-(SKTexture *)blurBackground:(SKTexture *)tex withBlur:(BOOL)sb
{
    SKTexture *texture = tex;
    if(!sb) return texture;
    CIFilter *gaussianBlurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [gaussianBlurFilter setDefaults];
    [gaussianBlurFilter setValue:[CIImage imageWithCGImage:[texture CGImage]] forKey:kCIInputImageKey];
    [gaussianBlurFilter setValue:@5 forKey:kCIInputRadiusKey];
    
    CIImage *outputImage = [gaussianBlurFilter outputImage];
    CIContext *context   = [CIContext contextWithOptions:nil];
    CGRect rect          = [outputImage extent];
    rect.origin.x        += (rect.size.width  - texture.size.width ) / 2;
    rect.origin.y        += (rect.size.height - texture.size.height) / 2;
    rect.size            = texture.size;
    CGImageRef cgimg     = [context createCGImage:outputImage fromRect:rect];
    UIImage *image       = [UIImage imageWithCGImage:cgimg];
    CGImageRelease(cgimg);
    
    texture = [SKTexture textureWithImage:image];
    return texture;
}

-(SKShapeNode *)buildBox:(CGPoint)loc withImg:(NSString *)img withText:(NSString *)line
{
    NSLog(@"%fi,%fi", self.frame.size.width * 0.4, self.frame.size.height * 0.395);
    SKShapeNode *box = [SKShapeNode shapeNodeWithRect:CGRectMake(0, 0, self.frame.size.width * 0.4, self.frame.size.height * 0.395) cornerRadius:15.0];
    box.position = CGPointMake(loc.x - (box.frame.size.width / 2), loc.y - (box.frame.size.height / 2));
    box.fillColor = COLOR(255,255,255, 1.0);
    box.lineWidth = 0.0;
    box.fillTexture = [self blurredTexture:img withBlur:NO];
    
    SKLabelNode *text = [SKLabelNode labelNodeWithFontNamed:@"PingFangHK-Thin"];
    text.fontSize = 24;
    text.fontColor = [SKColor whiteColor];
    text.name = @"text";
    text.text = line;
    text.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    text.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
    text.position = CGPointMake(box.frame.size.width / 2, box.frame.size.height / 2);
    text.alpha = 0.0;
    [box addChild:text];
    
    return box;
}

-(SKNode *)buildScreen:(NSArray *)imgs withText:(NSArray *)lines
{
    SKNode *node = [SKNode node];
    
    node.userData = [NSMutableDictionary dictionary];
    [node.userData setObject:imgs forKey:@"imgs"];
    [node.userData setObject:lines forKey:@"lines"];
    
    int spacing = 60;
    float height = 0.3;
    
    SKShapeNode *box_1;
    SKShapeNode *box_2;
    SKShapeNode *box_3;
    SKShapeNode *box_4;
    
    if(lines.count > 0)
    {
        box_1 = [self buildBox:CGPointMake(spacing + (self.frame.size.width * 0.2), (self.frame.size.height - spacing - (self.frame.size.height * (height/2)))) withImg:[imgs objectAtIndex:0] withText:[lines objectAtIndex:0]];
        box_1.name = @"box_1";
        [node addChild:box_1];
    }
    
    if(lines.count > 1)
    {
        box_2 = [self buildBox:CGPointMake(spacing + (self.frame.size.width * 0.2), (spacing + (self.frame.size.height * (height/2)))) withImg:[imgs objectAtIndex:1] withText:[lines objectAtIndex:1]];
        box_2.name = @"box_2";
        [node addChild:box_2 ];
    }
    
    if(lines.count > 2)
    {
        box_3 = [self buildBox:CGPointMake(self.frame.size.width - spacing - (self.frame.size.width * 0.2), (self.frame.size.height - spacing - (self.frame.size.height * (height/2)))) withImg:[imgs objectAtIndex:2] withText:[lines objectAtIndex:2]];
        box_3.name = @"box_3";
        [node addChild:box_3];
    }
    
    if(lines.count > 3)
    {
        box_4 = [self buildBox:CGPointMake(self.frame.size.width - spacing - (self.frame.size.width * 0.2), (spacing + (self.frame.size.height * (height/2)))) withImg:[imgs objectAtIndex:3] withText:[lines objectAtIndex:3]];
        box_4.name = @"box_4";
        [node addChild:box_4];
    }
    
    for(SKNode *n in node.children)
    {
        n.userData = [NSMutableDictionary dictionary];
    }
    
    node.zPosition = 1;
    
    return node;
    
}

-(id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if(self)
    {
        isAnimatingCardMotion = NO;
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithTexture:[self blurBackground:[SKTexture textureWithImageNamed:@"big_tiger"] withBlur:YES]];
        background.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        background.zPosition = 0;
        [self addChild:background];
        
        currentScreen = 0;
        
        SKNode *firstScreen = [self buildScreen:
  
  
  @[@"Cafeteria_low", @"Baseball_low",
    @"tiger_logo.png"]
                                       withText:
  @[@"Key Buildings", @"Sports Fields", @"Middleton"]];
        
        
        SKNode *secondScreen = [self buildScreen:
  
  
  @[@"Gym_low"] withText:
  @[@"Gym"]];
        
        screens = @[firstScreen];
        
        showingScreen = [screens objectAtIndex:currentScreen];
        
        leftButton = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"left"]];
        [leftButton setScale:-0.2];
        [leftButton setZPosition:1];
        [leftButton setPosition:CGPointMake(30, self.frame.size.height / 2)];
        
        rightButton = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"left"]];
        [rightButton setScale:0.2];
        [rightButton setZPosition:1];
        [rightButton setPosition:CGPointMake(self.frame.size.width - 30, self.frame.size.height / 2)];
        
        //[self addChild:leftButton];
        //[self addChild:rightButton];
        
        
        SKSpriteNode *home = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImageNamed:@"home"]];
        home.name = @"home";
        home.zPosition = 100;
        home.colorBlendFactor = 1.0;
        home.color = [SKColor whiteColor];
        [home setScale:0.05];
        home.alpha = 0.5;
        home.position = CGPointMake((home.frame.size.width/2) + 20, self.frame.size.height - (home.frame.size.height / 2) - 20);
        [self addChild:home];
        
        
        cardView = [SKShapeNode shapeNodeWithRect:CGRectMake(0, 0, self.frame.size.width * 0.9, self.frame.size.height * 0.85) cornerRadius:15.0];
        cardView.position = CGPointMake((self.frame.size.width/2) - (cardView.frame.size.width/2), -self.frame.size.height);
        //(self.frame.size.height/2) - (cardView.frame.size.height/2)
        cardView.fillColor = COLOR(0, 0, 0, 0.8);
        cardView.lineWidth = 0.0;
        cardView.zPosition = 100;
        [cardView runAction:[SKAction rotateToAngle:-3.14/2 duration:0.0]];
        [self addChild:cardView];
        isCardViewShowing = NO;
        
        [self addChild:showingScreen];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint loc = [[touches anyObject] locationInNode:showingScreen];
    
    if(isCardViewShowing)
    {
        if(![cardView containsPoint:[[touches anyObject] locationInNode:self]])
        {
            for(SKNode *child in cardView.children)
            {
                [child removeFromParent];
            }
            [cardView runAction:[SKAction moveToY:(-self.frame.size.height) duration:1.0]];
            [cardView runAction:[SKAction rotateToAngle:-3.14/2 duration:1.0]];
            isCardViewShowing = NO;
            SKAction *action = [SKAction fadeInWithDuration:0.3];
            [leftButton runAction:action];
            [rightButton runAction:action];
            [showingScreen runAction:action];
            [[self childNodeWithName:@"home"] runAction:[SKAction fadeInWithDuration:0.4]];
        }
        return;
    }
    
    if([[self childNodeWithName:@"home"] containsPoint:[[touches anyObject] locationInNode:self]])
    {
        MenuScene *scene = [[MenuScene alloc] initWithSize:self.frame.size];
        [self.view presentScene:scene transition:[SKTransition flipHorizontalWithDuration:0.5]];
    }
    
    if([leftButton containsPoint:[[touches anyObject] locationInNode:self]])
    {
        if(true)
        {
            if(currentScreen != 0)
                currentScreen--;
            else
                currentScreen = (int)screens.count-1;
            
            isAnimatingCardMotion = YES;
            
            [showingScreen runAction:[SKAction moveToX:-self.frame.size.width duration:0.5] completion:^{
                [showingScreen removeFromParent];
                showingScreen = [screens objectAtIndex:currentScreen];
                showingScreen.alpha = 0.0;
                [self addChild:showingScreen];
                [showingScreen runAction:[SKAction moveToX:self.frame.size.width duration:0.0] completion:^{
                    showingScreen.alpha = 1.0;
                    [showingScreen runAction:[SKAction moveToX:0 duration:0.5] completion:^{
                        isAnimatingCardMotion = NO;
                    }];
                }];
            }];
        }
    }
    if([rightButton containsPoint:[[touches anyObject] locationInNode:self]])
    {
        if(true)
        {
            if(currentScreen != screens.count-1)
                currentScreen++;
            else
                currentScreen = 0;
            
            isAnimatingCardMotion = YES;
            
            [showingScreen runAction:[SKAction moveToX:self.frame.size.width duration:0.5] completion:^{
                [showingScreen removeFromParent];
                showingScreen = [screens objectAtIndex:currentScreen];
                showingScreen.alpha = 0.0;
                [self addChild:showingScreen];
                [showingScreen runAction:[SKAction moveToX:-self.frame.size.width duration:0.0] completion:^{
                    showingScreen.alpha = 1.0;
                    [showingScreen runAction:[SKAction moveToX:0 duration:0.5] completion:^{
                        isAnimatingCardMotion = NO;
                    }];
                }];
            }];
        }
    }
    
    for(SKShapeNode *obj in showingScreen.children)
    {
        if([obj containsPoint:loc] && ![[obj.userData allKeys] containsObject:@"previousTexture"])
        {
            SKTexture *previousTexture = obj.fillTexture;
            obj.fillTexture = [self blurredTextureWithTexture:previousTexture withBlur:YES];
            [obj.userData setObject:previousTexture forKey:@"previousTexture"];
            [obj childNodeWithName:@"text"].alpha = 1.0;
        }
    }
    
}

-(void)cardSelected
{
    [cardView runAction:[SKAction rotateToAngle:0 duration:1.0]];
    [cardView runAction:[SKAction moveToY:(self.frame.size.height/2) - ((self.frame.size.height * 0.85)/2) duration:1.0]];
    isCardViewShowing = YES;
    SKAction *action = [SKAction fadeOutWithDuration:0.3];
    [leftButton runAction:action];
    [rightButton runAction:action];
    [showingScreen runAction:action];
}

-(void)renderTexts:(NSArray *)texts withInitPosition:(CGPoint)startPosition
{
    int fontSize = 14;
    int spacing = 2;
    
    startPosition = CGPointMake(startPosition.x, startPosition.y);
    
    for(int i= 0; i < texts.count; i++)
    {
        SKLabelNode *node = [SKLabelNode labelNodeWithFontNamed:@"PingFangHK-Regular"];
        node.fontSize = fontSize;
        //node.fontColor = COLOR(137, 108, 132, 1.0);
        node.fontColor = COLOR(128, 128, 128, 1.0);
        node.zPosition = 2;
        node.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        node.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        node.text = [texts objectAtIndex:i];
        node.name = node.text;
        node.position = CGPointMake(startPosition.x, startPosition.y-((fontSize + spacing) * i));
        [cardView addChild:node];
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(isAnimatingCardMotion)
    {
        return;
    }
    
    float width = self.frame.size.width *0.9;
    float height = self.frame.size.height * 0.85;
    
    for(SKShapeNode *button in showingScreen.children)
    {
        if([button containsPoint:[[touches anyObject] locationInNode:showingScreen]] && [[button.userData allKeys] containsObject:@"previousTexture"])
        {
            SKLabelNode *text = (SKLabelNode *)[button childNodeWithName:@"text"];
            
            [self cardSelected]; //move this outside of this to run for all cards
            [[self childNodeWithName:@"home"] runAction:[SKAction fadeOutWithDuration:0.4]];
            
            SKLabelNode *test = [SKLabelNode labelNodeWithFontNamed:@"PingFangHK-Thin"];
            test.fontSize = 36;
            test.fontColor = [SKColor whiteColor];
            test.zPosition = 2;
            test.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
            test.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
            test.text = text.text;
            test.position = CGPointMake(20,height - (test.frame.size.height/2) - 20);
            [cardView addChild:test];
            
            //•
            
            NSArray *imgs = [showingScreen.userData objectForKey:@"imgs"];
            NSArray *lines = [showingScreen.userData objectForKey:@"lines"];
            NSUInteger index = [lines indexOfObject:test.text];
            
            //cardView.fillTexture = [SKTexture textureWithImageNamed:[[[imgs objectAtIndex:index] componentsSeparatedByString:@"_low"] objectAtIndex:0]];
            
            if([text.text isEqualToString:@"Sports Fields"])
            {
                SKShapeNode *pictureViewer = [SKShapeNode shapeNodeWithRect:CGRectMake(0, 0, 350, 200) cornerRadius:20];
                pictureViewer.name = @"pictureViewer";
                pictureViewer.zPosition = 1;
                pictureViewer.fillColor = [SKColor whiteColor];
                pictureViewer.fillTexture = [SKTexture textureWithImageNamed:[imgs objectAtIndex:index]];
                pictureViewer.position = CGPointMake(width - (pictureViewer.frame.size.width) - 20, height  - (pictureViewer.frame.size.height) - 20);
                [cardView addChild:pictureViewer];
                
                [pictureViewer runAction:[SKAction repeatActionForever:[SKAction sequence:@[
                                                                                            
                                                                                            [SKAction runBlock:^{[pictureViewer setFillTexture:[SKTexture textureWithImageNamed:[imgs objectAtIndex:index]]];}],
                                                                                            [SKAction waitForDuration:2],
                                                                                            [SKAction runBlock:^{[pictureViewer setFillTexture:[SKTexture textureWithImageNamed:@"FieldBrian_low"]];}],
                                                                                            [SKAction waitForDuration:2],
                                                                                            [SKAction runBlock:^{[pictureViewer setFillTexture:[SKTexture textureWithImageNamed:@"DavidField_low"]];}],
                                                                                            [SKAction waitForDuration:2],
                                                                                            [SKAction runBlock:^{[pictureViewer setFillTexture:[SKTexture textureWithImageNamed:@"Tennis_low"]];}],
                                                                                            [SKAction waitForDuration:2]
                                                                                            
                                                                                            ]]]];
                
                [self renderTexts:@[@"• Football stadium named after Abe",
                                    @"Brown who was the head coach",
                                    @"During many undefeated eras",
                                    @"• Baseball field named after David",
                                    @"Best who was an alum and player",
                                    @"He was also a principal at Blake",
                                    @"• Track named for Olympian",
                                    @"Teresa M."]
                 withInitPosition:CGPointMake(20, test.position.y - 40)];
            }
            
            if([text.text isEqualToString:@"Key Buildings"])
            {
                SKShapeNode *pictureViewer = [SKShapeNode shapeNodeWithRect:CGRectMake(0, 0, 350, 200) cornerRadius:20];
                pictureViewer.name = @"pictureViewer";
                pictureViewer.zPosition = 1;
                pictureViewer.fillColor = [SKColor whiteColor];
                pictureViewer.fillTexture = [SKTexture textureWithImageNamed:[imgs objectAtIndex:index]];
                pictureViewer.position = CGPointMake(width - (pictureViewer.frame.size.width) - 20, height  - (pictureViewer.frame.size.height) - 20);
                [cardView addChild:pictureViewer];
                
                [pictureViewer runAction:[SKAction repeatActionForever:[SKAction sequence:@[
                                                                                            
                                                                                            [SKAction runBlock:^{[pictureViewer setFillTexture:[SKTexture textureWithImageNamed:[imgs objectAtIndex:index]]];}],
                                                                                            [SKAction waitForDuration:2],
                                                                                            [SKAction runBlock:^{[pictureViewer setFillTexture:[SKTexture textureWithImageNamed:@"Agriculture_low"]];}],
                                                                                            [SKAction waitForDuration:2],
                                                                                            [SKAction runBlock:^{[pictureViewer setFillTexture:[SKTexture textureWithImageNamed:@"Auditorium_low"]];}],
                                                                                            [SKAction waitForDuration:2],
                                                                                            [SKAction runBlock:^{[pictureViewer setFillTexture:[SKTexture textureWithImageNamed:@"Gym_low"]];}],
                                                                                            [SKAction waitForDuration:2]
                                                                                            
                                                                                            ]]]];
                
                [self renderTexts:@[@"• Cafeteria named after Fred",
                                    @"Herns who was a graduate in",
                                    @"1961 and first Alum President",
                                    @"• Middleton boasts many",
                                    @"facilities including an",
                                    @"agricultural center",
                                    @"and auditorium"]
                 withInitPosition:CGPointMake(20, test.position.y - 40)];
            }
            
            if([text.text isEqualToString:@"Middleton"])
            {
                [self renderTexts:@[@"• Opened in 1934",
                                    @"• Reopened in 2002 (After being closed in 1971)",
                                    @"• The school burned down in 1944 and 1968",
                                    @"• Closed in 1971 because of Brown v. BoE",
                                    @"• Alma Mater and school colors were chosen before the school opened",
                                    @"• Opened in 1934",
                                    @"• Named after George S. Middleton because he was a respected figure in the area",
                                    @"• The school became a magnet school in 2002 in order to desegregate the area",
                                    @"• Middleton's rivalery with Blake stems from the fact that the schools",
                                    @"were the only two black schools in the area",
                                    @"• Middleton's original location was in a predominately black area",
                                    @"• Middleton's current location was chosen because it had the most area"
                                    ]
                 withInitPosition:CGPointMake(20, test.position.y - 40)];
            }
        }
        
    }
    for(SKShapeNode *obj in showingScreen.children)
    {
        if([[obj.userData allKeys] containsObject:@"previousTexture"])
        {
            obj.fillTexture = [self blurredTextureWithTexture:[obj.userData objectForKey:@"previousTexture"] withBlur:NO];
            [obj childNodeWithName:@"text"].alpha = 0.0;
            [obj.userData removeObjectForKey:@"previousTexture"];
        }
    }
}


@end
