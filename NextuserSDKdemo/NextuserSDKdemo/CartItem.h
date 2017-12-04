#import <Foundation/Foundation.h>
#import "Product.h"

@interface CartItem : NSObject

@property (nonatomic) Product *product;
@property (nonatomic) NSUInteger quantity;

+(instancetype) itemForProduct:(Product *) product;

@end
