#import <Foundation/Foundation.h>
#import "CartItem.h"

@interface Cart : NSObject

@property (nonatomic) NSMutableArray<CartItem *> *items;

+ (instancetype) sharedInstance;

- (void) addItem:(Product *) product withQuantity:(NSUInteger) qty;
- (double) qtyForProduct:(Product *) product;
- (void) clear;
- (void) checkOut;

@end
