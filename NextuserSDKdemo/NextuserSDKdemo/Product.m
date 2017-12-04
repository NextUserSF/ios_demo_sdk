#import <Foundation/Foundation.h>
#import "Product.h"

@implementation Product

+ (instancetype) generateProduct:(NSString *) identifier withName:(NSString *) name withPrice:(double) price
               withImageResource:(NSString *) image withDescription:(NSString *) description
{
    Product *product = [[Product alloc] init];
    product.identifier = identifier;
    product.name = name;
    product.price = price;
    product.imageResource = image;
    product.prodDescription = description;
    
    return product;
}

@end
