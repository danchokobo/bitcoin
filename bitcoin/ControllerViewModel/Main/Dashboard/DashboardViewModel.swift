//
//  DashboardViewModel.swift
//  bitcoin
//
//  Created by Danagul Otel on 20.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import Foundation
import Alamofire

protocol DashboardViewModelDelegate {
    func updateBitcoin()
}
class DashboardViewModel {
    var bitcoin = Bitcoin()
    var delegate: DashboardViewModelDelegate?
    
    init() {
        getInTenge()
    }
}

extension DashboardViewModel {
    private func getInDollar() {
        Alamofire.request(Constants.getDollar).responseJSON { response in
            if response.result.isSuccess {
                if let json = response.result.value as? [String: Any] {
                    guard let data = json["bpi"] as? [String: Any] else {
                        return
                    }
                    let bit = Bitcoin(JSON: data)
                    self.bitcoin.dollar = bit?.dollar
                    self.getInEuro()
                }
            }
        }
    }
    
    private func getInTenge() {
        Alamofire.request(Constants.getTenge).responseJSON { response in
            if response.result.isSuccess {
                if let json = response.result.value as? [String: Any] {
                    guard let data = json["bpi"] as? [String: Any] else {
                        return
                    }
                    let bit = Bitcoin(JSON: data)
                    self.bitcoin.tenge = bit?.tenge
                    self.getInDollar()
                }
            }
        }
    }
    
    private func getInEuro() {
        Alamofire.request(Constants.getEuro).responseJSON { response in
            if response.result.isSuccess {
                if let json = response.result.value as? [String: Any] {
                    guard let data = json["bpi"] as? [String: Any] else {
                        return
                    }
                    let bit = Bitcoin(JSON: data)
                    self.bitcoin.euro = bit?.euro
                    self.delegate?.updateBitcoin()
                }
            }
        }
    }
    
    func getDollarAmount() -> String {
        return "\(bitcoin.dollar ?? 0.0)"
    }
    
    func getTengeAmount() -> String {
        return "\(bitcoin.tenge ?? 0.0)"
    }
    
    func getEuroAmount() -> String {
        return "\(bitcoin.euro ?? 0.0)"
    }
}
