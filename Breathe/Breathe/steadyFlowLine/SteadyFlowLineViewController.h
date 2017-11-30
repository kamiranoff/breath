//
//  SteadyFlowLineViewController.h
//  Breathe
//
//  Created by Kevin Amiranoff on 13/11/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SteadyFlowLineViewController : UIViewController<UINavigationControllerDelegate>
- (IBAction)startBreathingBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *descriptionTextOutlet;
@property (weak, nonatomic) IBOutlet UILabel *lblNumberOutlet;
@property (weak, nonatomic) IBOutlet UIButton *startBreathingLbl;
@property (weak, nonatomic) IBOutlet UILabel *inhaleTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *exhaleTimeLabel;
@property (nonatomic, strong) NSString * exerciceTitle;

@property (weak, nonatomic) IBOutlet UIImageView *chart;

@property (weak, nonatomic) IBOutlet UILabel *exhaleStrengthLabel;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigation;

@end
