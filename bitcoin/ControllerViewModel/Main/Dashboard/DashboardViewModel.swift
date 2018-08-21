//
//  DashboardViewModel.swift
//  bitcoin
//
//  Created by Danagul Otel on 20.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import Foundation
import Alamofire
import  ChartProgressBar

protocol DashboardViewModelDelegate {
    func updateBitcoin()
}
class DashboardViewModel {
    var bitcoin = Bitcoin()
    var delegate: DashboardViewModelDelegate?
    var barData: [BarData] = []
    var dataByMonth: [BarData] = []
    var dataByYear: [BarData] = []
    
    init() {
        getInTenge()
        fetchForWeek(currency: "EUR")
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
    
    private func fetchForWeek(currency: String) {
        let params = [
            "start": dateFormatter(date: getWeekDate()),
            "end": dateFormatter(date: getCurrentDate()),
            "currency": currency
        ]
        
        Alamofire.request(Constants.historical, method: .get, parameters: params).responseJSON { (response) in
            if response.result.isSuccess {
                if let json = response.result.value as? [String: Any] {
                    guard let data = json["bpi"] as? [String: Any] else { return }
                    let m = data.sorted() { $0.key > $1.key }
                    for i in m.enumerated() {
                        let value = i.element.value as! Double
                        let day = self.getDayName(date: i.element.key)
                        self.barData.append(BarData.init(barTitle: day, barValue: Float(value) , pinText: "\(round(value))"))
                    }
                }
            }
        }
        
        
    }
    
    private func fetchForMonth(currency: String) {
        let params = [
            "start": dateFormatter(date: getMonthDate()),
            "end": dateFormatter(date: getCurrentDate()),
            "currency": currency
        ]
        
        Alamofire.request(Constants.historical, method: .get, parameters: params).responseJSON { (response) in
            if response.result.isSuccess {
                if let json = response.result.value as? [String: Any] {
                    guard let data = json["bpi"] as? [String: Any] else { return }
                    let m = data.sorted() { $0.key > $1.key }

                }
            }
        }
    }
    
    private func fetchForYear(currency: String) {
        let params = [
            "start": dateFormatter(date: getYearDate()),
            "end": dateFormatter(date: getCurrentDate()),
            "currency": currency
        ]
        
        Alamofire.request(Constants.historical, method: .get, parameters: params).responseJSON { (response) in
            
        }
    }
    
    private func getDayName(date: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let showDate = inputFormatter.date(from: date)
        inputFormatter.dateFormat = "E"
        return inputFormatter.string(from: showDate!)
    }
    
    private func getCurrentDate() -> Date {
        return Date()
    }
    private func getWeekDate() -> Date {
        return Calendar.current.date(byAdding: .day, value: -7, to: Date())!
    }
    private func getMonthDate() -> Date {
        return Calendar.current.date(byAdding: .day, value: -30, to: Date())!
    }
    private func getYearDate() -> Date {
        return Calendar.current.date(byAdding: .day, value: -365, to: Date())!
    }
    private func dateFormatter(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
}

extension DashboardViewModel {
    func getDollarAmount() -> String {
        let x = bitcoin.dollar ?? 0.0
        return "\((x*100).rounded()/100)"
    }
    
    func getTengeAmount() -> String {
        let x = bitcoin.tenge ?? 0.0
        return "\((x*100).rounded()/100)"
    }
    
    func getEuroAmount() -> String {
        let x = bitcoin.euro ?? 0.0
        return "\((x*100).rounded()/100)"
    }
}
