//
//  User.swift
//  Drink Pantry
//
//  Created by Jared Wolthuis on 9/29/20.
//

import Foundation

class User: Codable {
    var name: String
    var email: String
    var userId: String?
    // var drinkObjects:
    //userId: String = UUID().uuidString
    init(name: String, email: String, userId: String = "") {
        self.name = name
        self.email = email
        self.userId = userId
    }

}
extension User: Equatable {
	static func == (lhs: User, rhs: User) -> Bool {
		return lhs.userId == rhs.userId
	}
	
	
}
