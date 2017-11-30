//
//  CollectionViewCell.m
//  Breathe
//
//  Created by Kevin Amiranoff on 12/11/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell


-(void)configureCell:(NSString * )title desc:(NSString *)description {
  _cellTitle.text = title;
  _cellDescription.text = description;
}

@end
