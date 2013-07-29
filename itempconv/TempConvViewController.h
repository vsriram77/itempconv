//
//  TempConvViewController.h
//  itempconv
//
//  Created by Sriram Varadarajan on 7/28/13.
//  Copyright (c) 2013 Y.CORP.YAHOO.COM\vsriram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TempConvViewController : UIViewController<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *fromTextField;
@property (nonatomic, weak) IBOutlet UITextField *toTextField;
@property (nonatomic, weak) IBOutlet UISegmentedControl *fromUnitControl;
@property (nonatomic, weak) IBOutlet UISegmentedControl *toUnitControl;
@property (nonatomic, weak) IBOutlet UILabel *messageLabel;


- (IBAction) onDoneButton;
- (void) textFieldDidChange;
- (void) onUnitValueChanged: (UISegmentedControl *) inputControl;

@end
