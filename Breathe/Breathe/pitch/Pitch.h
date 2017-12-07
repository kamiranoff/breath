//
//  Pitch.h
//  Breathe
//
//  Created by Kevin Amiranoff on 01/12/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Pitch : UIViewController<UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *exerciseDescription;
@property (weak, nonatomic) IBOutlet UILabel *inhaleCountNumber;
@property (weak, nonatomic) IBOutlet UILabel *inhileTimeLbl;
@property (weak, nonatomic) IBOutlet UILabel *exhaleTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *vowelLbl;
- (IBAction)startButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (weak, nonatomic) IBOutlet UINavigationBar *navigation;
- (IBAction)backButton:(id)sender;
@property (weak, nonatomic) IBOutlet UIStackView *colorsStackView;
@property (weak, nonatomic) IBOutlet UIStackView *lettersStackView;
@property (weak, nonatomic) IBOutlet UIButton *startButtonLbl;
@property (weak, nonatomic) IBOutlet UILabel *red;
@property (weak, nonatomic) IBOutlet UILabel *pink;
@property (weak, nonatomic) IBOutlet UILabel *yellow;
@property (weak, nonatomic) IBOutlet UILabel *green;
@property (weak, nonatomic) IBOutlet UILabel *blue;
@property (weak, nonatomic) IBOutlet UILabel *purple;
@property (weak, nonatomic) IBOutlet UILabel *lila;
@property (weak, nonatomic) IBOutlet UIImageView *colorImageExplaination;

@end
