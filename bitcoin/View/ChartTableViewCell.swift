//
//  ChartTableViewCell.swift
//  bitcoin
//
//  Created by Danagul Otel on 20.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import UIKit
import EasyPeasy
import Charts

class ChartTableViewCell: UITableViewCell {
    
    static let identifier = "ChartTableViewCell"
    var monthSelected: () -> Void = {}
    var yearSelected: () -> Void = {}
    var weekSelected: () -> Void = {}
    
    lazy var chart = LineChartView().then {
        $0.backgroundColor = .white
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
        contentView.backgroundColor = .clear
        contentView.addSubviews(chart,weekButton,monthButton,yearButton)
    }
    
    func configureConstraints() {
        chart.easy.layout([Top(10), Left(10), Right(10), Height(250)])
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
