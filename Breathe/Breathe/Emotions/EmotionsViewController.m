//
//  EmotionsViewController.m
//  Breathe
//
//  Created by Kevin Amiranoff on 30/11/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import "EmotionsViewController.h"
#import "JSONHelpers.h"

@interface EmotionsViewController () {
  bool hasExerciseStarted;
  bool hasExerciseFinished;
  NSDictionary * exercises;
  NSDictionary * emotionsExercise;
  int emotionsIndex;
  int sentenceIndex;
  NSArray * emotions;
}
@end

@implementation EmotionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  _picture.hidden = YES;
  _sentence.hidden = YES;
  
  hasExerciseStarted = NO;
  
  exercises = [JSONHelpers JSONFromFile:@"exercises"];
  emotionsExercise = [exercises objectForKey:@"emotions"];
  emotions = @[@"happy",@"sad",@"curious",@"angry",@"scared"];
  emotionsIndex = 0;
  sentenceIndex = 0;
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onStartExercise:(NSString *)emotion {
  _picture.hidden = NO;
  _sentence.hidden = NO;
  _navigation.hidden = YES;
  _descriptionLbl.hidden = YES;
  
  _sentence.text = [emotionsExercise objectForKey:emotion][0];
  hasExerciseStarted = YES;
}

-(NSString *)getEmotion:(int)index{
  return emotions[index];
}

-(void)displayNextSentence:(NSString *)emotion {
  _sentence.text = [emotionsExercise objectForKey:emotion][sentenceIndex];
}

-(void) handleExerciseProgress {
  if(sentenceIndex < emotions.count -1) {
    sentenceIndex++;
  } else {
    if(emotionsIndex < emotions.count -1) {
      emotionsIndex++;
      sentenceIndex = 0;
      _picture.image = [UIImage imageNamed:[self getEmotion:emotionsIndex]];
      
    } else {
      [self handleExerciseFinished];
    }
 
  }
}

-(void) handleExerciseFinished {
  _picture.hidden = YES;
  _sentence.hidden = YES;
  _navigation.hidden = NO;
  _descriptionLbl.hidden = NO;
  _descriptionLbl.text = @"Well Done !";
 
  hasExerciseFinished = YES;
}


- (IBAction)button:(id)sender {
  if(hasExerciseFinished) {
    [sender setTitle:@"Go back to Home Screen" forState:UIControlStateNormal];
    return;
  }
  [sender setTitle:@"Next sentence" forState:UIControlStateNormal];

  [self handleExerciseProgress];
  NSString * emotion = [self getEmotion:emotionsIndex];
  if(hasExerciseStarted == NO) {
    [self onStartExercise:emotion];
  } else {
    [self displayNextSentence:emotion];
  }
}

- (IBAction)backButton:(id)sender {
  [self dismissViewControllerAnimated:true completion:nil];

}
@end
