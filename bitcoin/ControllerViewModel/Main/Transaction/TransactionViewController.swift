//
//  HistoryViewController.swift
//  bitcoin
//
//  Created by Danagul Otel on 20.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import UIKit
import EasyPeasy
import SVProgressHUD

class TransactionViewController: UIViewController {

    var viewModel = TransactionViewModel()
    private lazy var tableView = UITableView().then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(TransactionTableViewCell.self, forCellReuseIdentifier: TransactionTableViewCell.identifier)
        $0.backgroundColor = .clear
        $0.showsVerticalScrollIndicator = false

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.show()
        configureViews()
        configureContraints()
        title = "Transactions"
        // Do any additional setup after loading the view.
    }
}

extension TransactionViewController {
    private func configureViews() {
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        view.addSubview(tableView)
        viewModel.delegate = self
    }
    
    private func configureContraints() {
        tableView.easy.layout([Edges(15)])
    }
}

extension TransactionViewController: TransactionViewModelDelegate {
    func dataLoaded() {
        tableView.reloadData()
        SVProgressHUD.dismiss()
    }
}

extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.identifier,
                                                    for: indexPath) as? TransactionTableViewCell {
            let model = viewModel.transactions[indexPath.row]
            let amount = viewModel.getAmount(amount: model.amount)
            cell.configureCell(amount: amount, price: model.price)
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.transactions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

