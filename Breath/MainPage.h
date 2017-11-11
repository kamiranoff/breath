//
//  MainPage.h
//  Breath
//
//  Created by Kevin Amiranoff on 11/11/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainPage : UICollectionViewController <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, retain) IBOutlet UICollectionView *myCollectionView;

@end
