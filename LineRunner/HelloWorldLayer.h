//
//  HelloWorldLayer.h
//  LineRunner
//
//  Created by Apple Air on 06.03.12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

typedef enum{
    
    EnumRunner = 0,
    EnumBackground
    
}TargetName;

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
-(void)moveBackground;
-(CCSpriteBatchNode*) mapSpriteBatch;
-(void) resetMap:(CCArray*) array;

@end
