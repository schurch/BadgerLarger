//
//  Badger.h
//  BadgerLarger
//
//  Created by Stefan Church on 11/09/2011.
//  Copyright 2011 Stefan Church. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Badger : NSObject {
    NSMutableArray *_badgerOutlinePolygon;
    NSString *_badgerImagePath;
    NSString *_badgerThumbImagePath;
}

@property (nonatomic, readonly) NSArray *badgerOutlinePolygon;
@property (nonatomic, readonly) NSString *badgerImagePath;
@property (nonatomic, readonly) NSString *badgetThumbPath;

- (id)initWithPolygon:(NSMutableArray *)polygon badgerImagePath:(NSString *)imagePath badgerThumbPath:(NSString *)thumbPath;

+ (NSMutableArray *)generateBadgerList:(NSString *)pathToConfigFile;
+ (NSMutableArray *)parseVertices:(NSString *)verticesString;

@end
