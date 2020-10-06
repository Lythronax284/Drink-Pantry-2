//
//  CustomDrink.swift
//  Drink Pantry
//
//  Created by Jared Wolthuis on 10/1/20.
//

import Foundation
import UIKit

class CustomDrink {
    
    
    var recipeTitle: String
    var recipeDescription: String
    var recipeIngredients: String
    var recipeInstructions: String
    var customDrinkPhoto: String
    var prepTime: String
    var difficulty: String
    var customDrinkID: String
    
    init(recipeTitle: String, recipeDescription: String, recipeIngredients: String, recipeInstructions: String, customDrinkPhoto: String, prepTime: String, difficulty: String, customDrinkID: String = UUID().uuidString) {
        self.recipeTitle = recipeTitle
        self.recipeDescription = recipeDescription
        self.recipeIngredients = recipeIngredients
        self.recipeInstructions = recipeInstructions
        self.customDrinkPhoto = customDrinkPhoto
        self.prepTime = prepTime
        self.difficulty = difficulty
        self.customDrinkID = customDrinkID
        
    }
}

extension CustomDrink: Equatable {
    static func == (lhs: CustomDrink, rhs: CustomDrink) -> Bool {
        return lhs.customDrinkID == rhs.customDrinkID
    }
}
