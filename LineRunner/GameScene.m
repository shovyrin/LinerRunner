//
//  HelloWorldLayer.m
//  LineRunner
//
//  Created by Apple Air on 06.03.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "GameScene.h"
#import "CCAnimate+SequenceLoader.h"

// HelloWorldLayer implementation
@implementation GameScene

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	GameScene *layer = [GameScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init])) {
        
        isJump = NO;
        velocity = 7;
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        //Add background
        CCSprite* background = [CCSprite spriteWithFile:@"sky.png"];
        
        background.position = ccp(screenSize.width / 2, screenSize.height / 2);
        
        [self addChild:background z:0 tag:EnumClouds];
        
        
        //Add Move background
        /*
        CCSpriteBatchNode* batch = [CCSpriteBatchNode batchNodeWithFile:@"bridge.png"];
        
        CCSprite* movedBackgroundOne = [CCSprite spriteWithFile:@"bridge.png"];
        CCSprite* movedBackgroundTwo = [CCSprite spriteWithFile:@"bridge.png"];
        */
        
        CCSprite* movedBackgroundOne = [CCSprite spriteWithFile:@"bridge.png"];
        CCSprite* movedBackgroundTwo = [CCSprite spriteWithFile:@"bridge_2.png"];
        CCSprite* movedBackgroundThree = [CCSprite spriteWithFile:@"bridge_3.png"];
        CCSprite* movedBackgroundFour = [CCSprite spriteWithFile:@"bridge_4.png"];
        
        movedBackgroundOne.position = ccp(movedBackgroundOne.contentSize.width / 2, screenSize.height / 2);

        //[batch addChild:movedBackgroundOne];
        
        movedBackgroundTwo.position = ccp((movedBackgroundOne.contentSize.width / 2) + movedBackgroundOne.contentSize.width, screenSize.height / 2);
        
        movedBackgroundThree.position = ccp((movedBackgroundTwo.contentSize.width / 2) + (movedBackgroundTwo.contentSize.width*2), screenSize.height / 2);
        
        movedBackgroundFour.position = ccp((movedBackgroundTwo.contentSize.width / 2) + (movedBackgroundTwo.contentSize.width*3), screenSize.height / 2);
        
        [self addChild:movedBackgroundOne z:1 tag:100];
        [self addChild:movedBackgroundTwo z:1 tag:101];
        [self addChild:movedBackgroundThree z:1 tag:103];
        [self addChild:movedBackgroundFour z:1 tag:104];
        
       // [batch addChild:movedBackgroundTwo];
        
        
        //[self addChild:batch z:1 tag:EnumBackground];
        
        [self schedule:@selector(moveBackground) interval:0.04f];
        [self schedule:@selector(moveClouds) interval:0.05f];
        
		
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"runner.plist"];
        
        CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:@"run_1.png"] ;
        
        sprite.position = ccp(90,140);
        
        
        // with automated determining the number of frames
        
        id repeatRunForever = [CCRepeatForever actionWithAction:
                               [CCAnimate actionWithSpriteSequence:@"run_%d.png"
                                                        delay:0.06f
                                         restoreOriginalFrame:NO]];
        
        [sprite runAction:repeatRunForever];
        
        [self addChild:sprite z:2 tag:EnumRunner];
        
        self.isTouchEnabled = YES;
		
	}
	return self;
}

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if (isJump == NO) {
           [self schedule:@selector(heroJump)];
    }
    
}

-(void) heroJump{
    
    isJump = YES;

    if (jumpDistance == 12) {
        velocity *= -1;
    }
    
    jumpDistance ++;
        
    CCNode* node = [self getChildByTag:EnumRunner];
        
    NSAssert([node isKindOfClass:[CCSprite class]], @"This not a sprite class");
        
    CCSprite *heroSprite = (CCSprite*)node;
    
    heroSprite.position = ccp(heroSprite.position.x, heroSprite.position.y + velocity);
    
    if (heroSprite.position.y == 140) {
        jumpDistance = 0;
        isJump = NO;
        velocity *= -1;
        [self unschedule:@selector(heroJump)];     
    }
    
}

-(void)moveBackground{
    
    /*
    
    CCArray* mapArray = [self.mapSpriteBatch children];
    
    for (int i = 0; i < 2; i++) {
        
        CCNode* node = [mapArray objectAtIndex:i];
        NSAssert([node isKindOfClass:[CCSprite class]], @"not a CCSprite");
        
        CCSprite *moveBg = (CCSprite*) node;

            float coordX = moveBg.position.x;
            if (coordX == (moveBg.contentSize.width / 2) && i == 1) {
                
                [self resetMap:mapArray];
                break;
            }

        
        float x = moveBg.position.x - 10;
        float y = moveBg.position.y;
        
        moveBg.position = ccp(x, y);  
        
    }
     
     */
    
    CCSprite* bg_node_one = (CCSprite*)[self getChildByTag:100];
    
    float x = bg_node_one.position.x - 10;
    float y = bg_node_one.position.y;
    
    bg_node_one.position = ccp(x, y); 
    
    CCSprite* bg_node_two = (CCSprite*)[self getChildByTag:101];
    
    x = bg_node_two.position.x - 10;
    y = bg_node_two.position.y;
    
    bg_node_two.position = ccp(x, y);
    
    
    CCSprite* bg_node_three = (CCSprite*)[self getChildByTag:103];
    
    x = bg_node_three.position.x - 10;
    y = bg_node_three.position.y;
    
    bg_node_three.position = ccp(x, y);
    
    CCSprite* bg_node_four = (CCSprite*)[self getChildByTag:104];
    
    x = bg_node_four.position.x - 10;
    y = bg_node_four.position.y;
    
    bg_node_four.position = ccp(x, y);
    
}

-(void) moveClouds{
    
    CCNode* node = [self getChildByTag:EnumClouds];
    
    float x = node.position.x;
    
    float delta = [node contentSize].width + x;
    
    if (delta > 0) {
    
        node.position = ccp(x - 0.10, node.position.y);
        
    }
    else
    {
        [self resetClouds];
    }
    
}

-(void) resetMap:(CCArray *)array{
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite* mapOne = (CCSprite*)[array objectAtIndex:0];
    CCSprite* mapTwo = (CCSprite*)[array objectAtIndex:1];
    
    mapOne.position = ccp(mapOne.contentSize.width / 2, screenSize.height / 2);
    
    mapTwo.position = ccp((mapTwo.contentSize.width / 2) + mapOne.contentSize.width, screenSize.height / 2);
    
}

-(void) resetClouds{
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCNode* node = [self getChildByTag:EnumClouds];
    
    node.position = ccp(screenSize.width / 2, screenSize.height / 2);
    
}

//найдем элементы с тегом GameSceneNodeTagBulletSpriteBatch
-(CCSpriteBatchNode*) mapSpriteBatch
{
	CCNode* node = [self getChildByTag:EnumBackground];
    //проверили класс CCSpriteBatchNode ли
	NSAssert([node isKindOfClass:[CCSpriteBatchNode class]], @"not a CCSpriteBatchNode");
    
    //вернули массив пуль
	return (CCSpriteBatchNode*)node;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
