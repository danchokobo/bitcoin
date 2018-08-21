//
//  TransactionViewModel.swift
//  bitcoin
//
//  Created by Danagul Otel on 21.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import Foundation
import Alamofire

class TransactionViewModel {
    var transactions: [Transaction] = []
    
    init() {
        fetchTransactions()
    }
}

extension TransactionViewModel {
    private func fetchTransactions() {
        Alamofire.request(Constants.transactions).responseJSON { (response) in
            if response.result.isSuccess {
                if let json = response.result.value as? [[String: Any]] {
                    
                }
            }
        }
    }
}
