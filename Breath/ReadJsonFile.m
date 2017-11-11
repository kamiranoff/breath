//
//  ReadJsonFile.m
//  Breath
//
//  Created by Kevin Amiranoff on 11/11/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReadJsonFile.h"

@interface ReadJsonFile ()

@end

@implementation ReadJsonFile


+ (NSDictionary *)JSONFromFile:(NSString *) fileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end
