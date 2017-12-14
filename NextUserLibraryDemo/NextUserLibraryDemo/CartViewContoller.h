//
//  CartViewContoller.h
//  NextuserSDKdemo
//
//  Created by Adrian Lazea on 22/11/2017.
//  Copyright © 2017 Marin Bek. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Cart.h"
#import "CartItemTableRowView.h"

@interface CartViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *cartItemsTableView;
@property (strong, nonatomic) IBOutlet UIView *cartContainerView;
- (IBAction)checkoutAction:(UIButton *)sender;
- (IBAction)cancelAction:(UIButton *)sender;

@end
