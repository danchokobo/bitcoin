//
//  TransactionCollectionViewCell.swift
//  bitcoin
//
//  Created by Danagul Otel on 21.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import UIKit
import EasyPeasy

class TransactionTableViewCell: UITableViewCell {
    static let identifier = "TransactionCollectionViewCell"

    lazy var priceLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 30, weight: .thin)
        $0.text = "0.065 ₿ = 6754 $"
        $0.textColor = .white
    }
    
    lazy var arrowImageView = UIImageView().then {
        $0.image = #imageLiteral(resourceName: "right-arrow").resizeImage(24)
        $0.contentMode = .scaleAspectFit
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
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

extension TransactionTableViewCell {
    private func configureViews() {
        contentView.backgroundColor = .clear
        contentView.addSubviews(priceLabel, arrowImageView)
    }
    
    private func configureConstraints() {
        priceLabel.easy.layout([
            CenterY(),
            Left(10),
            Right(15),
            Width(self.bounds.width)
        ])
        arrowImageView.easy.layout([
            CenterY(),
            Size(24),
            Right(10)
            ])
    }
    
    func configureCell(amount: String, price: String?) {
        priceLabel.text = "\(amount)₿ = \(price ?? "")$"
    }
}
