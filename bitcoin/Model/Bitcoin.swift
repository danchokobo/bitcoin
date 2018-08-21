//
//  Bitcoin.swift
//  bitcoin
//
//  Created by Danagul Otel on 20.08.2018.
//  Copyright © 2018 Danagul Otel. All rights reserved.
//

import Foundation
import ObjectMapper

enum Currency {
    case kzt
    case usd
    case euro
}

class Bitcoin: Mappable {
    var euro: Double?
    var tenge: Double?
    var dollar: Double?
    
    init() {
        
    }
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        euro <- map["EUR.rate_float"]
        tenge <- map["KZT.rate_float"]
        dollar <- map["USD.rate_float"]
    }
}
