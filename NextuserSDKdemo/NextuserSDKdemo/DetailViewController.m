//
//  DetailViewController.m
//  NextuserSDKdemo
//
//  Created by Marin Bek on 14/03/2017.
//  Copyright © 2017 Marin Bek. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _productName.text = _detailItem.name;
    _productImage.image = [UIImage imageNamed:_detailItem.imageResource];
    _productDescription.text = _detailItem.prodDescription;
    double currentQty = [[Cart sharedInstance] qtyForProduct:_detailItem];
    if (currentQty != 0) {
        [self changeUIForQty: currentQty];
        [_qtyStepper setValue:currentQty];
        [_cartButton setTitle:@"Update Cart" forState:UIControlStateNormal];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(Product *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
}

- (void) changeUIForQty:(double) qty
{
    [_selectedQtyLabel setText:[NSString stringWithFormat:@"%d", (int)qty]];
    [_currentTotalLabel setText:[[NSString stringWithFormat:@"%.2f", qty * _detailItem.price] stringByAppendingString:@"$"]];
}

- (IBAction)changeQtyAction:(UIStepper *)sender forEvent:(UIEvent *)event
{
    [self changeUIForQty:[sender value]];
}

- (IBAction)addToCartAction:(UIButton *)sender forEvent:(UIEvent *)event
{
    [[Cart sharedInstance] addItem:_detailItem withQuantity:(NSInteger)_qtyStepper.value];
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction)handleTapWithRecognizer:(UITapGestureRecognizer *) recognizer
{
    NUEvent *shareEvent =  [NUEvent eventWithName:@"social_share"];
    [shareEvent setFirstParameter: _detailItem.identifier];
    [shareEvent setSecondParameter: recognizer.view.accessibilityIdentifier];
    [[Nextuser tracker] trackEvent:shareEvent];
}

@end

