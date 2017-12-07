//
//  Instruments.m
//  Breathe
//
//  Created by Kevin Amiranoff on 04/12/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import "Instruments.h"
#import "JSONHelpers.h"
#include <stdlib.h>

@interface Instruments () {
  bool hasExerciseStarted;
  bool hasExerciseFinished;
  NSDictionary * exercises;
  NSDictionary * instrumentsExercise;
  int instrumentsIndex;
  int soundsIndex;
  NSArray * instruments;
  NSString * currentInstrument;
  NSArray * currentInstrumentSound;
  NSTimer *musicTimer;

}

@end

@implementation Instruments

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  _picture.hidden = YES;
  _sentence.hidden = YES;
  
  hasExerciseStarted = NO;
  
  exercises = [JSONHelpers JSONFromFile:@"exercises"];
  instrumentsExercise = [exercises objectForKey:@"instruments"];
  instruments = @[@"drumsticks",@"hi-hat",@"kickdrum",@"snare",@"cymbal"];
  instrumentsIndex = 0;
  soundsIndex = 0;
  
  currentInstrument = [self getCurrentInstrument:instrumentsIndex];
  currentInstrumentSound = [self getInstrumentSounds:currentInstrument];
  
  NSLog(@"%@", currentInstrumentSound);
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(NSString *)getCurrentInstrument:(int)currentInstrumentIndex {
  return instruments[currentInstrumentIndex];
}

-(NSArray *)getInstrumentSounds:(NSString *)instrument {
  NSArray * instrumentSounds = [instrumentsExercise objectForKey:instrument];
  return instrumentSounds;
}

- (void)onStartExercise:(NSString *)instrument {
  _picture.hidden = NO;
  _sentence.hidden = NO;
  _navigation.hidden = YES;
  _descriptionLbl.hidden = YES;
  hasExerciseStarted = YES;
}

-(NSString *)getInstument:(int)index{
  return instruments[index];
}

-(void) handleExerciseProgress {
  int instrumentIndex = arc4random_uniform(4);
  int randomTimeValue = arc4random_uniform(2);
  NSString * currentInstrument = [self getCurrentInstrument:instrumentIndex];
  NSArray * currentInstrumentSound = [self getInstrumentSounds:currentInstrument];
  int soundLength = (int)currentInstrumentSound.count - 1;
  int instrumentSoundsIndex = arc4random_uniform(soundLength);
 // if(randomTimeValue == 1) {
    _sentence.text = currentInstrumentSound[instrumentSoundsIndex];
    _picture.image = [UIImage imageNamed:currentInstrument];
    _picture.alpha = 1.0f;
    _sentence.alpha = 1.0f;
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionAutoreverse
                     animations:^ {
                       [UIView setAnimationRepeatCount:1.0f/2.0f];
                       _picture.alpha = 0.4f;
                       _sentence.alpha = 0.4f;
                     } completion:^(BOOL finished) {
                       _picture.alpha = 1.0f;
                       _sentence.alpha = 1.0f;
                       
                     }];
//  }

  
  }

-(void) handleExerciseFinished {
  _picture.hidden = YES;
  _sentence.hidden = YES;
  _navigation.hidden = NO;
  _descriptionLbl.hidden = NO;
  _descriptionLbl.text = @"Well Done !";
  
  hasExerciseFinished = YES;
}

-(void)startTimerMusic {
  musicTimer = [NSTimer scheduledTimerWithTimeInterval:1.2
                                                 target:self
                                               selector:@selector(handleExerciseProgress)
                                               userInfo:nil
                                                repeats:YES];
}


- (IBAction)button:(id)sender {
//  if(hasExerciseFinished) {
//    [sender setTitle:@"Go back to Home Screen" forState:UIControlStateNormal];
//    [self dismissViewControllerAnimated:true completion:nil];
//    return;
//  }
  [sender setTitle:@"Stop Exercise" forState:UIControlStateNormal];
  [self onStartExercise:0];
  [self startTimerMusic];
//  if(hasExerciseStarted == NO) {
//    [self onStartExercise:0];
//  } else {
 
  }

- (IBAction)backButton:(id)sender {
  [self dismissViewControllerAnimated:true completion:nil];
  
}

- (IBAction)extraBackButton:(id)sender {
  [self dismissViewControllerAnimated:true completion:nil];
  
}
@end

