//
//  DashboardViewController.swift
//  bitcoin
//
//  Created by Danagul Otel on 20.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import UIKit
import EasyPeasy
import SVProgressHUD
import ChartProgressBar
import Charts

class DashboardViewController: UIViewController {

    var viewModel = DashboardViewModel()
    
    private lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(InfoTableViewCell.self, forCellReuseIdentifier: InfoTableViewCell.identifier)
        $0.register(ChartTableViewCell.self, forCellReuseIdentifier: ChartTableViewCell.identifier)
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureConstraints()
        // Do any additional setup after loading the view.
    }
}

extension DashboardViewController {
    private func configureViews() {
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        title = "Main"
        viewModel.delegate = self
        SVProgressHUD.show()
        view.addSubviews(tableView)
    }
    
    private func configureConstraints() {
        tableView.easy.layout([ Edges(0)])
    }
}

extension DashboardViewController: ChartProgressBarDelegate {
    func ChartProgressBar(_ chartProgressBar: ChartProgressBar, didSelectRowAt rowIndex: Int) {
        print(rowIndex)
    }
}
extension DashboardViewController: DashboardViewModelDelegate {
    func updateBitcoin() {
        SVProgressHUD.dismiss()
        tableView.reloadData()
    }
}

extension DashboardViewController {
    func fetchData(currency: String) {
        SVProgressHUD.show()
        viewModel.fetchForWeek(currency: currency)
    }
}
extension DashboardViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: InfoTableViewCell.identifier,
                                                        for: indexPath) as? InfoTableViewCell {
        
                cell.setBitcoin(bitcoin: viewModel.bitcoin)
                cell.dollarSelected = {
                    self.fetchData(currency: "USD")
                    cell.setAmount(currency: .usd)
                }
                cell.tengeSelected = {
                    self.fetchData(currency: "KZT")
                    cell.setAmount(currency: .kzt)
                }
                cell.euroSelected = {
                    self.fetchData(currency: "EUR")
                    cell.setAmount(currency: .euro)
                }
                
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                return cell
            }
        default:
            if let cell = tableView.dequeueReusableCell(withIdentifier: ChartTableViewCell.identifier,
                                                        for: indexPath) as? ChartTableViewCell {
                let line = LineChartDataSet(values: viewModel.weekLineData, label: "Bitcoin")
                cell.backgroundColor = .clear
                cell.selectionStyle = .none
                cell.monthSelected = {
                    line.values = self.viewModel.monthLineData
                    cell.chart.data = self.addChartDataSet(line: line)
                }
                cell.weekSelected = {
                    line.values = self.viewModel.weekLineData
                    cell.chart.data = self.addChartDataSet(line: line)
                }
                cell.yearSelected = {
                    line.values = self.viewModel.yearLineData
                    cell.chart.data = self.addChartDataSet(line: line)
                }
                cell.chart.data = addChartDataSet(line: line)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 200
        default:
            return 300
        }
    }
}

extension DashboardViewController {
    func addChartDataSet(line: LineChartDataSet) -> LineChartData {
        let data = LineChartData()
        data.addDataSet(line)
        return data
    }
}
