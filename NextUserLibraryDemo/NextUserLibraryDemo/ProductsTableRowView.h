#import <UIKit/UIKit.h>

@interface ProductsTableRowView : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *productImage;
@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *productPrice;

@end
