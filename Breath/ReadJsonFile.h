//
//  ReadJsonFile.h
//  Breath
//
//  Created by Kevin Amiranoff on 11/11/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#ifndef ReadJsonFile_h
#define ReadJsonFile_h

@interface ReadJsonFile : NSObject

+ (NSDictionary *)JSONFromFile:(NSString *) fileName;

@end

#endif /* ReadJsonFile_h */
