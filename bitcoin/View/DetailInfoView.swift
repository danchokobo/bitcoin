//
//  DetailInfoView.swift
//  bitcoin
//
//  Created by Danagul Otel on 22.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import UIKit
import EasyPeasy

class DetailInfoView: UIView {
    
    lazy var idLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        $0.text = "TID: "
        $0.textColor = #colorLiteral(red: 0.06666666667, green: 0.05098039216, blue: 0.2784313725, alpha: 1)
    }
    
    lazy var idValueLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 22, weight: .light)
        $0.text = "312312312"
        $0.textAlignment = .right
    }
    
    lazy var dateLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        $0.textColor = #colorLiteral(red: 0.06666666667, green: 0.05098039216, blue: 0.2784313725, alpha: 1)
        $0.text = "17.05.18 14:43"
        $0.textAlignment = .right
    }
    
    lazy var amountLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        $0.text = "AMOUNT: "
        $0.textColor = #colorLiteral(red: 0.06666666667, green: 0.05098039216, blue: 0.2784313725, alpha: 1)
    }
    
    lazy var amountValueLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 22, weight: .light)
        $0.text = "0.001 B"
        $0.textAlignment = .right
    }
    
    lazy var priceLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 32, weight: .light)
        $0.text = "6543 $"
        $0.textAlignment = .right
    }
    
    lazy var typeIconImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = #imageLiteral(resourceName: "sold").resizeImage(44)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        configureContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailInfoView {
    private func configureViews() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 5
        self.addSubviews(dateLabel, idLabel, idValueLabel, amountLabel, amountValueLabel, priceLabel, typeIconImageView)
    }
    
    private func configureContraints() {
        dateLabel.easy.layout([
            Top(25),
            Right(20)
        ])
        idLabel.easy.layout([
            Top(60),
            Left(20),
            Width(50)
        ])
        idValueLabel.easy.layout([
            Top(60),
            Left(5).to(idLabel),
            Right(20)
        ])
        amountLabel.easy.layout([
            Top(20).to(idLabel),
            Left(20),
            Width(130)
        ])
        amountValueLabel.easy.layout([
            Top(20).to(idValueLabel),
            Left(5).to(amountLabel),
            Right(20)
            ])
        priceLabel.easy.layout([
            Bottom(20),
            Right(20)
        ])
        typeIconImageView.easy.layout([
            Bottom(25),
            Left(20),
            Size(50)
            ])
    }
    
    func configureData(transaction: Transaction) {
        idValueLabel.text = transaction.id
        amountValueLabel.text = transaction.amount
        priceLabel.text = "\(transaction.price ?? "") $"
        typeIconImageView.image = transaction.type == "0" ? #imageLiteral(resourceName: "buy").resizeImage(44) : #imageLiteral(resourceName: "sold").resizeImage(50)
    }
}
