//
//  MasterViewController.h
//  NextuserSDKdemo
//
//  Created by Marin Bek on 14/03/2017.
//  Copyright © 2017 Marin Bek. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "Product.h"
#import "ProductsTableRowView.h"
@import NextUser;

@class DetailViewController;

@interface MasterViewController : UITableViewController

@property (strong, nonatomic) DetailViewController *detailViewController;
@property (strong, nonatomic) IBOutlet UITableView *productsTable;

@end

