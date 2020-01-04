//
//  ordered.swift
//  Mealette
//
//  Created by Bhavya Shah on 2019-12-22.
//  Copyright © 2019 Bhavya Shah. All rights reserved.
//

import Foundation

class ordered {
    
    var name: String = ""
    var fav: Bool?
    
    init(item: String, f: Bool?) {
        self.name = item
        self.fav = f
    }
}
