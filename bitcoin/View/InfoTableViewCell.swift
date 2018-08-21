//
//  InfoTableViewCell.swift
//  bitcoin
//
//  Created by Danagul Otel on 20.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import UIKit
import EasyPeasy
import Sugar

class InfoTableViewCell: UITableViewCell {
    
    static let identifier = "InfoTableViewCell"
    
    var dollarSelected: () -> Void = {}
    var tengeSelected: () -> Void = {}
    var euroSelected: () -> Void = {}
    var currentCurrency: Currency!
    
    private lazy var amountLabel = UILabel().then {
        $0.textColor = .white
        $0.textAlignment = .center
        $0.font = UIFont.systemFont(ofSize: 40)
    }
    
    private lazy var dollarButton = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "american-dollar-symbol").resizeImage(32), for: .selected)
        $0.setImage(#imageLiteral(resourceName: "dollarSelected").resizeImage(32), for: .normal)
        $0.addTarget(self, action: #selector(dollarSelected(button:)), for: .touchUpInside)
    }
    
    private lazy var tengeButton = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "tenge").resizeImage(22), for: .selected)
        $0.setImage(#imageLiteral(resourceName: "tengeSelected").resizeImage(22), for: .normal)
        $0.addTarget(self, action: #selector(tengeSelected(button:)), for: .touchUpInside)
    }
    
    private lazy var euroButton = UIButton().then {
        $0.setImage(#imageLiteral(resourceName: "euro-symbol").resizeImage(32), for: .selected)
        $0.setImage(#imageLiteral(resourceName: "euroSelected").resizeImage(32), for: .normal)
        $0.addTarget(self, action: #selector(euroSelected(button:)), for: .touchUpInside)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InfoTableViewCell {
    
    func configureViews() {
        tengeButton.isSelected = true
        contentView.backgroundColor = .clear
        contentView.addSubviews(amountLabel, dollarButton, tengeButton, euroButton)
    }
    
    func configureConstraints() {
        amountLabel.easy.layout([
            Top(10),
            Left(20),
            Right(20),
            Height(50)
        ])
        tengeButton.easy.layout([
            CenterX(),
            Top(20).to(amountLabel),
            Size(44)
        ])
        dollarButton.easy.layout([
            Top(20).to(amountLabel),
            Left(20),
            Right(20).to(tengeButton),
            Size(44),
        ])
        euroButton.easy.layout([
            Top(20).to(amountLabel),
            Left(20).to(tengeButton),
            Right(20),
            Size(44)
        ])
        
    }
}

extension InfoTableViewCell {
    func setBitcoin(bitcoin: Bitcoin) {
        switch currentCurrency {
        case .kzt:
            let x = bitcoin.tenge ?? 0.0
            amountLabel.text = "\((x*100).rounded()/100)"
        case .usd:
            let x = bitcoin.dollar ?? 0.0
            amountLabel.text = "\((x*100).rounded()/100)"
        case .euro:
            let x = bitcoin.euro ?? 0.0
            amountLabel.text = "\((x*100).rounded()/100)"
        default:
            let x = bitcoin.tenge ?? 0.0
            amountLabel.text = "\((x*100).rounded()/100)"
        }
        
    }
    
    func setAmount(currency: Currency) {
        currentCurrency = currency
    }
    
    @objc func dollarSelected(button: UIButton) {
        self.dollarSelected()
        button.isSelected = !button.isSelected
        tengeButton.isSelected = false
        euroButton.isSelected = false
    }
    
    @objc func tengeSelected(button: UIButton) {
        self.tengeSelected()
        button.isSelected = !button.isSelected
        euroButton.isSelected = false
        dollarButton.isSelected = false
    }
    
    @objc func euroSelected(button: UIButton) {
        self.euroSelected()
        button.isSelected = !button.isSelected
        tengeButton.isSelected = false
        dollarButton.isSelected = false
    }
}


