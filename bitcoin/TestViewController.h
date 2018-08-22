//
//  TestViewController.h
//  bitcoin
//
//  Created by Danagul Otel on 22.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController<UITextFieldDelegate>
{
    UITextField *moneyTextfield;
    UILabel *btxLabel;
    UILabel *resultLabel;
    UIButton *convertButton;
}
@end
