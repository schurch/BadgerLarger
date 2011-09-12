//
//  GameEngine.m
//  BadgerLarger
//
//  Created by Stefan Church on 09/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import "GameEngine.h"

#define MAX_ATTEMPTS 5
#define SCORE_TEXT "%d"
#define ATTEMPTS_TEXT "%d/%d"

@implementation GameEngine

@synthesize gameStatus;

- (BOOL)gameFinished
{
    if((self.gameStatus == GameEngineFinished) || (self.gameStatus == GameEngineWonAndFinished))
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
}

- (NSString *)scoreText
{
    return [NSString stringWithFormat:@SCORE_TEXT, score];
}

- (NSString *)attemptsText
{
    return [NSString stringWithFormat:@ATTEMPTS_TEXT, attempts, MAX_ATTEMPTS];
}

- (id)init
{
    self = [super init];
    
    if (self) 
    {
        attempts = 0;
        score = 0;
        self.gameStatus = GameEngineNotStarted;
    }
    
    return self;
}


- (void)didWin:(BOOL)didWin
{
    if (didWin) 
    {
        score = score + 1;
        self.gameStatus = GameEngineWon;
    }
    else
    {
        self.gameStatus = GameEngineLost;
    }
    
    attempts = attempts + 1;
    if (attempts == MAX_ATTEMPTS) 
    {
        if (didWin) 
        {
            self.gameStatus = GameEngineWonAndFinished;
        }
        else
        {
            self.gameStatus = GameEngineFinished;
        }
    } 
}

- (void)reset
{
    attempts = 0;
    score = 0;
    self.gameStatus = GameEngineNotStarted;
}

@end
