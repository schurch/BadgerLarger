//
//  Badger.m
//  BadgerLarger
//
//  Created by Stefan Church on 11/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import "Badger.h"
#include "Coord.h"
#include <stdio.h>

const int POINT_ARRAY_SIZE = 10;

@implementation Badger

+ (NSMutableArray *)generateBadgerList:(NSString *)pathToConfigFile
{
    NSError *error = nil;
    
    NSString *file = [[NSBundle mainBundle] pathForResource:pathToConfigFile ofType:nil];
    
    NSString *fileContents = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:&error];
    
    if(error)
    {
        NSLog(@"ERROR loading config file: %@", [error description]);
    }
    
    NSMutableArray *badgers = [[[NSMutableArray alloc] init] autorelease];
    
    for (NSString *line in [fileContents componentsSeparatedByString:@"\n"]) 
    {
        if (!line || [line length] == 0) 
        {
            continue;
        }
        
        NSString *trimmedString = [line stringByTrimmingCharactersInSet:
                                   [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        if([trimmedString hasPrefix:@"#"])
        {
            continue;
        }
        
        if([trimmedString length] == 0)
        {
            continue;
        }

        NSArray *lineComponents = [trimmedString componentsSeparatedByString:@":"];
        
        NSString *imageName = [lineComponents objectAtIndex:0];
        NSLog(@"Image File name: %@", imageName);
        NSString *imageFilePath = [[NSBundle mainBundle] pathForResource:imageName ofType:nil inDirectory:@"Badgers"];
        
        NSString *thumbName = [lineComponents objectAtIndex:1];
        NSLog(@"Thumb file name: %@", thumbName);
        NSString *thumbFilePath = [[NSBundle mainBundle] pathForResource:thumbName ofType:nil inDirectory:@"Badgers"];
        
        NSString *coords = [lineComponents objectAtIndex:2];        
        NSArray *parsedCoords = [Badger parseCoords:coords];
        
        Badger *badger = [[Badger alloc] initWithPolygon:parsedCoords badgerImagePath:imageFilePath badgerThumbPath:thumbFilePath];
        [badgers addObject:badger];
        [badger release];
        
    }
    
    return badgers;
}

+ (NSMutableArray *)parseCoords:(NSString *)coordsString
{
    NSMutableArray *coords = [[[NSMutableArray alloc] init] autorelease];
    
    bool readingX = true;
    
    char *currentXCoord = (char *)malloc(sizeof(char) * POINT_ARRAY_SIZE);
    char *currentYCoord = (char *)malloc(sizeof(char) * POINT_ARRAY_SIZE);
    
    char *currentXCoordStart = currentXCoord;
    char *currentYCoordStart = currentYCoord;
    
    for (int i = 0; i < [coordsString length]; i++) 
    {
        char character = (char)[coordsString characterAtIndex:i];
        
        switch (character) {
            case '(': //start reading x and y
                break;
            case ')': //finished reading x and y value for 1 coord
                *currentXCoord = '\0';
                *currentYCoord = '\0';
                
                float xCoord = atof(currentXCoordStart);
                float yCoord = atof(currentYCoordStart);
            
                Coord *currentPoint = [[Coord alloc] initWithX:xCoord y:yCoord];              
                [coords addObject:currentPoint];
                [currentPoint release];

                currentXCoord = currentXCoordStart;
                currentYCoord = currentYCoordStart;
                
                memset(currentXCoord, 0, POINT_ARRAY_SIZE);
                memset(currentYCoord, 0, POINT_ARRAY_SIZE);
                
                break;
            case ',': //either ',' between x & y -- (,) -- or  between coord -- ),( --
                readingX = !readingX;
                break;
            default:
                if (readingX) 
                {
                    *currentXCoord = character;
                    currentXCoord++;
                }
                else
                {
                    *currentYCoord = character;
                    currentYCoord++;
                }
                break;
        }
    }
    
    free(currentXCoord);
    free(currentYCoord);
    
    return coords;
}

- (id)initWithPolygon:(NSArray *)polygon badgerImagePath:(NSString *)imagePath badgerThumbPath:(NSString *)thumbPath
{
    self = [super init];
    
    if (self) 
    {
        [polygon retain];
        badgerOutlinePolygon = polygon;
        
        [imagePath retain];
        badgerImagePath = imagePath;
        
        [thumbPath retain];
        badgerThumbImagePath = thumbPath;
    }
    
    return self;
}

- (NSArray *)badgerOutlinePolygon
{
    return badgerOutlinePolygon;
}

- (NSString *)badgerImagePath
{
    return badgerImagePath;    
}

- (NSString *)badgetThumbPath
{
    return badgerThumbImagePath;
}

- (void)dealloc
{
    [badgerOutlinePolygon release];
    [badgerImagePath release];
    [badgerThumbImagePath release];
    [super dealloc];
}

@end
