//
//  File.swift
//  Mealette
//
//  Created by Bhavya Shah on 2019-12-20.
//  Copyright © 2019 Bhavya Shah. All rights reserved.
//

import Foundation

class User {
    
    var userId : String = ""
    var userName : String = ""
    var fullName : String = ""
    var email : String = ""
    var friends : [String]
    
    init(uid: String, uname: String, fname: String, em: String, fri: [String]) {
        self.userId = uid
        self.userName = uname
        self.fullName = fname
        self.email = em
        self.friends = fri
    }
}
