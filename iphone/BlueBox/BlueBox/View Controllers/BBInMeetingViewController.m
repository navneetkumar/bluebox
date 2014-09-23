//
//  BBInMeetingViewController.m
//  BlueBox
//
//  Created by Vasu Narayan on 12/09/14.
//  Copyright (c) 2014 BlueJeans. All rights reserved.
//

#import "BBInMeetingViewController.h"
#import "BBDeviceCommunicator.h"
#import "UIView+ProgressHUD.h"
#import "UIAlertView+MKBlockAdditions.h"

@interface BBInMeetingViewController ()

- (IBAction)hangup:(id)sender;

@end

@implementation BBInMeetingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationItem.backBarButtonItem setTarget:self];
    [self.navigationItem.backBarButtonItem setAction:@selector(hangup:)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)hangup:(id)sender {
    
    [UIAlertView alertViewWithTitle:NSLocalizedString(@"Hangup", nil) message:NSLocalizedString(@"Are you sure you want to leave the meeting?", nil) cancelButtonTitle:NSLocalizedString(@"No", nil) otherButtonTitles:@[NSLocalizedString(@"Yes", nil)] onDismiss:^(int buttonIndex) {
       
        [self.view showHUDWithText:NSLocalizedString(@"Disconnecting...", nil) withUserInteractionDisabled:YES];
        [[BBDeviceCommunicator sharedService] hangUp:^(BOOL success, NSError *error) {
            [self.view hideHUD];
            [self.navigationController popViewControllerAnimated:YES];
        }];

    } onCancel:^{
        
    }];
}

@end
