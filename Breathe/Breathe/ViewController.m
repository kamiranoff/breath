//
//  ViewController.m
//  Breathe
//
//  Created by Kevin Amiranoff on 12/11/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "BreathingViewController.h"
#import "SteadyFlowLineViewController.h"

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
  
  if([exercise isEqualToString:@"Breathing"]) {
    [self performSegueWithIdentifier:@"Breathing" sender:nil];
  } else if([exercise isEqualToString:@"steadyFlowLine"]){
    [self performSegueWithIdentifier:@"SteadyFlowLine" sender:nil];
  }else {
    [self performSegueWithIdentifier:@"Breathing" sender:nil];

  }
}

// This will get called too before the view appears
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  
    BreathingViewController *breathingVC = [segue destinationViewController];
    SteadyFlowLineViewController *steadyVc = [segue destinationViewController];
  
  if ([[segue identifier] isEqualToString:@"Breathing"]) {
    // Get destination view
    breathingVC.exerciceTitle = @"Breathing";
  }else if([[segue identifier] isEqualToString:@"SteadyFlowLine"]) {
    steadyVc.exerciceTitle = @"SteadyFlowLine";
  }
}

@end
