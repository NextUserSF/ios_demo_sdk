#import <Foundation/Foundation.h>
#import "CartItem.h"

@implementation CartItem

+(instancetype) itemForProduct:(Product *) product
{
    CartItem *item = [[CartItem alloc] init];
    item.product = product;
    
    return item;
}
@end
