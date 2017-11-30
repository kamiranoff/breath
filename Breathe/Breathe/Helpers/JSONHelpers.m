//
//  JSONHelpers.m
//  Breathe
//
//  Created by Kevin Amiranoff on 12/11/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONHelpers.h"

@interface JSONHelpers ()

@end

@implementation JSONHelpers


+ (NSDictionary *)JSONFromFile:(NSString *) fileName
{
  NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"json"];
  NSData *data = [NSData dataWithContentsOfFile:path];
  return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end
