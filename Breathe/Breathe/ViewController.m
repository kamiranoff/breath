//
//  ViewController.m
//  Breathe
//
//  Created by Kevin Amiranoff on 12/11/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"


@interface ViewController () {
  NSArray * exercises;
}
@end

@implementation ViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
  _exercicesCollectionView.delegate = self;
  _exercicesCollectionView.dataSource = self;
  _exercicesCollectionView.allowsMultipleSelection = false;

  
  exercises = @[@"Breathing", @"steadyFlowLine",@"steadyFlowLineWithVowels",@"decibelFeedback",@"decibelFeedbackWithVowels"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  return exercises.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
  
  cell.lblCellLabel.text = exercises[indexPath.row];
  return cell;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
  
  NSString * exercise = exercises[indexPath.row];
    
  [self performSegueWithIdentifier:@"BreathingViewController" sender:self];
  
}

@end
