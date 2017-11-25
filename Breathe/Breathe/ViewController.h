//
//  ViewController.h
//  Breathe
//
//  Created by Kevin Amiranoff on 12/11/2017.
//  Copyright © 2017 Kevin Amiranoff. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate,UITableViewDataSource> {
  
}
@property (weak, nonatomic) IBOutlet UITableView *exercicesTableView;

@end

