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
  NSArray * exercisesDescription;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
  
  _exercicesTableView.delegate = self;
  _exercicesTableView.dataSource = self;
  _exercicesTableView.allowsMultipleSelection = false;

  
  exercises = @[@"Breathe in and out",@"Breathing in and vowels", @"Steady flow Line",@"Steady flow Line with Vowels", @"Emotions",@"Decibel feeback",@"decibel feeback with vowels"];
  exercisesDescription = @[@"Inhale and exhale for the specified amount of time",@"Inhale and pronounce the vowel for the specified amount of time", @"Breath in and exhale at different strength", @"Breath in and pronounce the vowel for an amount of time ", @"Pronounces sentences with different emotions",@"Decibel feeback",@"decibel feeback with vowels"];
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

  TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier forIndexPath:indexPath];
  
  cell.cellTitle.text = exercises[indexPath.row];
  cell.cellDescription.text = exercisesDescription[indexPath.row];
  return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

  NSString * exercise = exercises[indexPath.row];

  if([exercise isEqualToString:exercises[0]]) {
    [self performSegueWithIdentifier:@"Breathing" sender:nil];
  }else if([exercise isEqualToString:exercises[1]]){
    [self performSegueWithIdentifier:@"Vowels" sender:nil];
  } else if([exercise isEqualToString:exercises[2]]){
    [self performSegueWithIdentifier:@"SteadyFlowLine" sender:nil];
  } else if([exercise isEqualToString:exercises[3]]){
    [self performSegueWithIdentifier:@"SteadyFlowLineWithVowel" sender:nil];
  }else if([exercise isEqualToString:exercises[4]]){
    [self performSegueWithIdentifier:@"Emotions" sender:nil];
  } else {
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
