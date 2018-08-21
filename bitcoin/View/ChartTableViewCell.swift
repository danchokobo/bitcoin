//
//  ChartTableViewCell.swift
//  bitcoin
//
//  Created by Danagul Otel on 20.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import UIKit
import SwiftChart
import EasyPeasy
import ChartProgressBar

class ChartTableViewCell: UITableViewCell {
    
    static let identifier = "ChartTableViewCell"

    lazy var chart = ChartProgressBar().then {
        $0.barWidth = 7
        $0.progressClickColor = .yellow
        $0.pinBackgroundColor = .yellow
        $0.pinTxtColor = .blue
        $0.barTitleColor = .gray
        $0.barTitleSelectedColor = .white
        $0.pinMarginBottom = 15
        $0.pinWidth = 70
        $0.pinHeight = 29
        $0.pinTxtSize = 17
        $0.barsCanBeClick = true
        $0.emptyColor = UIColor.clear
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

extension ChartTableViewCell {
    func configureViews() {
        contentView.addSubview(chart)
    }
    
    func configureConstraints() {
        chart.easy.layout([Edges(15)])
    }
}
