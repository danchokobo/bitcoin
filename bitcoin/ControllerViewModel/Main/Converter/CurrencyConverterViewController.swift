//
//  CurrencyConverterViewController.swift
//  bitcoin
//
//  Created by Danagul Otel on 20.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import UIKit

class CurrencyConverterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        
        let cv = Converter()
        cv.testProperty = "lol"
        // Do any additional setup after loading the view.
    }
}
