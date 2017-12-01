//
//  Pitch.m
//  Breathe
//
//  Created by Kevin Amiranoff on 01/12/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import "Pitch.h"
#import "JSONHelpers.h"

@interface Pitch () {
  int currentExerciseIndex;
  UIColor * inhaleBgColor;
  NSArray * pitchExercise;
  int remainingCounts;
  NSTimer * inhaleTimer;
  NSTimer * exhaleTimer;
  int currentExhaleValue;
  NSArray * colors;
}

@end

@implementation Pitch

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  
  inhaleBgColor = [[UIColor alloc]initWithRed:2.0/255.0 green:132.0/255.0 blue:168.0/255.0 alpha:1.0];
  NSDictionary * exercises = [JSONHelpers JSONFromFile:@"exercises"];
  pitchExercise = [exercises valueForKeyPath:@"vowelsWithColors.exercise1"];
  currentExerciseIndex = 0;
  [self displayNextExerciseValues:currentExerciseIndex];
  _colorsStackView.hidden = YES;
  _lettersStackView.hidden= YES;
  _red.text = @"";
  _pink.text = @"";
  _yellow.text = @"";
  _green.text = @"";
  _blue.text = @"";
  _purple.text = @"";
  _lila.text = @"";
}

-(void)displayNextExerciseValues:(int)exerciseIndex {
  int nextInhaleValue = [self getCurrentExerciseValue:exerciseIndex exercise:pitchExercise key:@"inhale"];
  int nextExhaleValue = [self getCurrentExerciseValue:exerciseIndex exercise:pitchExercise key:@"exhale"];
  NSString * nextVowelValue = [self getCurrentExerciseStringValue:exerciseIndex exercise:pitchExercise key:@"vowel"];
  _inhileTimeLbl.text = [NSString stringWithFormat:@"Inhale time: %d seconds", nextInhaleValue];
  _exhaleTimeLabel.text =  [NSString stringWithFormat:@"Exhale time: %d seconds", nextExhaleValue];
  _vowelLbl.text =  [NSString stringWithFormat:@"Vowel: %@", nextVowelValue];
}

- (int)getCurrentExerciseValue:(int)index exercise:(NSArray *)exercise key:(NSString*)key {
  NSDictionary * currentExercise = [exercise objectAtIndex:index];
  NSNumber * currentValue = [currentExercise objectForKey:key];
  return [currentValue intValue];
}

- (NSString *)getCurrentExerciseStringValue:(int)index exercise:(NSArray *)exercise key:(NSString*)key {
  NSDictionary * currentExercise = [exercise objectAtIndex:index];
  NSString * currentValue = [currentExercise objectForKey:key];
  return currentValue;
}

- (NSArray *)getCurrentExerciseArrayValue:(int)index exercise:(NSArray *)exercise key:(NSString*)key {
  NSDictionary * currentExercise = [exercise objectAtIndex:index];
  NSArray * currentValue = [currentExercise objectForKey:key];
  return currentValue;
}

-(void)changeNumberOnScreen:(int)valueToDisplay {
  NSString * value = [NSString stringWithFormat:@"%d",valueToDisplay];
  _inhaleCountNumber.text = value;
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

- (void)onTickInhale
{
  if (--remainingCounts <= 0) {
    _lettersStackView.hidden = NO;
    [self startTimerExhale:currentExhaleValue];
    self.view.backgroundColor = [UIColor whiteColor];
    self.inhaleCountNumber.hidden = YES;
    _colorsStackView.hidden = NO;
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
  [self displayPitch:remainingCounts];
}

-(void)displayPitch:(int)index{
  NSString * pitchColor = [self getPitchColor:index];
 
  if([pitchColor  isEqual: @"red"]) {
    _red.backgroundColor = [UIColor redColor];
    _red.text = @"E";
    return;
  }
  
  if([pitchColor  isEqual: @"pink"]) {
    _pink.backgroundColor = [UIColor magentaColor];
    _pink.text = @"E";
    return;
  }
  
  if([pitchColor  isEqual: @"yellow"]) {
    _yellow.backgroundColor = [UIColor yellowColor];
    _yellow.text = @"E";
    return;
  }
  
  if([pitchColor  isEqual: @"green"]) {
    _green.backgroundColor = [UIColor greenColor];
    _green.text = @"E";
    return;
  }
  
  if([pitchColor  isEqual: @"blue"]) {
    _blue.backgroundColor = [UIColor blueColor];
    _blue.text = @"E";
    return;
  }
  
  if([pitchColor  isEqual: @"purple"]) {
    _purple.backgroundColor = [UIColor purpleColor];
    _purple.text = @"E";
    return;
  }
  
  if([pitchColor  isEqual: @"lila"]) {
    _lila.backgroundColor = [UIColor orangeColor];
    _lila.text = @"E";
    return;
  }
  

}

-getPitchColor:(int)index{
  NSArray * pitchColors =  [self getCurrentExerciseArrayValue:currentExerciseIndex exercise:pitchExercise key:@"pitchColor"];
  return pitchColors[index];
 
}

-(void) onExerciseFinished {
  currentExerciseIndex++;
  
  _colorsStackView.hidden = YES;
  _inhileTimeLbl.hidden=NO;
  _exhaleTimeLabel.hidden=NO;
  _startButtonLbl.hidden=NO;
  _vowelLbl.hidden = NO;

  [self displayNextExerciseValues:currentExerciseIndex];
}

- (IBAction)startButton:(id)sender {
    [sender setHidden:true];
  _exerciseDescription.hidden = YES;
  _inhileTimeLbl.hidden = YES;
  _exhaleTimeLabel.hidden = YES;
  _vowelLbl.hidden = YES;
  _navigation.hidden = YES;
  _inhaleCountNumber.hidden = NO;

  int currentInhaleValue = [self getCurrentExerciseValue:currentExerciseIndex exercise:pitchExercise key:@"inhale"];
  currentExhaleValue = [self getCurrentExerciseValue:currentExerciseIndex exercise:pitchExercise key:@"exhale"];
  self.view.backgroundColor = inhaleBgColor;
  [self changeNumberOnScreen:currentInhaleValue];
  [self startTimerInhale:currentInhaleValue];
}

- (IBAction)backButton:(id)sender {
  [self dismissViewControllerAnimated:true completion:nil];

}
@end
