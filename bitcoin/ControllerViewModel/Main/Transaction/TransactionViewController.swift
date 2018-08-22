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
    let segmentedControl = UISegmentedControl(items: ["Buy", "Sell"])
    var transactions: [Transaction] = [] {
        didSet {
            SVProgressHUD.dismiss()
            tableView.reloadData()
        }
    }
    
    private var navbarView = UIView().then {
        $0.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
    }
    
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
        // Do any additional setup after loading the view.
    }
}

extension TransactionViewController {
    private func configureViews() {
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        view.addSubviews(navbarView,tableView)
        viewModel.delegate = self
        navigationItem.titleView = segmentedControl
        segmentedControl.frame = CGRect(x: 0, y: 15, width: view.bounds.width - 50, height: 40)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
    }
    
    private func configureContraints() {
        navbarView.easy.layout([Top(),Left(),Right(), Height(56)])
        tableView.easy.layout([Top(10).to(navbarView), Left(10), Right(10), Bottom()])
    }
}

extension TransactionViewController: TransactionViewModelDelegate {
    func dataLoaded() {
        SVProgressHUD.dismiss()
        transactions = viewModel.transactionsForBuy
        tableView.reloadData()
    }
}

extension TransactionViewController {
    @objc func indexChanged(_ sender: UISegmentedControl) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            self.transactions = viewModel.transactionsForBuy
            self.tableView.reloadData()
        case 1:
            self.transactions = viewModel.transactionsForSell
            self.tableView.reloadData()
        default:
            break;
        }
    }
}
extension TransactionViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TransactionTableViewCell.identifier,
                                                    for: indexPath) as? TransactionTableViewCell {
            let model = transactions[indexPath.row]
            let amount = viewModel.getAmount(amount: model.amount)
            cell.configureCell(amount: amount, price: model.price)
            cell.selectionStyle = .none
            cell.backgroundColor = .clear
            return cell
        }
        return UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        navigationController?.hidesBarsOnSwipe = false
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailViewController()
        vc.transaction = transactions[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}
