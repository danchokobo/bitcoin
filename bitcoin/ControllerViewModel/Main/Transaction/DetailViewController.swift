//
//  DetailViewController.swift
//  bitcoin
//
//  Created by Danagul Otel on 22.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import UIKit
import EasyPeasy

class DetailViewController: UIViewController {

    private lazy var viewModule = DetailInfoView()
    var transaction: Transaction!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureContraints()
        // Do any additional setup after loading the view.
    }
    
    
}

extension DetailViewController {
    private func configureViews() {
        view.addSubview(viewModule)
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        viewModule.configureData(transaction: transaction)
    }
    
    private func configureContraints() {
        viewModule.easy.layout([
            Top(100),
            Left(20),
            Right(20),
            Height(250)
        ])
    }
}
