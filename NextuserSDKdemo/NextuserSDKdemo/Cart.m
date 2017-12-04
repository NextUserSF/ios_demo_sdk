#import <Foundation/Foundation.h>
#import "Cart.h"

@import NextUser;

@implementation Cart

+ (instancetype) sharedInstance
{
    static Cart *instance;
    static dispatch_once_t instanceInitToken;
    dispatch_once(&instanceInitToken, ^{
        instance = [[Cart alloc] init];
        instance.items = [[NSMutableArray alloc] init];
    });
    
    return instance;
}

- (double) qtyForProduct:(Product *) product
{
    for (CartItem *item in _items) {
        if (item.product.identifier == product.identifier)
        {
            return item.quantity;
        }
    }
    
    return 0;
}

- (void) addItem:(Product *) product withQuantity:(NSUInteger) qty
{
    CartItem *item = [self itemForProduct:product];
    if (item == nil) {
        item = [CartItem itemForProduct:product];
        [_items addObject:item];
    }
    
    item.quantity = qty;
}

-(CartItem *) itemForProduct:(Product *) product {
    for (CartItem *item in _items) {
        if ([item.product.name isEqualToString:product.name]) {
            return item;
        }
    }
    
    return nil;
}

- (void) clear
{
    [_items removeAllObjects];
}

- (void) checkOut
{
    [self trackPurchase];
    [self clear];
}

-(void) trackPurchase
{
    NSMutableArray<NUPurchaseItem *> * purchaseItems = [[NSMutableArray alloc] init];
    double total = 0;
    for (CartItem *item in _items) {
        [purchaseItems addObject:[self toTrackerPurchaseItem:item]];
        total = total + item.quantity * item.product.price;
    }
    
    NUPurchase *purchase = [NUPurchase purchaseWithTotalAmount:total items:purchaseItems];
    [[Nextuser tracker] trackPurchase:purchase];
}

-(NUPurchaseItem *) toTrackerPurchaseItem:(CartItem *) item
{
    NUPurchaseItem *purchaseItem = [NUPurchaseItem itemWithProductName:item.product.name SKU:item.product.identifier];
    purchaseItem.price = item.product.price;
    purchaseItem.productDescription = item.product.prodDescription;
    purchaseItem.quantity = item.quantity;
    
    return purchaseItem;
}

@end
