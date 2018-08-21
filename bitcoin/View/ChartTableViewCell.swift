//
//  ChartTableViewCell.swift
//  bitcoin
//
//  Created by Danagul Otel on 20.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import UIKit
import EasyPeasy
import ChartProgressBar

class ChartTableViewCell: UITableViewCell {
    
    static let identifier = "ChartTableViewCell"
    var monthSelected: () -> Void = {}
    var yearSelected: () -> Void = {}
    var weekSelected: () -> Void = {}
    
    lazy var chart = ChartProgressBar().then {
        $0.barWidth = 12
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
    
    lazy var monthButton = UIButton().then {
        $0.setTitle("Month", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(monthDidPress), for: .touchUpInside)
    }
    
    lazy var yearButton = UIButton().then {
        $0.setTitle("Year", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(yearDidPress), for: .touchUpInside)
    }
    
    lazy var weekButton = UIButton().then {
        $0.setTitle("Week", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(weekDidPress), for: .touchUpInside)
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
        contentView.addSubviews(chart,weekButton,monthButton,yearButton)
    }
    
    func configureConstraints() {
        chart.easy.layout([Top(10), Left(10), Right(10), Height(200)])
        weekButton.easy.layout([
            CenterX(),
            Top(5).to(chart),
            Width(100),
            Height(40)
            ])
        monthButton.easy.layout([
            Top(5).to(chart),
            Right(5).to(weekButton),
            Width(100)
            ])
        yearButton.easy.layout([
            Top(5).to(chart),
            Left(5).to(weekButton),
            Width(100)
            ])
        chart.build()
    }
}

extension ChartTableViewCell {
    @objc private func monthDidPress() {
        self.monthSelected()
    }
    
    @objc private func yearDidPress() {
        self.yearSelected()
    }
    
    @objc private func weekDidPress() {
        self.weekSelected()
    }
}
