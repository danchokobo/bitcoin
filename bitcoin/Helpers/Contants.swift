//
//  Contants.swift
//  bitcoin
//
//  Created by Danagul Otel on 20.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import UIKit

struct Constants {
    public static let serverCoindesk = "https://api.coindesk.com/v1/bpi"
    public static let getEuro = "\(serverCoindesk)/currentprice/EUR.json"
    public static let getTenge = "\(serverCoindesk)/currentprice/KZT.json"
    public static let getDollar = "\(serverCoindesk)/currentprice/USD.json"
    public static let historical = "\(serverCoindesk)/historical/close.json"
    public static let transactions = "https://www.bitstamp.net/api/v2/transactions/btcusd"
}
