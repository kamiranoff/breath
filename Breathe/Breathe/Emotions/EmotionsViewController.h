//
//  EmotionsViewController.h
//  Breathe
//
//  Created by Kevin Amiranoff on 30/11/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmotionsViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@property (weak, nonatomic) IBOutlet UILabel *sentence;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLbl;
@property (weak, nonatomic) IBOutlet UINavigationBar *navigation;
- (IBAction)button:(id)sender;
- (IBAction)backButton:(id)sender;

@end
