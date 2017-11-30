//
//  Vowels.h
//  Breathe
//
//  Created by Kevin Amiranoff on 30/11/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Vowels : UIViewController
- (IBAction)startBreathingBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *descriptionTextOutlet;
@property (weak, nonatomic) IBOutlet UILabel *lblNumberOutlet;
@property (weak, nonatomic) IBOutlet UILabel *exhaleNumberlbl;
@property (weak, nonatomic) IBOutlet UIButton *startBreathingLbl;
@property (weak, nonatomic) IBOutlet UILabel *inhaleTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *exhaleTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *exhaleVowelLabel;
@property (nonatomic, strong) NSString * exerciceTitle;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigation;
@property (weak, nonatomic) IBOutlet UILabel *exhaleVowel;
@end
