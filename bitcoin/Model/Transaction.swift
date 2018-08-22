//
//  Transaction.swift
//  bitcoin
//
//  Created by Danagul Otel on 21.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import Foundation
import ObjectMapper

class Transaction: Mappable {
    var date: String?
    var id: String?
    var price: String?
    var type: String?
    var amount : String?
    
    init() {}
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        date <- map["date"]
        id <- map["tid"]
        price <- map["price"]
        type <- map["type"]
        amount <- map["amount"]
    }
}
