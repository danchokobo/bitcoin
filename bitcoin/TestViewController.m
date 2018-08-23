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
    [numberToolbar setTintColor:[UIColor whiteColor]];
    [numberToolbar sizeToFit];
    moneyTextfield = [[UITextField alloc] initWithFrame: CGRectMake(20, 100, self.view.frame.size.width - 40, 44)];
    moneyTextfield.backgroundColor = [UIColor whiteColor];
    moneyTextfield.font = [UIFont systemFontOfSize:32];
    moneyTextfield.placeholder = @"Enter money";
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
    [convertButton addTarget:self action:@selector(getAmountOfBitcoin:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:convertButton];
    
    double widthOfButton = (self.view.frame.size.width - 40)/3;
    dollartButton = [[UIButton alloc] initWithFrame: CGRectMake(20, 50, widthOfButton, 44)];
    dollartButton.layer.borderWidth = 1;
    dollartButton.layer.borderColor = [UIColor whiteColor].CGColor;
    dollartButton.backgroundColor = [UIColor clearColor];
    [dollartButton setTitle:@"$" forState: UIControlStateNormal];
    [dollartButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:dollartButton];
    
    tengeButton = [[UIButton alloc] initWithFrame: CGRectMake(widthOfButton + 20, 50, widthOfButton, 44)];
    tengeButton.layer.borderWidth = 1;
    tengeButton.layer.borderColor = [UIColor whiteColor].CGColor;
    tengeButton.backgroundColor = [UIColor clearColor];
    [tengeButton setTitle:@"₸" forState: UIControlStateNormal];
    [tengeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:tengeButton];
    
    euroButton = [[UIButton alloc] initWithFrame: CGRectMake(widthOfButton*2 + 20, 50, widthOfButton, 44)];
    euroButton.layer.borderWidth = 1;
    euroButton.layer.borderColor = [UIColor whiteColor].CGColor;
    euroButton.backgroundColor = [UIColor clearColor];
    [euroButton setTitle:@"€" forState: UIControlStateNormal];
    [euroButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:euroButton];

}


- (void) doneWithNumberPad {
    [[UIApplication sharedApplication] sendAction:@selector(resignFirstResponder) to:nil from:nil forEvent:nil];
}

-(void)getAmountOfBitcoin:(UIButton *)sender
{
    // do calculation
    resultLabel.text = @"77777 B";
}

@end
