//
//  TransactionViewModel.swift
//  bitcoin
//
//  Created by Danagul Otel on 21.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

protocol TransactionViewModelDelegate: class {
    func dataLoaded()
}

class TransactionViewModel {
    var transactions: [Transaction] = []
    var delegate: TransactionViewModelDelegate?
    
    init() {
        fetchTransactions()
    }
}

extension TransactionViewModel {
    private func fetchTransactions() {
        Alamofire.request(Constants.transactions).responseJSON { (response) in
            if response.result.isSuccess {
                if let json = response.result.value as? [[String: Any]] {
                    let data = json.compactMap({Transaction(JSON: $0)})
                    self.transactions  = Array(data.prefix(500))
                    self.delegate?.dataLoaded()
                }
            }else{
                SVProgressHUD.showError(withStatus: "Problem with internet connection, please try later")
            }
        }
    }
    
    func getDateFromTimeStamp(timeStamp: String) -> String {
        let date = Date(timeIntervalSince1970: Double(timeStamp) ?? 0.0)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "MM.dd.yy HH:mm" //Specify your format that you want
        return dateFormatter.string(from: date)
    }
    
    func getAmount(amount: Double) -> String {
        return String(amount.rounded(toPlaces: 4))
    }
}
