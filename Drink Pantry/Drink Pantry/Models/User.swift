//
//  User.swift
//  Drink Pantry
//
//  Created by Jared Wolthuis on 9/29/20.
//

import Foundation

class User {
    
    var email: String
    var userId: String
    // var drink objects
    
    init(email: String, userId: String = UUID().uuidString) {
        self.email = email
        self.userId = userId
    }
    
    
}
