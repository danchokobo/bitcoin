//
//  DashboardViewModel.swift
//  bitcoin
//
//  Created by Danagul Otel on 20.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD
import Charts

protocol DashboardViewModelDelegate {
    func updateBitcoin()
}
class DashboardViewModel {
    var bitcoin = Bitcoin()
    var delegate: DashboardViewModelDelegate?
    var weekLineData = [ChartDataEntry]()
    var monthLineData = [ChartDataEntry]()
    var yearLineData = [ChartDataEntry]()
    
    init() {
        getInTenge()
        fetchForWeek(currency: "USD")
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
    
    func fetchForWeek(currency: String) {
        let params = [
            "start": dateFormatter(date: getWeekDate()),
            "end": dateFormatter(date: getCurrentDate()),
            "currency": currency
        ]
        weekLineData.removeAll()
        Alamofire.request(Constants.historical, method: .get, parameters: params).responseJSON { (response) in
            if response.result.isSuccess {
                if let json = response.result.value as? [String: Any] {
                    guard let data = json["bpi"] as? [String: Any] else { return }
                    let m = data.sorted() { $0.key > $1.key }
                    var lol = 0
                    for i in m.enumerated() {
                        lol += 1
                        let value = ChartDataEntry(x: Double(lol), y: i.element.value as! Double)
                        self.weekLineData.append(value)
                    }
                    self.fetchForMonth(currency: currency)
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
                    self.getDataForMonth(data: data)
                    self.fetchForYear(currency: currency)
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
            if response.result.isSuccess {
                if let json = response.result.value as? [String: Any] {
                    guard let data = json["bpi"] as? [String: Any] else { return }
                    self.getDataForYear(data: data)
                    SVProgressHUD.dismiss()
                    self.delegate?.updateBitcoin()
                }
            }
        }
    }
    
    private func getDayName(date: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let showDate = inputFormatter.date(from: date)
        inputFormatter.dateFormat = "E"
        return inputFormatter.string(from: showDate!)
    }

    private func getDataForMonth(data: [String: Any]) {
        monthLineData.removeAll()
        let sortedData = data.sorted() { $0.key > $1.key }
        var lol = 0
        var values = [Double]()
        var weekNo = 1
        for i in sortedData.enumerated() {
            lol += 1
            if( lol % 7 != 0) {
                values.append(i.element.value as! Double)
            }else{
                let value = ChartDataEntry(x: Double(weekNo), y: values.average)
                self.monthLineData.append(value)
                weekNo += 1
            }
        }
    }
    
    private func getDataForYear(data: [String: Any]) {
        yearLineData.removeAll()
        let sortedData = data.sorted() { $0.key > $1.key }
        var lol = 0
        var values = [Double]()
        var monthNo = 1
        for i in sortedData.enumerated() {
            lol += 1
            if( lol % 30 != 0) {
                values.append(i.element.value as! Double)
            }else{
                let value = ChartDataEntry(x: Double(monthNo), y: values.average)
                self.yearLineData.append(value)
                monthNo += 1
            }
        }
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
