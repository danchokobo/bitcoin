//
//  TestViewController.h
//  bitcoin
//
//  Created by Danagul Otel on 22.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConverterViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *moneyTextfield;
    UILabel *btxLabel;
    UILabel *resultLabel;
    UIButton *convertButton;
    UIButton *dollarButton;
    UIButton *euroButton;
    UIButton *tengeButton;
    
}
@end
