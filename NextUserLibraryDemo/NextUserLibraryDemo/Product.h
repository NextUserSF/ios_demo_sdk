#import <Foundation/Foundation.h>

@interface Product : NSObject

+ (instancetype) generateProduct:(NSString *) identifier withName:(NSString *) name withPrice:(double) price
               withImageResource:(NSString *) image withDescription:(NSString *) description;

@property (nonatomic) NSString *identifier;
@property (nonatomic) NSString *name;
@property (nonatomic) double price;
@property (nonatomic) NSString *imageResource;
@property (nonatomic) NSString *prodDescription;

@end
