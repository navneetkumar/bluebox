//
//  UIView+ProgressHUD.m
//  Acid
//
//  Created by Vasu Narayan on 24/04/14.
//
//

#import "UIView+ProgressHUD.h"
#import "MBProgressHUD.h"

@implementation UIView (ProgressHUD)

- (void) showHUDWithText:(NSString *) text withUserInteractionDisabled:(BOOL) isDisabled
{
    for (UIView *subview in [self subviews]) {
        if ([subview isKindOfClass:[MBProgressHUD class]]) {
            [subview removeFromSuperview];
        }
    }
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:self];
    
    hud.userInteractionEnabled = isDisabled;
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = text;
    
    
    [self addSubview:hud];
    [hud show:YES];
}

- (void) hideHUD
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *hud = [MBProgressHUD HUDForView:self];
        [hud hide:YES];
        [hud removeFromSuperViewOnHide];
        hud = nil;
    });
    
}

@end
