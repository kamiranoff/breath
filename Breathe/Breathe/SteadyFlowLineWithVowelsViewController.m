//
//  SteadyFlowLineWithVowelsViewController.m
//  Breathe
//
//  Created by Kevin Amiranoff on 29/11/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import "SteadyFlowLineWithVowelsViewController.h"
#import "JSONHelpers.h"

@interface SteadyFlowLineWithVowelsViewController () {
  NSDictionary * exercises;
  NSArray * steadyFlowLineExercise;
  NSTimer *inhaleTimer;
  NSTimer *vowelTimer;
  int remainingCounts;
  int currentInhaleLength;
  int currentExhaleValue;
  int currentExhaleStrengthValue;
  int currentExerciseIndex;
  int steadyFlowLineExerciseIndex;
  UIColor *inhaleBgColor;
  UIColor *exhaleBgColor;
  NSArray * vowels;
  int vowelsLength;
  int remainingCountsForVowels;
}

@end

@implementation SteadyFlowLineWithVowelsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  vowels = @[@"U",@"O",@"I",@"E",@"A"];
  vowelsLength = 4;
  
  inhaleBgColor = [[UIColor alloc]initWithRed:2.0/255.0 green:132.0/255.0 blue:168.0/255.0 alpha:1.0];
  exhaleBgColor = [[UIColor alloc]initWithRed:218.0/255.0 green:37.0/255.0 blue:67.0/255.0 alpha:1.0];
  
  exercises = [JSONHelpers JSONFromFile:@"exercises"];
  
  steadyFlowLineExerciseIndex = 1;
  steadyFlowLineExercise = [exercises valueForKeyPath:@"steadyFlowLineWithVowels.exercise1"];
  
  currentExerciseIndex = 0;
  
  _chart.hidden = YES;
  
  [self displayNextExerciseValues];
}

-(void)displayNextExerciseValues {
  int nextInhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"inhale.duration"];
  int nextExhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"exhale.duration"];
  int nextExhaleStrengthValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"exhale.strength"];
  
  _inhaleTimeLabel.text = [NSString stringWithFormat:@"Inhale time: %d seconds", nextInhaleValue];
  _exhaleTimeLabel.text =  [NSString stringWithFormat:@"Exhale time: %d seconds", nextExhaleValue];
  _exhaleStrengthLabel.text =  [NSString stringWithFormat:@"Exhale Strengh: %d", nextExhaleStrengthValue];
}

- (void)onTickInhale {
  if (--remainingCounts <= 0) {
    [inhaleTimer invalidate];
    [self startTimerExhale:currentExhaleValue];
    self.view.backgroundColor = [[UIColor alloc]initWithRed:234.0/255.0 green:231.0/255.0 blue:214.0/255.0 alpha:1.0];
    _lblNumberOutlet.hidden = YES;
  }
  
  [self changeNumberOnScreen:remainingCounts];
}

-(void)onExerciseFinished {
  NSString * steadyFlowLineExercisePath = @"steadyFlowLine.exercise";
  NSString * steadyFlowLineExerciseFullPath=[steadyFlowLineExercisePath stringByAppendingFormat:@"%d ",steadyFlowLineExerciseIndex];
  
  _inhaleTimeLabel.hidden = NO;
  _exhaleTimeLabel.hidden = NO;
  _lblNumberOutlet.hidden = YES;
  _startBreathingLbl.hidden = NO;
  _exhaleStrengthLabel.hidden = NO;
  _vowel.hidden = YES;
  self.view.backgroundColor = [[UIColor alloc]initWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0];
  
  if(currentExerciseIndex == steadyFlowLineExercise.count - 1) {
    
    if(steadyFlowLineExerciseIndex < 3) {
      steadyFlowLineExerciseIndex = steadyFlowLineExerciseIndex + 1;
      steadyFlowLineExerciseFullPath = [steadyFlowLineExercisePath stringByAppendingFormat:@"%d",steadyFlowLineExerciseIndex];
      
      steadyFlowLineExercise = [exercises valueForKeyPath:steadyFlowLineExerciseFullPath];
      currentExerciseIndex = 0;
    } else {
      NSLog(@"exercise finished");
    }
    
  } else {
    currentExerciseIndex = currentExerciseIndex + 1;
  }
  
  
  [self displayNextExerciseValues];
}

