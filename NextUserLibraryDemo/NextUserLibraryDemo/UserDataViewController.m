//
//  UserDataViewController.m
//  NextuserSDKdemo
//
//  Created by Adrian Lazea on 24/11/2017.
//  Copyright © 2017 Marin Bek. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserDataViewController.h"


@implementation UserDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[NextUser tracker] currentUserIdentifier] == nil) {
        [_signInUIView setHidden:NO];
        [_userDataUIView setHidden:YES];
        [[NextUser tracker] trackScreenWithName:@"SignUpScreen"];
    } else {
        [_signInUIView setHidden:YES];
        [_userDataUIView setHidden:NO];
        [_userEmail setPlaceholder:[[NextUser tracker] currentUserIdentifier]];
        [[NextUser tracker] trackScreenWithName:@"UserProfileScreen"];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)signInAction:(UIButton *)sender
{
    NSString *email = _signInUserEmail.text;
    
    if (email != nil) {
        NUUser *user = [[NUUser alloc] init];
        user.email = email;
        [[NextUser tracker] trackUser:user];
    }
    [self cancelAction];
}

- (IBAction)submitAction:(UIButton *)sender
{
    NUUser *user = [[NUUser alloc] init];
    user.email = [[NextUser tracker] currentUserIdentifier];
    user.customerID = _customerID.text;
    user.firstname = _firstName.text;
    user.lastname = _lastName.text;
    user.birthyear = _birthYear.text;
    user.gender = _gender.selectedSegmentIndex == 0 ? MALE : FEMALE;
    [user addVariable:_varOneName.text withValue:_varOneValue.text];
    [user addVariable:_varTwoName.text withValue:_varTwoValue.text];
    [[NextUser tracker] trackUser:user];
    [self cancelAction];
}

- (IBAction)cancelAction 
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
