//
//  DetailViewController.h
//  NextuserSDKdemo
//
//  Created by Marin Bek on 14/03/2017.
//  Copyright © 2017 Marin Bek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "Cart.h"

@interface DetailViewController : UIViewController

@property (strong, nonatomic) Product *detailItem;
@property (strong, nonatomic) IBOutlet UIImageView *productImage;
@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *selectedQtyLabel;
@property (strong, nonatomic) IBOutlet UILabel *currentTotalLabel;
@property (strong, nonatomic) IBOutlet UIStepper *qtyStepper;
@property (strong, nonatomic) IBOutlet UIButton *cartButton;
@property (strong, nonatomic) IBOutlet UILabel *productDescription;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

- (IBAction)changeQtyAction:(UIStepper *)sender forEvent:(UIEvent *)event;
- (IBAction)addToCartAction:(UIButton *)sender forEvent:(UIEvent *)event;
- (IBAction)handleTapWithRecognizer:(UITapGestureRecognizer *) recognizer;

@end

