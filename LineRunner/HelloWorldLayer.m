//
//  HelloWorldLayer.m
//  LineRunner
//
//  Created by Apple Air on 06.03.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"
#import "CCAnimate+SequenceLoader.h"

// HelloWorldLayer implementation
@implementation HelloWorldLayer

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
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
        
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        
        //Add background
        CCSprite* background = [CCSprite spriteWithFile:@"bg_static.png"];
        
        background.position = ccp(screenSize.width / 2, screenSize.height / 2);
        
        [self addChild:background];
        
        //Add Move background
        CCSpriteBatchNode* batch = [CCSpriteBatchNode batchNodeWithFile:@"background.png"];
        
        CCSprite* movedBackgroundOne = [CCSprite spriteWithFile:@"background.png"];
        CCSprite* movedBackgroundTwo = [CCSprite spriteWithFile:@"background.png"];
        
        movedBackgroundOne.position = ccp(movedBackgroundOne.contentSize.width / 2, screenSize.height / 2);

        [batch addChild:movedBackgroundOne];
        
        movedBackgroundTwo.position = ccp((movedBackgroundOne.contentSize.width / 2) + movedBackgroundOne.contentSize.width, screenSize.height / 2);
        
        [batch addChild:movedBackgroundTwo];
        
        
        [self addChild:batch z:0 tag:EnumBackground];
        
        [self schedule:@selector(moveBackground) interval:0.04f];
        
		
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"runner.plist"];
        
        CCSprite* sprite = [CCSprite spriteWithSpriteFrameName:@"run_1.png"] ;
        
        sprite.position = ccp(200,70);
        
        
        // with automated determining the number of frames
        
        id repeatRunForever = [CCRepeatForever actionWithAction:
                               [CCAnimate actionWithSpriteSequence:@"run_%d.png"
                                                        delay:0.06f
                                         restoreOriginalFrame:NO]];
        
        [sprite runAction:repeatRunForever];
        
        [self addChild:sprite z:1 tag:EnumRunner];
		
	}
	return self;
}

-(void)moveBackground{
    
    
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
     
    
}

-(void) resetMap:(CCArray *)array{
    
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite* mapOne = (CCSprite*)[array objectAtIndex:0];
    CCSprite* mapTwo = (CCSprite*)[array objectAtIndex:1];
    
    mapOne.position = ccp(mapOne.contentSize.width / 2, screenSize.height / 2);
    
    mapTwo.position = ccp((mapTwo.contentSize.width / 2) + mapOne.contentSize.width, screenSize.height / 2);
    
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
