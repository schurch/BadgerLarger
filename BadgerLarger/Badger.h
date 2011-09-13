//
//  Badger.h
//  BadgerLarger
//
//  Created by Stefan Church on 11/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Badger : NSObject {
    NSMutableArray *badgerOutlinePolygon;
    NSString *badgerImagePath;
    NSString *badgerThumbImagePath;
}

- (id)initWithPolygon:(NSMutableArray *)polygon badgerImagePath:(NSString *)imagePath badgerThumbPath:(NSString *)thumbPath;

@property (nonatomic, readonly) NSArray *badgerOutlinePolygon;
@property (nonatomic, readonly) NSString *badgerImagePath;
@property (nonatomic, readonly) NSString *badgetThumbPath;

+ (NSMutableArray *)generateBadgerList:(NSString *)pathToConfigFile;
//Expects coords string of the following format: (x,y),(x,y),... with no spaces
+ (NSMutableArray *)parseVertices:(NSString *)verticesString;

@end
