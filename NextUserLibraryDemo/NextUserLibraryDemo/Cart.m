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
    double total = 0;
    for (CartItem *item in _items) {
        total = total + item.quantity * item.product.price;
    }
    [[NextUser cartManager] setTotal:total];
    [[NextUser cartManager] checkout];
}

@end
