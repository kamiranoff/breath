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
int currentExhaleStrengthValue;
int currentExerciseIndex;
UIColor *inhaleBgColor;
UIColor *exhaleBgColor;
}

@end

@implementation SteadyFlowLineViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  inhaleBgColor = [[UIColor alloc]initWithRed:2.0/255.0 green:132.0/255.0 blue:168.0/255.0 alpha:1.0];
  exhaleBgColor = [[UIColor alloc]initWithRed:15.0/255.0 green:15.0/255.0 blue:15.0/255.0 alpha:1.0];
  
  exercises = [JSONHelpers JSONFromFile:@"exercises"];
  breathingExercise = [exercises valueForKeyPath:@"steadyFlowLine.exercise1"];
  currentExerciseIndex = 0;
  
  [self displayNextExerciseValues];
  
}

-(void)displayNextExerciseValues {
  int nextInhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"inhale.duration"];
  int nextExhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"exhale.duration"];
  int nextExhaleStrengthValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"exhale.strength"];

  _inhaleTimeLabel.text = [NSString stringWithFormat:@"Inhale time: %d seconds", nextInhaleValue];
  _exhaleTimeLabel.text =  [NSString stringWithFormat:@"Inhale time: %d seconds", nextExhaleValue];
  _exhaleStrengthLabel.text =  [NSString stringWithFormat:@"Exhale Strengh: %d", nextExhaleStrengthValue];

}

- (void)onTickInhale
{
  if (--remainingCounts <= -1) {
    [self startTimerExhale:currentExhaleValue];
    self.view.backgroundColor = exhaleBgColor;
    _lblNumberOutlet.hidden = YES;
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
  [self drawLine:remainingCounts strength:currentExhaleStrengthValue];
}

-(void)onExerciseFinished {
  _inhaleTimeLabel.hidden = NO;
  _exhaleTimeLabel.hidden = NO;
  currentExerciseIndex = currentExerciseIndex + 1;
  _lblNumberOutlet.hidden = YES;
  _startBreathingLbl.hidden = NO;
  _exhaleStrengthLabel.hidden = NO;
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

-(void)drawLine:(int) remainingCount strength:(int)strength {

  UIBezierPath *path = [UIBezierPath bezierPath];
  CGFloat height = [UIScreen mainScreen].bounds.size.height;
  CGFloat width = ([UIScreen mainScreen].bounds.size.width) - 16;
  
  [path moveToPoint:CGPointMake(16.0, height/2.0)];
  [path addLineToPoint:CGPointMake(width, height/2.0)];
  
  CAShapeLayer *pathLayer = [CAShapeLayer layer];
  pathLayer.frame = self.view.bounds;
  pathLayer.path = path.CGPath;
  pathLayer.strokeColor = [[UIColor whiteColor] CGColor];
  pathLayer.fillColor = nil;
  pathLayer.lineWidth = strength * 5;
  pathLayer.lineJoin = kCALineJoinBevel;
  
  [self.view.layer addSublayer:pathLayer];
  
  CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
  pathAnimation.duration = remainingCount;
  pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
  pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
  [pathLayer addAnimation:pathAnimation forKey:@"strokeEnd"];
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
  _exhaleStrengthLabel.hidden = YES;
  
  int currentInhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"inhale.duration"];
  currentExhaleValue = [self getCurrentExerciseValue:currentExerciseIndex key:@"exhale.duration"];
  currentExhaleStrengthValue =[self getCurrentExerciseValue:currentExerciseIndex key:@"exhale.strength"];
  self.view.backgroundColor = inhaleBgColor;
  [self changeNumberOnScreen:currentInhaleValue];
  [self startTimerInhale:currentInhaleValue];
}


@end
