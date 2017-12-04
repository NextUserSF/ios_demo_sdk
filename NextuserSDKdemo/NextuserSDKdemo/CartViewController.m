//
//  CartViewController.m
//  NextuserSDKdemo
//
//  Created by Adrian Lazea on 22/11/2017.
//  Copyright © 2017 Marin Bek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CartViewContoller.h"

@implementation CartViewController
@synthesize cartItemsTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cartItemsTableView.dataSource = self;
    self.cartItemsTableView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cartCell";
    CartItemTableRowView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    CartItem *cartItem = [[Cart sharedInstance] items][indexPath.row];
    Product *product = cartItem.product;
    double qty = cartItem.quantity;
    
    //image view
    CGFloat imageWidth = 40;
    CGFloat imageHeight = 40;
    [cell.productImage setTranslatesAutoresizingMaskIntoConstraints: NO];
    UIImage* image = [UIImage imageNamed:product.imageResource];
    cell.productImage.image = [self scaleImage:image toSize:CGSizeMake(imageWidth, imageHeight)];
    [cell.productImage setContentMode:UIViewContentModeScaleAspectFit];
    cell.productName.text = product.name;
    cell.productTotal.text = [[NSString stringWithFormat:@"%d x %.2f = %.2f",
                              (int)qty,product.price, qty * product.price] stringByAppendingString:@"$"];
    return cell;
}

- (UIImage *)scaleImage:(UIImage *)imageToResize toSize:(CGSize)theNewSize {
    
    CGFloat width = imageToResize.size.width;
    CGFloat height = imageToResize.size.height;
    float scaleFactor;
    if(width > height) {
        scaleFactor = theNewSize.height / height;
    } else {
        scaleFactor = theNewSize.width / width;
    }
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width * scaleFactor, height * scaleFactor), NO, 0.0);
    [imageToResize drawInRect:CGRectMake(0, 0, width * scaleFactor, height * scaleFactor)];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[Cart sharedInstance] items].count;
}

- (IBAction)checkoutAction:(UIButton *)sender
{
    [[Cart sharedInstance] checkOut];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelAction:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
