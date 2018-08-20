//
//  Contants.swift
//  bitcoin
//
//  Created by Danagul Otel on 20.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import UIKit

struct Constants {
    public static let currentPrice = "https://api.coindesk.com/v1/bpi/currentprice"
    public static let getEuro = "\(currentPrice)/EUR.json"
    public static let getTenge = "\(currentPrice)/KZT.json"
    public static let getDollar = "\(currentPrice)/USD.json"
}
