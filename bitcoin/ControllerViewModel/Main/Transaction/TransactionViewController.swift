//
//  HistoryViewController.swift
//  bitcoin
//
//  Created by Danagul Otel on 20.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import UIKit
import EasyPeasy

class TransactionViewController: UIViewController {

    var viewModel = TransactionViewModel()
    
    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 10
        flowLayout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 50, height: 80)
        return UICollectionView(frame: .zero, collectionViewLayout: flowLayout).then {
            $0.register(TransactionCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: TransactionCollectionViewCell.identifier)
            $0.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 15, right: 0)
            $0.backgroundColor = .clear
            $0.delegate = self
            $0.dataSource = self
            $0.alwaysBounceVertical = true
        }
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        configureContraints()
        title = "Transactions"
        // Do any additional setup after loading the view.
    }
}

extension TransactionViewController {
    private func configureViews() {
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        view.addSubview(collectionView)
    }
    
    private func configureContraints() {
        collectionView.easy.layout([Top(20),Left(),Right(),Bottom()])
    }
}

extension TransactionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TransactionCollectionViewCell.identifier,
                                                         for: indexPath) as? TransactionCollectionViewCell {
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
}
