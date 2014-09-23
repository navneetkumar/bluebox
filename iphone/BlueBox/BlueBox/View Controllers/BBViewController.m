//
//  BBViewController.m
//  BlueBox
//
//  Created by Vasu Narayan on 10/09/14.
//  Copyright (c) 2014 BlueJeans. All rights reserved.
//

#import "BBViewController.h"
#import "UIView+ProgressHUD.h"
#import "BBConnectMeetingViewController.h"
#import "BBDeviceCommunicator.h"

@interface BBViewController ()

@property (nonatomic, strong) NSNetServiceBrowser *serviceBrowser;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *devices;
@property (weak, nonatomic) IBOutlet UIImageView *activityIndicatorImageView;
@property (weak, nonatomic) IBOutlet UILabel *blueBoxStatusLabel;
@property (strong, nonatomic) NSNetService *currentDevice;

- (IBAction)browseDevices:(id)sender;

@end

@implementation BBViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"BlueBox";
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Medium" size:17.0f],
                                                           NSForegroundColorAttributeName: [UIColor blackColor]
                                                           }];
    
	// Do any additional setup after loading the view, typically from a nib.
    self.devices = [[NSMutableArray alloc] init];

    [self searchForDevice];
}

- (void)searchForDevice
{
    [self startLoadingIndicator];
    self.serviceBrowser = [[NSNetServiceBrowser alloc] init];
    self.serviceBrowser.delegate = self;
    [self.serviceBrowser searchForServicesOfType:@"_bluebox_rpc._tcp" inDomain:@""];
    self.blueBoxStatusLabel.text = NSLocalizedString(@"Searching BlueBox...", nil);
}

- (void)resolveService:(NSNetService *)netService
{
    if (netService) {
        self.blueBoxStatusLabel.text = NSLocalizedString(@"Connecting to BlueBox...", );
        netService.delegate = self;
        [netService resolveWithTimeout:10];
    }
}

- (IBAction)browseDevices:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    if (indexPath.row < self.devices.count) {
        [self.view showHUDWithText:@"Connecting..." withUserInteractionDisabled:YES];
        NSNetService *netService = [self.devices objectAtIndex:indexPath.row];
        netService.delegate = self;
        [netService resolveWithTimeout:10];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return self.devices.count;
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didFindService:(NSNetService *)aNetService moreComing:(BOOL)moreComing
{
    if (![self.devices containsObject:aNetService]) {
        [self.devices addObject:aNetService];
    }

    [self.serviceBrowser stop];
    
    if ([self.navigationController.topViewController isEqual:self]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self resolveService:aNetService];
        });
    }
}

- (void)netServiceBrowser:(NSNetServiceBrowser *)aNetServiceBrowser didRemoveService:(NSNetService *)aNetService moreComing:(BOOL)moreComing
{
}

- (void)netServiceDidResolveAddress:(NSNetService *)sender
{
    if ([self.navigationController.topViewController isEqual:self])
    {
        [sender stop];
        
        BBDeviceCommunicator *communicator = [BBDeviceCommunicator sharedService];
        [communicator setCurrentDevice:sender];
        [communicator sendName:@"BlueBox iPhone" onCompletion:^(BOOL success, NSError *error) {
            self.blueBoxStatusLabel.text = NSLocalizedString(@"Connected to BlueBox.", nil);
            [self stopLoadingIndicator];
            [self performSegueWithIdentifier:@"connectToMeeting" sender:self];
        }];
    }
}

- (void)netService:(NSNetService *)sender didNotResolve:(NSDictionary *)errorDict
{
    [self stopLoadingIndicator];
    self.blueBoxStatusLabel.text = NSLocalizedString(@"No BlueBox Found.", nil);
}

- (void)startLoadingIndicator
{
    self.activityIndicatorImageView.hidden = NO;
    self.activityIndicatorImageView.animationImages = @[[UIImage imageNamed:@"activity-indicator-1.png"],
                                                        [UIImage imageNamed:@"activity-indicator-2.png"],
                                                        [UIImage imageNamed:@"activity-indicator-3.png"],
                                                        [UIImage imageNamed:@"activity-indicator-4.png"],
                                                        [UIImage imageNamed:@"activity-indicator-5.png"],
                                                        [UIImage imageNamed:@"activity-indicator-6.png"],];
    self.activityIndicatorImageView.animationDuration = 0.8;
    self.activityIndicatorImageView.animationRepeatCount = 0;
    [self.activityIndicatorImageView startAnimating];
}

- (void)stopLoadingIndicator
{
    [self.activityIndicatorImageView stopAnimating];
    self.activityIndicatorImageView.hidden = YES;
}

@end
