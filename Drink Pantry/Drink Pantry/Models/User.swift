//
//  User.swift
//  Drink Pantry
//
//  Created by Jared Wolthuis on 9/29/20.
//

import Foundation

class User {
    var name: String
    var email: String
    var userId: String
    // var drinkObjects:
    
    init(name: String, email: String, userId: String = UUID().uuidString) {
        self.name = name
        self.email = email
        self.userId = userId
    }

}
