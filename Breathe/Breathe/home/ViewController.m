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

  
  exercises = @[
                @"Breathing in and out",
                @"Connection of breathing to voicing",
                @"Volume control",
                @"Volume control of Vowels",
                @"Intonation",
                @"Pitch exploration",
                @"Beatboxing"
                ];
  exercisesDescription = @[
                           @"Inhale and exhale following the timing",
                           @"Inhale and say the vowels following the timing",
                           @"Inhale and exhale following the steady flow line",
                           @"Inhale and say the vowels following the steady flow line",
                           @"Basic acting exercise to practise intonation",
                           @"Explore the pitch of your voice",
                           @"Imitate the sound of the instrument"];
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
  }else if([exercise isEqualToString:exercises[5]]){
    [self performSegueWithIdentifier:@"Pitch" sender:nil];
  }else if([exercise isEqualToString:exercises[6]]){
    [self performSegueWithIdentifier:@"Instruments" sender:nil];
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
