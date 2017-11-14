//
//  SteadyFlowLineViewController.m
//  Breathe
//
//  Created by Kevin Amiranoff on 13/11/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import "SteadyFlowLineViewController.h"
#import "JSONHelpers.h"


@interface SteadyFlowLineViewController () {
NSDictionary * exercises;
NSArray * breathingExercise;
NSTimer *inhaleTimer;
NSTimer *exhaleTimer;
int remainingCounts;
int currentInhaleLength;
int currentExhaleValue;
int currentExerciseIndex;
UIColor *inhaleBgColor;
UIColor *exhaleBgColor;
}

@end

@implementation SteadyFlowLineViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  
  NSLog(_exerciceTitle);
  inhaleBgColor = [[UIColor alloc]initWithRed:2.0/255.0 green:132.0/255.0 blue:168.0/255.0 alpha:1.0];
  exhaleBgColor = [[UIColor alloc]initWithRed:255.0/255.0 green:83.0/255.0 blue:13.0/255.0 alpha:1.0];
  
  exercises = [JSONHelpers JSONFromFile:@"exercises"];
  breathingExercise = [exercises valueForKeyPath:@"steadyFlowLine.exercise1"];
  currentExerciseIndex = 0;
  
  [self displayNextExerciseValues];
}

-(void)displayNextExerciseValues {
  int nextInhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"inhale.duration"];
  int nextExhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"exhale.duration"];
  _inhaleTimeLabel.text = [NSString stringWithFormat:@"Inhale time: %d seconds", nextInhaleValue];
  _exhaleTimeLabel.text =  [NSString stringWithFormat:@"Inhale time: %d seconds", nextExhaleValue];
  
}

- (void)onTickInhale
{
  if (--remainingCounts <= -1) {
    [self startTimerExhale:currentExhaleValue];
    self.view.backgroundColor = exhaleBgColor;
    
    
    [inhaleTimer invalidate];
    
  }
  [self changeNumberOnScreen:remainingCounts];
}

- (void)onTickExhale
{
  if (--remainingCounts <= -1) {
    [exhaleTimer invalidate];
    [self onExerciseFinished];
  }
  
  [self changeNumberOnScreen:remainingCounts];
}


-(void)onExerciseFinished {
  _inhaleTimeLabel.hidden = NO;
  _exhaleTimeLabel.hidden = NO;
  currentExerciseIndex = currentExerciseIndex + 1;
  _lblNumberOutlet.hidden = YES;
  _startBreathingLbl.hidden = NO;
  self.view.backgroundColor = [[UIColor alloc]initWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
  
  [self displayNextExerciseValues];
}

- (int)getCurrentExerciseValue:(int)index key:(NSString*)key {
  NSDictionary * currentExercise = [breathingExercise objectAtIndex:index];
  NSNumber * currentValue = [currentExercise valueForKeyPath:key];
  return [currentValue intValue];
}

-(void)changeNumberOnScreen:(int)valueToDisplay {
  NSString * value = [NSString stringWithFormat:@"%d",valueToDisplay];
  _lblNumberOutlet.text = value;
}

-(void)startTimerInhale:(int)count {
  
  inhaleTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                 target:self
                                               selector:@selector(onTickInhale)
                                               userInfo:nil
                                                repeats:YES];
  remainingCounts = count;
}

-(void)startTimerExhale:(int)count  {
  
  exhaleTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                 target:self
                                               selector:@selector(onTickExhale)
                                               userInfo:nil
                                                repeats:YES];
  remainingCounts = count;
}

- (IBAction)startBreathingBtn:(id)sender {
  [sender setHidden:true];
  _descriptionTextOutlet.hidden = YES;
  _lblNumberOutlet.hidden = NO;
  _inhaleTimeLabel.hidden = YES;
  _exhaleTimeLabel.hidden = YES;
  
  int currentInhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"inhale.duration"];
  currentExhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"exhale.duration"];
  self.view.backgroundColor = inhaleBgColor;
  [self changeNumberOnScreen:currentInhaleValue];
  [self startTimerInhale:currentInhaleValue];
}
@end
