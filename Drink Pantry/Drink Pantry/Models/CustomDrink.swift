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
    var customDrinkPhoto: UIImage?
    var prepTime: String
    var difficulty: String
    
    init(recipeTitle: String, recipeDescription: String, recipeIngredients: String, recipeInstructions: String, customDrinkPhoto: UIImage?, prepTime: String, difficulty: String) {
        self.recipeTitle = recipeTitle
        self.recipeDescription = recipeDescription
        self.recipeIngredients = recipeIngredients
        self.recipeInstructions = recipeInstructions
        self.customDrinkPhoto = customDrinkPhoto
        self.prepTime = prepTime
        self.difficulty = difficulty
         
        
    }
}
