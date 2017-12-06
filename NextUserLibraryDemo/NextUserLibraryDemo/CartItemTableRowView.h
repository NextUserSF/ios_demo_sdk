#import <UIKit/UIKit.h>

@interface CartItemTableRowView : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *productImage;
@property (strong, nonatomic) IBOutlet UILabel *productName;
@property (strong, nonatomic) IBOutlet UILabel *productTotal;

@end
