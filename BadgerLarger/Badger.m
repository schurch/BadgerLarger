//
//  Badger.m
//  BadgerLarger
//
//  Created by Stefan Church on 11/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import "Badger.h"
#include "Vertex.h"
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
    
    NSMutableArray *badgers = [[NSMutableArray alloc] init];
    
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
        
        NSString *vertices = [lineComponents objectAtIndex:2];        
        NSMutableArray *parsedCoords = [Badger parseVertices:vertices];
        
        Badger *badger = [[Badger alloc] initWithPolygon:parsedCoords badgerImagePath:imageFilePath badgerThumbPath:thumbFilePath];
        [badgers addObject:badger];
        [badger release];
    }
    
    return [badgers autorelease];
}

+ (NSMutableArray *)parseVertices:(NSString *)verticesString
{
    NSMutableArray *vertices = [[NSMutableArray alloc] init];
    
    bool readingX = true;
    
    char *currentX = (char *)malloc(sizeof(char) * POINT_ARRAY_SIZE);
    char *currentY = (char *)malloc(sizeof(char) * POINT_ARRAY_SIZE);
    
    char *currentXPointer = currentX;
    char *currentYPointer = currentY;
    
    for (int i = 0; i < [verticesString length]; i++) 
    {
        char character = (char)[verticesString characterAtIndex:i];
        
        switch (character) {
            case '(': //start reading x and y
                break;
            case ')': //finished reading x and y value for 1 coord
                *currentX = '\0';
                *currentY = '\0';
                
                float x = atof(currentXPointer);
                float y = atof(currentYPointer);
            
                Vertex *currentPoint = [[Vertex alloc] initWithX:x y:y];              
                [vertices addObject:currentPoint];
                [currentPoint release];

                currentX = currentXPointer;
                currentY = currentYPointer;
                
                memset(currentX, 0, POINT_ARRAY_SIZE);
                memset(currentY, 0, POINT_ARRAY_SIZE);
                
                break;
            case ',': //either ',' between x & y -- (,) -- or  between coord -- ),( --
                readingX = !readingX;
                break;
            default:
                if (readingX) 
                {
                    *currentX = character;
                    currentX++;
                }
                else
                {
                    *currentY = character;
                    currentY++;
                }
                break;
        }
    }
    
    free(currentX);
    free(currentY);
    
    return [vertices autorelease];
}

- (id)initWithPolygon:(NSMutableArray *)polygon badgerImagePath:(NSString *)imagePath badgerThumbPath:(NSString *)thumbPath
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
