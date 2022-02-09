#import "CartViewContoller.h"

@import NextUser;
@implementation CartViewController
@synthesize cartItemsTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.cartItemsTableView.dataSource = self;
    self.cartItemsTableView.delegate = self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NextUser tracker] trackScreenWithName:@"CartScreen"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cartCell";
    CartItemTableRowView *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    CartItem *cartItem = [[Cart sharedInstance] items][indexPath.row];
    Product *product = cartItem.product;
    double qty = cartItem.quantity;
    
    //image view
    CGFloat imageWidth = 40;
    CGFloat imageHeight = 40;
    [cell.productImage setTranslatesAutoresizingMaskIntoConstraints: NO];
    UIImage* image = [UIImage imageNamed:product.imageResource];
    cell.productImage.image = [self scaleImage:image toSize:CGSizeMake(imageWidth, imageHeight)];
    [cell.productImage setContentMode:UIViewContentModeScaleAspectFit];
    cell.productName.text = product.name;
    cell.productTotal.text = [[NSString stringWithFormat:@"%d x %.2f = %.2f",
                              (int)qty,product.price, qty * product.price] stringByAppendingString:@"$"];
    return cell;
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

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[Cart sharedInstance] items].count;
}

- (IBAction)checkoutAction:(UIButton *)sender
{
    
//    NUWebViewSettings *settings = [[NUWebViewSettings alloc] init];
//    settings.url = @"https://tienda.sonepar.es/tienda/#/home";
//    settings.firstLoadJs = @"console.log(\" FIRST LOAD JS CODE \"); var closeDataObj ={}; closeDataObj.user='Adrian'; setTimeout(function(){ nuBridge.sendData({'data':JSON.stringify(closeDataObj), 'event':'first_load_test_event', 'parameters':['1','2','3']}); }, 3000);";
//    
//    NUCustomJSCode *customjscode1 = [[NUCustomJSCode alloc] init];
//    customjscode1.pageURL = @"https://tienda.sonepar.es/tienda/#/catalogo";
//    customjscode1.jsCodeString = @"console.log(' PAGE URL equals: https://tienda.sonepar.es/tienda/#/catalogo'); nuBridge.executeUrl('nextuser://reload'); ";
//    customjscode1.condition = (NUCondition) EQUALS;
//    
//    
//    NUCustomJSCode *customjscode2 = [[NUCustomJSCode alloc] init];
//    customjscode2.pageURL = @"compraAsegurada";
//    customjscode2.jsCodeString = @"console.log(' PAGE URL contains: compraAsegurada'); nuBridge.triggerReload({'event':'reload_triggered_test_event', 'parameters':['11','22','33']});";
//    customjscode2.condition = (NUCondition) CONTAINS;
//    
//    
//    NUCustomJSCode *customjscode3 = [[NUCustomJSCode alloc] init];
//    customjscode3.pageURL = @"https://tienda.sonepar.es/tienda/#/producto";
//    customjscode3.jsCodeString = @"console.log(' PAGE URL starts with: https://tienda.sonepar.es/tienda/#/producto'); nuBridge.triggerClose({'event':'close_test_event', 'parameters':['111','222','333']});";
//    customjscode3.condition = (NUCondition) STARTS_WITH;
//    
//    NSMutableArray *customeJsCodes = [NSMutableArray arrayWithCapacity:3];
//    [customeJsCodes addObject:customjscode1];
//    [customeJsCodes addObject:customjscode2];
//    [customeJsCodes addObject:customjscode3];
//    
//    settings.customJSCodes = customeJsCodes;
//    settings.enableNavigation = YES;
//    settings.suppressBrowserJSAlerts = YES;
//    
// 
//    [[NextUser UIDisplayManager] showWebView:settings withDelegate:self withCompletion: ^(BOOL success, NSError *error) {
//        
//        if (success ==YES) {
//            NSLog(@" sucess!!");
//        } else {
//            NSLog(@" error %@: ", error.localizedDescription);
//        }
//        
//    }];
    
    
    [[Cart sharedInstance] checkOut];
    [[NextUser tracker] trackEvent:[NUEvent eventWithName:@"_checkout_completed"]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelAction:(UIButton *)sender
{
    [[NextUser tracker] trackEvent:[NUEvent eventWithName:@"_checkout_canceled"]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onWebViewClose:(NSObject *)dataObject {
    NSLog(@" ON WEB VIEW CLOSE %@: ", dataObject);
}

- (void)onWebViewData:(NSObject *)dataObject {
    NSLog(@" ON WEB VIEW DATA %@: ", dataObject);
}

- (void)webViewContainer:(UIView *)view didFailToLoadURL:(NSURL *)URL error:(NSError *)error {
    NSLog(@" ON WEB VIEW FAIL TO LOAD %@: ", error.localizedDescription);
}

- (void)webViewContainer:(UIView *)view didFinishLoadingURL:(NSURL *)URL {
    NSLog(@" ON WEB VIEW FINISHED LOADING %@: ", URL.absoluteURL);
}

- (void)webViewContainer:(UIView *)view didStartLoadingURL:(NSURL *)URL {
    NSLog(@" ON WEB VIEW START LOADING %@: ", URL.absoluteURL);
}

- (void)onWebViewPageLoadingProgress:(double)progress {
    NSLog(@" ON WEB VIEW PAGE LOADING PROGRESS %f: ", progress);
}


@end
