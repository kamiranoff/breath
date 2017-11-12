//
//  Breathing.h
//  Breathe
//
//  Created by Kevin Amiranoff on 12/11/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BreathingViewController : UIViewController
- (IBAction)startBreathingBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextOutlet;
@property (weak, nonatomic) IBOutlet UILabel *lblNumberOutlet;
@property (weak, nonatomic) IBOutlet UIButton *startBreathingLbl;
@property (weak, nonatomic) IBOutlet UILabel *inhaleTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *exhaleTimeLabel;

@end
