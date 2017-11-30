//
//  Breathing.m
//  Breathe
//
//  Created by Kevin Amiranoff on 12/11/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import "BreathingViewController.h"
#import "JSONHelpers.h"

@interface BreathingViewController () {
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

@implementation BreathingViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
  inhaleBgColor = [[UIColor alloc]initWithRed:2.0/255.0 green:132.0/255.0 blue:168.0/255.0 alpha:1.0];
  exhaleBgColor = [[UIColor alloc]initWithRed:239.0/255.0 green:82.0/255.0 blue:91.0/255.0 alpha:1.0];

  exercises = [JSONHelpers JSONFromFile:@"exercises"];
  breathingExercise = [exercises objectForKey:@"breathing"];
  currentExerciseIndex = 0;
  
  [self displayNextExerciseValues];
  }


-(void)displayNextExerciseValues {
  int nextInhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"inhale"];
  int nextExhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"exhale"];
  _inhaleTimeLabel.text = [NSString stringWithFormat:@"Inhale time: %d seconds", nextInhaleValue];
  _exhaleTimeLabel.text =  [NSString stringWithFormat:@"Exhale time: %d seconds", nextExhaleValue];
  
}

- (void)onTickInhale
{
  // remainingCounts = remainingCounts - 1;
  if (--remainingCounts <= 0) {
    [self startTimerExhale:currentExhaleValue];
    self.view.backgroundColor = exhaleBgColor;

    
  [inhaleTimer invalidate];
    
  }
  [self changeNumberOnScreen:remainingCounts];
}

- (void)onTickExhale
{
  if (--remainingCounts <= 0) {
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
  NSNumber * currentValue = [currentExercise objectForKey:key];
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
 
  int currentInhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"inhale"];
  currentExhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"exhale"];
  self.view.backgroundColor = inhaleBgColor;
  [self changeNumberOnScreen:currentInhaleValue];
  [self startTimerInhale:currentInhaleValue];
}

- (IBAction)backBtn:(id)sender {
}
@end
