//
//  DetailViewController.h
//  NextuserSDKdemo
//
//  Created by Marin Bek on 14/03/2017.
//  Copyright © 2017 Marin Bek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

