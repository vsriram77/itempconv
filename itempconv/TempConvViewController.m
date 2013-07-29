//
//  TempConvViewController.m
//  itempconv
//
//  Created by Sriram Varadarajan on 7/28/13.
//  Copyright (c) 2013 Y.CORP.YAHOO.COM\vsriram. All rights reserved.
//

#import "TempConvViewController.h"



enum TempUnit{
    FAHRENHEIT = 0,
    CELSIUS = 1
    };

@interface TempConvViewController ()

- (float) convertFahrenheitToCelsius: (float) input;
- (float) convertCelsiusToFahrenheit: (float) input;
- (float) convertTemperature: (UITextField *) inputTextField masterControl:(UISegmentedControl *) inputControl;

@end

@implementation TempConvViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self setTitle: @"Temperature Converter"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.fromTextField.delegate = self;
    self.toTextField.delegate = self;
    [self.fromTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.toTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.fromUnitControl addTarget:self action:@selector(onUnitValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.toUnitControl addTarget:self action:@selector(onUnitValueChanged:) forControlEvents:UIControlEventValueChanged];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - other
- (void) onDoneButton {
    self.navigationItem.rightBarButtonItem = nil;
    [self.view endEditing:YES];
}

- (void) onUnitValueChanged: (UISegmentedControl *) inputControl
{
    BOOL fromIsMaster = (inputControl == self.fromUnitControl)? YES : NO;

    UISegmentedControl *masterControl = inputControl;
    UISegmentedControl *slaveControl = fromIsMaster? self.toUnitControl : self.fromUnitControl;
    UITextField *masterTextField = fromIsMaster? self.fromTextField : self.toTextField;
    UITextField *slaveTextField = fromIsMaster? self.toTextField : self.fromTextField;

    [slaveControl setSelectedSegmentIndex: (masterControl.selectedSegmentIndex == FAHRENHEIT) ? CELSIUS :
     FAHRENHEIT  ];
    
    self.messageLabel.text = (self.fromUnitControl.selectedSegmentIndex == FAHRENHEIT)? @"Convert Fahrenheit to Celsius"
    : @"Convert Celsius to Fahrenheit";
    
    float outputValue = [self convertTemperature:masterTextField masterControl:masterControl];
    [slaveTextField setText: [NSString stringWithFormat:@"%0.2f", outputValue] ];
    
    
    
}

- (float) convertTemperature: (UITextField *) inputTextField masterControl:(UISegmentedControl *) inputControl
{
    float inputValue = [inputTextField.text floatValue];
    float outputValue  = (inputControl.selectedSegmentIndex == FAHRENHEIT)?
    [self convertFahrenheitToCelsius: inputValue] : [self convertCelsiusToFahrenheit: inputValue];
    return outputValue;
}


- (float) convertFahrenheitToCelsius: (float) input
{
    return (input  -  32)  *  5/9 ;
   
}

- (float) convertCelsiusToFahrenheit: (float) input
{
    return (input * 9/5) + 32;
    
}

- (void) textFieldDidChange: (UITextField*) textField {
    if (self.fromTextField.editing) {
        float outputValue = [self convertTemperature:self.fromTextField masterControl:self.fromUnitControl];
        [self.toTextField setText: [NSString stringWithFormat:@"%0.2f", outputValue] ];
    } else {
        float outputValue = [self convertTemperature:self.toTextField masterControl:self.toUnitControl];
        [self.fromTextField setText: [NSString stringWithFormat:@"%0.2f", outputValue] ];
    }
}


#pragma mark - UITextField delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone  target:self action:@selector(onDoneButton)];
    
    return YES;
}

- (BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}

@end
