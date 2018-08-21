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
        $0.layer.cornerRadius = 10
    }
    
    lazy var periodLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        $0.textColor = .white
        $0.textAlignment = .center
    }
    
    lazy var monthButton = UIButton().then {
        $0.setTitle("Month", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.addTarget(self, action: #selector(monthDidPress), for: .touchUpInside)
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
    }
    
    lazy var yearButton = UIButton().then {
        $0.setTitle("Year", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
        $0.addTarget(self, action: #selector(yearDidPress), for: .touchUpInside)
    }
    
    lazy var weekButton = UIButton().then {
        $0.setTitle("Week", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.layer.cornerRadius = 5
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.white.cgColor
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
        contentView.addSubviews(periodLabel, chart,weekButton,monthButton,yearButton)
    }
    
    func configureConstraints() {
        periodLabel.easy.layout([
            Top(5),
            Left(10),
            Right(10)
            ])
        chart.easy.layout([
            Top(10).to(periodLabel),
            Left(10),
            Right(10),
            Height(300)])
        weekButton.easy.layout([
            CenterX(),
            Top(10).to(chart),
            Width(100),
            Height(40)
            ])
        monthButton.easy.layout([
            Top(10).to(chart),
            Right(5).to(weekButton),
            Left(10),
            Height(40),
            Width(100)
            ])
        yearButton.easy.layout([
            Top(10).to(chart),
            Left(5).to(weekButton),
            Right(10),
            Height(40),
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
