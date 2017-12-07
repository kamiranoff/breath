//
//  Breathing.m
//  Breathe
//
//  Created by Kevin Amiranoff on 12/11/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import "Vowels.h"
#import "JSONHelpers.h"

@interface Vowels () {
  NSDictionary * exercises;
  NSArray * vowelsExercise;
  NSTimer *inhaleTimer;
  NSTimer *exhaleTimer;
  int remainingCounts;
  int currentInhaleLength;
  int currentExhaleValue;
  NSString * currentVowel;
  int currentExerciseIndex;
  UIColor *inhaleBgColor;
  UIColor *exhaleBgColor;
}

@end

@implementation Vowels

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  inhaleBgColor = [[UIColor alloc]initWithRed:2.0/255.0 green:132.0/255.0 blue:168.0/255.0 alpha:1.0];
  exhaleBgColor = [[UIColor alloc]initWithRed:239.0/255.0 green:82.0/255.0 blue:91.0/255.0 alpha:1.0];
  
  exercises = [JSONHelpers JSONFromFile:@"exercises"];
  vowelsExercise = [exercises objectForKey:@"vowels"];
  currentExerciseIndex = 0;
  
  [self displayNextExerciseValues];
}


-(void)displayNextExerciseValues {
  int nextInhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"inhale"];
  int nextExhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"exhale"];
  NSString * nextExhaleVowel = [self getCurrentExerciseStringValue:currentExerciseIndex key:@"vowel"];
  _inhaleTimeLabel.text = [NSString stringWithFormat:@"Inhale for %d seconds", nextInhaleValue];
  _exhaleTimeLabel.text =  [NSString stringWithFormat:@"Exhale for %d seconds", nextExhaleValue];
  _exhaleVowelLabel.text =  [NSString stringWithFormat:@"Vowel: %@", nextExhaleVowel];
  
}

- (void)onTickInhale
{
  // remainingCounts = remainingCounts - 1;
  if (--remainingCounts <= 0) {
    self.view.backgroundColor = exhaleBgColor;
    _exhaleVowel.hidden = NO;
    _exhaleNumberlbl.hidden = NO;
    _lblNumberOutlet.hidden = YES;
    [self startTimerExhale:currentExhaleValue];

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
  
  [self changeExhaleValuesOnScreen:remainingCounts];
}


-(void)onExerciseFinished {
  currentExerciseIndex = currentExerciseIndex + 1;
  _inhaleTimeLabel.hidden = NO;
  _exhaleTimeLabel.hidden = NO;
  _exhaleVowelLabel.hidden = NO;
  _lblNumberOutlet.hidden = YES;
  _startBreathingLbl.hidden = NO;
  _exhaleNumberlbl.hidden = YES;
  _exhaleVowel.hidden = YES;
  _navigation.hidden = NO;
  self.view.backgroundColor = [[UIColor alloc]initWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
  
  [self displayNextExerciseValues];
}

- (int)getCurrentExerciseValue:(int)index key:(NSString*)key {
  NSDictionary * currentExercise = [vowelsExercise objectAtIndex:index];
  NSNumber * currentValue = [currentExercise objectForKey:key];
  return [currentValue intValue];
}

- (NSString *)getCurrentExerciseStringValue:(int)index key:(NSString*)key {
  NSDictionary * currentExercise = [vowelsExercise objectAtIndex:index];
  NSString * currentValue = [currentExercise objectForKey:key];
  return currentValue;
}

-(void)changeNumberOnScreen:(int)valueToDisplay {
  NSString * value = [NSString stringWithFormat:@"%d",valueToDisplay];
 _lblNumberOutlet.text = value;
}

-(void)changeExhaleValuesOnScreen:(int)valueToDisplay {
  NSString * value = [NSString stringWithFormat:@"%d",valueToDisplay];
  _exhaleNumberlbl.text = value;
  _exhaleVowel.text = currentVowel;
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
  _exhaleNumberlbl.hidden = NO;
}

- (IBAction)startBreathingBtn:(id)sender {
  
  int currentInhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"inhale"];
  currentExhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"exhale"];
  currentVowel = [self getCurrentExerciseStringValue:currentExerciseIndex key:@"vowel"];
  self.view.backgroundColor = inhaleBgColor;
  [self changeExhaleValuesOnScreen:currentExhaleValue];
  [self changeNumberOnScreen:currentInhaleValue];
  [self startTimerInhale:currentInhaleValue];
  
  [sender setHidden:true];
  _descriptionTextOutlet.hidden = YES;
  _lblNumberOutlet.hidden = NO;
  _inhaleTimeLabel.hidden = YES;
  _exhaleTimeLabel.hidden = YES;
  _exhaleNumberlbl.hidden = YES;
  _exhaleVowelLabel.hidden = YES;
  _navigation.hidden = YES;
  _exhaleVowel.hidden = YES;
  

}

- (IBAction)backButton:(id)sender {
  [self dismissViewControllerAnimated:true completion:nil];
}
@end

