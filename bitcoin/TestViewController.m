//
//  TestViewController.m
//  bitcoin
//
//  Created by Danagul Otel on 22.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor alloc] initWithRed: 0.05882352963 green: 0.180392161 blue: 0.2470588237 alpha: 1.0];
    self.navigationItem.title = @"Calculator";
    [ self configureTextfields];
    [ self configureLabel];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [moneyTextfield resignFirstResponder];
    return YES;
}

- (void) configureTextfields {
    UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 50)];
    numberToolbar.barStyle = UIBarStyleBlackTranslucent;
    numberToolbar.items = [NSArray arrayWithObjects:
                           [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                           [[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                           nil];
    [numberToolbar sizeToFit];
    moneyTextfield = [[UITextField alloc] initWithFrame: CGRectMake(20, 100, self.view.frame.size.width - 40, 44)];
    moneyTextfield.backgroundColor = [UIColor whiteColor];
    moneyTextfield.font = [UIFont systemFontOfSize:15];
    moneyTextfield.placeholder = @"Enter amount of Bitcoin";
    moneyTextfield.textAlignment = NSTextAlignmentCenter;
    moneyTextfield.autocorrectionType = UITextAutocorrectionTypeNo;
    moneyTextfield.keyboardType = UIKeyboardTypeNumberPad;
    moneyTextfield.returnKeyType = UIReturnKeyDone;
    moneyTextfield.inputAccessoryView = numberToolbar;
    moneyTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
    moneyTextfield.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    moneyTextfield.delegate = self;
    
    [self.view addSubview:moneyTextfield];
}

- (void) configureLabel {
    btxLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 150, self.view.frame.size.width - 40, 44)];
    btxLabel.text = @"XBT";
    btxLabel.font = [UIFont systemFontOfSize: 32];
    btxLabel.textColor = [UIColor whiteColor];
    btxLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:btxLabel];
    
    resultLabel = [[UILabel alloc] initWithFrame: CGRectMake(20, 200, self.view.frame.size.width - 40, 44)];
    resultLabel.text = @"0.0071 B";
    resultLabel.font = [UIFont systemFontOfSize: 36];
    resultLabel.backgroundColor = [UIColor whiteColor];
    resultLabel.textColor = [UIColor blackColor];
    resultLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:resultLabel];
    convertButton = [[UIButton alloc] initWithFrame: CGRectMake(20, 250, self.view.frame.size.width - 40, 44)];
    convertButton.layer.borderWidth = 1;
    convertButton.layer.borderColor = [UIColor whiteColor].CGColor;
    convertButton.backgroundColor = [UIColor clearColor];
    [convertButton setTitle:@"How much I can buy?" forState: UIControlStateNormal];
    [convertButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    convertButton.
    [self.view addSubview:convertButton];
}

- (void) configureButton {
    
}


- (void) doneWithNumberPad {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

@end
