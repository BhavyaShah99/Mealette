//
//  cooked.swift
//  Mealette
//
//  Created by Bhavya Shah on 2019-12-22.
//  Copyright © 2019 Bhavya Shah. All rights reserved.
//

import Foundation

class cooked: NSObject {
    
    var name: String!
    var ingredients: String!
    var recipe: String!
    var fav: Bool!
    
    init(item: String?, ing: String?, rec: String?, f: Bool?) {
        self.name = item
        self.ingredients = ing
        self.recipe = rec
        self.fav = f
    }
}
