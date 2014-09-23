//
//  BBConnectMeetingViewController.m
//  BlueBox
//
//  Created by Vasu Narayan on 11/09/14.
//  Copyright (c) 2014 BlueJeans. All rights reserved.
//

#import "BBConnectMeetingViewController.h"
#import "BBTableViewCell.h"
#import "UIAlertView+MKBlockAdditions.h"
#import "BBDeviceCommunicator.h"
#import "UIView+ProgressHUD.h"

@interface BBConnectMeetingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *meetingTableView;

- (IBAction)connectToMeeting:(id)sender;
- (IBAction)playSampleVidep:(id)sender;

@end

@implementation BBConnectMeetingViewController

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
    [self.navigationItem setHidesBackButton:YES];
    self.title = NSLocalizedString(@"BlueBox", nil);
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [[(BBTableViewCell *)[self.meetingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] inputTextField] becomeFirstResponder];
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

- (IBAction)connectToMeeting:(id)sender
{
    [self.view endEditing:YES];
    
    NSString *meetingIDStr = [(BBTableViewCell *)[self.meetingTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]] inputTextField].text;
    if (meetingIDStr.length > 0) {
        [self.view showHUDWithText:NSLocalizedString(@"Connecting...", nil) withUserInteractionDisabled:YES];
        
        [[BBDeviceCommunicator sharedService] callToMeeting:meetingIDStr onCompletion:^(BOOL success, NSError *error) {
            NSLog(@"****** Success = %d, error = %@", success, error);
            if (success) {
                [self performSegueWithIdentifier:@"inMeetingSegue" sender:self];
            }
            else {
                [UIAlertView alertViewWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"Could not connect to Meeting. Please try after sometime.", nil) cancelButtonTitle:NSLocalizedString(@"OK", nil)];
            }
            
            [self.view hideHUD];
        }];
    }
    else {
        [UIAlertView alertViewWithTitle:NSLocalizedString(@"Error", nil) message:NSLocalizedString(@"Please enter valid Meeting ID", nil) cancelButtonTitle:NSLocalizedString(@"OK", nil)];
    }
}

- (IBAction)playSampleVidep:(id)sender {
    
    [[BBDeviceCommunicator sharedService] playVideo:^(BOOL success, NSError *error) {
    }];
}


#pragma mark - UITableViewDataSource Methods -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"tableViewCellID";
    BBTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[BBTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    if (indexPath.row == 0) {
        cell.titleLabel.text = NSLocalizedString(@"Meeting ID", nil);
        cell.inputTextField.placeholder = NSLocalizedString(@"required", nil);
    }
    else {
        
    }
    
    return cell;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

@end
