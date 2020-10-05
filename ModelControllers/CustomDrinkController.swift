//
//  CustomDrinkController.swift
//  Drink Pantry
//
//  Created by Jared Wolthuis on 10/1/20.
//

import UIKit
import FirebaseFirestore
import Firebase


class CustomDrinkController {
    
    
    // MARK: - Database Reference
    let db = Firestore.firestore()
    
    //MARK: - Shared Instance
    static let sharedInstance = CustomDrinkController()
    
    // MARK: - CRUD FUNCTIONS
    
    
    // MARK: - CREATE A DRINK
    func createCustomDrink(recipeTitle: String, recipeDescription: String, recipeIngredients: String, recipeInstructions: String, customDrinkPhoto: UIImage, prepTime: String, difficulty: String) {
        let newCustomDrink = CustomDrink(recipeTitle: recipeTitle, recipeDescription: recipeDescription, recipeIngredients: recipeIngredients, recipeInstructions: recipeInstructions, customDrinkPhoto: customDrinkPhoto, prepTime: prepTime, difficulty: difficulty)
        
        let newDocument = db.collection("custom drinks").document()
        newDocument.setData(["newCustomDrink": newCustomDrink])
        
        // What is the document name inside collection "custom drinks"? Should we be using the drink's UUID? As of now, the CustomDrinkModel object does NOT have a drinkID property.
        
        // We need to be saving the drinks as documents, with the names of those documents being the drinkID of that drink.
        // The database file structure needs to be something like users<userid<drinkID or something like customDrinks<drinkID< then all of the document data belonging to that drink.
        
        
        
    }
    
    // MARK: - FETCH A DRINK
    
    func fetchDrink() {
        // Here, we should be able to pass in a user's ID, then navigate to that Drink's ID that was tapped on, to then get the data about the drink.
    }
    
    // MARK: - DELETE A DRINK
    
    func deleteDrink() {
        // Here, we should be calling the document.delete() Firestore method, using the drink's ID.
    }
    
    // MARK: - UPDATE A DRINK
    
    func updateDrink() {
        // Here, we need to be calling setData / or something of the like, to UPDATE THE DATA ABOUT A DRINK.
    }
    
    
    //    db.collection("custom drinks").addDocument(data: ["custom drinks: custom drinks"]) { (error) in
    //    if let error = error {
    //    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
    //    }
    //    if let profile = snapshot?.data() {
    //    }
    //
    //    else {
    //    completion(nil)
    //    }
    //    }
}

