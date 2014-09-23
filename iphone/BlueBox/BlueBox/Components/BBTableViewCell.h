//
//  BBTableViewCell.h
//  BlueBox
//
//  Created by Vasu Narayan on 11/09/14.
//  Copyright (c) 2014 BlueJeans. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end
