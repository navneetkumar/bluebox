//
//  UIView+ProgressHUD.h
//  Acid
//
//  Created by Vasu Narayan on 24/04/14.
//
//

#import <UIKit/UIKit.h>

@interface UIView (ProgressHUD)

- (void) showHUDWithText:(NSString *) text withUserInteractionDisabled:(BOOL) isDisabled;

- (void) hideHUD;

@end
