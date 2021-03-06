#import "DetailViewController.h"


@import NextUser;
@implementation DetailViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    _productName.text = _detailItem.name;
    _productImage.image = [UIImage imageNamed:_detailItem.imageResource];
    _productDescription.text = _detailItem.prodDescription;
    double currentQty = [[Cart sharedInstance] qtyForProduct:_detailItem];
    if (currentQty != 0) {
        [self changeUIForQty: currentQty];
        [_qtyStepper setValue:currentQty];
        [_cartButton setTitle:@"Update Cart" forState:UIControlStateNormal];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NextUser tracker] trackScreenWithName:@"DetailScreen"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - Managing the detail item

- (void)setDetailItem:(Product *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
    }
}

- (void) changeUIForQty:(double) qty
{
    [_selectedQtyLabel setText:[NSString stringWithFormat:@"%d", (int)qty]];
    [_currentTotalLabel setText:[[NSString stringWithFormat:@"%.2f", qty * _detailItem.price] stringByAppendingString:@"$"]];
}

- (IBAction)changeQtyAction:(UIStepper *)sender forEvent:(UIEvent *)event
{
    [self changeUIForQty:[sender value]];
}

- (IBAction)addToCartAction:(UIButton *)sender forEvent:(UIEvent *)event
{
    [[Cart sharedInstance] addItem:_detailItem withQuantity:(NSInteger)_qtyStepper.value];
    NUEvent *addToCartEvent =  [NUEvent eventWithName:@"add_to_cart"];
    [addToCartEvent setFirstParameter: _detailItem.name];
    [addToCartEvent setSecondParameter: [[NSNumber numberWithDouble: _qtyStepper.value] stringValue]];
    [[NextUser tracker] trackEvent:addToCartEvent];
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction)handleTapWithRecognizer:(UITapGestureRecognizer *) recognizer
{
    NUEvent *shareEvent =  [NUEvent eventWithName:@"social_share"];
    [shareEvent setFirstParameter: _detailItem.name];
    [shareEvent setSecondParameter: recognizer.view.accessibilityIdentifier];
    [[NextUser tracker] trackEvent:shareEvent];
}

@end