- (int)getCurrentExerciseValue:(int)index key:(NSString*)key {
  NSDictionary * currentExercise = [steadyFlowLineExercise objectAtIndex:index];
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
  _chart.hidden = NO;
  _vowel.hidden = NO;
  _chart.alpha = .3f;
  [self drawLine:count strength:currentExhaleStrengthValue];
  [self startVowelTimer:count];
}

-(void)startVowelTimer:(int)count {
  float interval = (float) count / 5 ;
  vowelTimer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                 target:self
                                               selector:@selector(displayVowel)
                                               userInfo:nil
                                                repeats:YES];
  vowelsLength = 4;
  remainingCountsForVowels = 5;
  _vowel.text = @"A";
}

-(void)displayVowel {
  
  NSLog(@"%d, %d, %@",remainingCountsForVowels, vowelsLength, vowels);
  
  if (--remainingCountsForVowels <= 0) {
    [vowelTimer invalidate];
    _vowel.hidden = YES;
    return;
  }

  _vowel.text = vowels[--vowelsLength];
}

- (IBAction)startBreathingBtn:(id)sender {
  [sender setHidden:true];
  _descriptionTextOutlet.hidden = YES;
  _lblNumberOutlet.hidden = NO;
  _inhaleTimeLabel.hidden = YES;
  _exhaleTimeLabel.hidden = YES;
  _exhaleStrengthLabel.hidden = YES;
  
  int currentInhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"inhale.duration"];
  currentExhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"exhale.duration"];
  currentExhaleStrengthValue =[self getCurrentExerciseValue:currentExerciseIndex key:@"exhale.strength"];
  self.view.backgroundColor = inhaleBgColor;
  [self changeNumberOnScreen:currentInhaleValue];
  [self startTimerInhale:currentInhaleValue];
}

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem     *)item
{
  //insert your back button handling logic here
  // let the pop happen
  return YES;
}

-(void)drawLine:(int) remainingCount strength:(int)strength {
  
  int barSize = 5;
  
  switch (strength) {
    case 2:
      barSize = 150;
      break;
      
    case 3:
      barSize = 300;
      break;
      
    default:
      barSize= 300 / 8;
      break;
  }
  
  UIBezierPath *path = [UIBezierPath bezierPath];
  CGFloat height = [UIScreen mainScreen].bounds.size.height;
  CGFloat width = ([UIScreen mainScreen].bounds.size.width) - 16;
  
  [path moveToPoint:CGPointMake(16.0, height/2.0 - barSize/2.0 - 2.0)];
  [path addLineToPoint:CGPointMake(width, height/2.0 - barSize/2.0 - 2.0)];
  
  CAShapeLayer *pathLayer = [CAShapeLayer layer];
  pathLayer.frame = self.view.bounds;
  pathLayer.path = path.CGPath;
  pathLayer.strokeColor = [exhaleBgColor CGColor];
  pathLayer.fillColor = [exhaleBgColor CGColor];
  pathLayer.lineWidth = barSize;
  pathLayer.lineJoin = kCALineJoinBevel;
  
  [self.view.layer addSublayer:pathLayer];
  
  [CATransaction begin];
  CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
  pathAnimation.duration = remainingCount;
  pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
  pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
  
  [CATransaction setCompletionBlock:^{
    [path removeAllPoints];
    [pathLayer removeFromSuperlayer];
    [self onExerciseFinished];
    _chart.hidden = YES;
    
  }];
  
  [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
}

@end

