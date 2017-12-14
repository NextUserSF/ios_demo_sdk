#import <UIKit/UIKit.h>

@interface UserDataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIView *signInUIView;
@property (strong, nonatomic) IBOutlet UITextField *signInUserEmail;
- (IBAction)signInAction:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIView *userDataUIView;
@property (strong, nonatomic) IBOutlet UITextField *userEmail;
@property (strong, nonatomic) IBOutlet UITextField *customerID;
@property (strong, nonatomic) IBOutlet UITextField *firstName;
@property (strong, nonatomic) IBOutlet UITextField *lastName;
@property (strong, nonatomic) IBOutlet UITextField *birthYear;
@property (strong, nonatomic) IBOutlet UISegmentedControl *gender;
@property (strong, nonatomic) IBOutlet UITextField *varOneName;
@property (strong, nonatomic) IBOutlet UITextField *varOneValue;
@property (strong, nonatomic) IBOutlet UITextField *varTwoName;
@property (strong, nonatomic) IBOutlet UITextField *varTwoValue;
- (IBAction)submitAction:(UIButton *)sender;
- (IBAction)cancelAction;

@end
