#import "MasterViewController.h"

@interface MasterViewController ()
{
    NSMutableArray<Product *> *products;
}
@end

@implementation MasterViewController
@synthesize productsTable;

- (instancetype) init {
    self = [super init];
    if (self) {
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    products = [[NSMutableArray alloc] init];
    [products addObject:[Product generateProduct:@"1" withName:@"Boots" withPrice:72 withImageResource:@"boots.jpg" withDescription:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."]];
    [products addObject:[Product generateProduct:@"2" withName:@"Can" withPrice:2 withImageResource:@"can.jpg" withDescription:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."]];
    [products addObject:[Product generateProduct:@"3" withName:@"Cheese" withPrice:32 withImageResource:@"cheese.jpg" withDescription:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."]];
    [products addObject:[Product generateProduct:@"4" withName:@"Shoes" withPrice:122 withImageResource:@"shoes.jpg" withDescription:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."]];
    [products addObject:[Product generateProduct:@"5" withName:@"Vaseline" withPrice:22 withImageResource:@"vaseline.jpg" withDescription:@"Lorem ipsum dolor sit amet, consectetur adipiscing elit."]];
}


- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NextUser tracker] trackScreenWithName:@"HomeScreen"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Product *product = products[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        [controller setDetailItem:product];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return products.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"productCell";
    ProductsTableRowView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Product *product = products[indexPath.row];
    
    //image view
    CGFloat imageWidth = 50;
    CGFloat imageHeight = 50;
    [cell.productImage setTranslatesAutoresizingMaskIntoConstraints: NO];
    UIImage* image = [UIImage imageNamed:product.imageResource];
    cell.productImage.image = [self scaleImage:image toSize:CGSizeMake(imageWidth, imageHeight)];
    [cell.productImage setContentMode:UIViewContentModeScaleAspectFit];
    
    cell.productName.text = product.name;
    cell.productPrice.text = [[[NSNumber numberWithDouble:product.price] stringValue] stringByAppendingString:@"$"];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    Product *product = products[indexPath.row];
    NUEvent *clickProductEvent = [NUEvent eventWithName:@"_click_product"];
    [clickProductEvent setFirstParameter:product.name];
    [[NextUser tracker] trackEvent: clickProductEvent];
    return YES;
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


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// when user tap the row, what action you want to perform
- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self performSegueWithIdentifier:@"show" sender:self];
}




@end

