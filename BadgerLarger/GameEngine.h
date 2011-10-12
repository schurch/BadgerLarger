//
//  GameEngine.h
//  BadgerLarger
//
//  Created by Stefan Church on 09/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    GameEngineWonAndFinished,
    GameEngineFinished,        
    GameEngineWon,
    GameEngineLost,
    GameEngineNotStarted
} GameEngineState;

@interface GameEngine : NSObject {
    BOOL gameFinished;
    int attempts;
    int score;
    GameEngineState gameStatus;
}

@property (readonly) BOOL gameFinished;
@property (nonatomic) GameEngineState gameStatus;
@property (nonatomic, readonly) NSString *scoreText;

- (id)init;
- (void)didWin:(BOOL)didWin;
- (void)reset;

@end
