//
//  ViewController.m
//  Breathe
//
//  Created by Kevin Amiranoff on 12/11/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "BreathingViewController.h"
#import "SteadyFlowLineViewController.h"

@interface ViewController () {
  NSArray * exercises;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
  _exercicesTableView.delegate = self;
  _exercicesTableView.dataSource = self;
  _exercicesTableView.allowsMultipleSelection = false;

  
  exercises = @[@"Breathing", @"steadyFlowLine",@"steadyFlowLineWithVowels",@"decibelFeedback",@"decibelFeedbackWithVowels"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  // Number of rows is the number of time zones in the region for the specified section.
  return exercises.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  static NSString *MyIdentifier = @"Cell";

  TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
  
  if (cell == nil) {
    cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
  }

  cell.textLabel.text = exercises[indexPath.row];
  return cell;
}


//
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//  CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//
//  cell.lblCellLabel.text = exercises[indexPath.row];
//  return cell;
//}
//

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  NSString * exercise = exercises[indexPath.row];

  if([exercise isEqualToString:@"Breathing"]) {
    [self performSegueWithIdentifier:@"Breathing" sender:nil];
  } else if([exercise isEqualToString:@"steadyFlowLine"]){
    [self performSegueWithIdentifier:@"SteadyFlowLine" sender:nil];
  } else if([exercise isEqualToString:@"steadyFlowLineWithVowels"]){
    [self performSegueWithIdentifier:@"SteadyFlowLineWithVowel" sender:nil];
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
