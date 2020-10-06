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
    
    //MARK: - Source of Truth
    
    var customDrinks: [CustomDrink] = []
    
    // MARK: - CRUD FUNCTIONS
    
    
    // MARK: - CREATE A DRINK
    func createCustomDrink(recipeTitle: String, recipeDescription: String, recipeIngredients: String, recipeInstructions: String, customDrinkPhoto: String, prepTime: String, difficulty: String) {
        let newCustomDrink = CustomDrink(recipeTitle: recipeTitle, recipeDescription: recipeDescription, recipeIngredients: recipeIngredients, recipeInstructions: recipeInstructions, customDrinkPhoto: customDrinkPhoto, prepTime: prepTime, difficulty: difficulty)
        
        guard let user = UserController.sharedInstance.currentUser else { return
        }
        
        let newDocument = db.collection("users").document(user.userId).collection("custom drinks").document(newCustomDrink.customDrinkID)
        newDocument.setData(["recipe title": newCustomDrink.recipeTitle as Any,
                             "recipe description": newCustomDrink.recipeDescription as Any,
                             "recipe ingredients": newCustomDrink.recipeIngredients as Any,
                             "recipe instructions": newCustomDrink.recipeInstructions as Any,
                             "custom drink photo": newCustomDrink.customDrinkPhoto as Any,
                             "prep time": newCustomDrink.prepTime as Any,
                             "difficulty": newCustomDrink.difficulty as Any,
                             "customDrinkID": newCustomDrink.customDrinkID as Any])
    }
    
    // MARK: - FETCH A DRINK
    
    func fetchUserCustomDrinks(completion: @escaping (Bool) -> Void) {
        guard let user = UserController.sharedInstance.currentUser else { return
        }
        db.collection("users").document(user.userId).collection("custom drinks").addSnapshotListener { (querysnapshot, error) in
            
            if let error = error {
                print("Error in \(error)")
                return completion(false)
            }
            
            if let snapshot = querysnapshot  {
                for doc in snapshot.documents {
                    
                    let drinkData = doc.data()
                    let recipeTitle = drinkData["recipeTitle"] as? String ?? ""
                    let recipeDescription = drinkData["recipeDescription"] as? String ?? ""
                    let recipeIngredients = drinkData["recipeIngredients"] as? String ?? ""
                    let recipeInstructions = drinkData["recipeInstructions"] as? String ?? ""
                    let customDrinkPhoto = drinkData["customDrinkPhoto"] as? String ?? ""
                    let prepTime = drinkData["prepTime"] as? String ?? ""
                    let difficulty = drinkData["difficulty"] as? String ?? ""
                    let customDrinkID = drinkData["customDrinkID"] as? String ?? ""
                    
                    let customDrink = CustomDrink(recipeTitle: recipeTitle, recipeDescription: recipeDescription, recipeIngredients: recipeIngredients, recipeInstructions: recipeInstructions, customDrinkPhoto: customDrinkPhoto, prepTime: prepTime, difficulty: difficulty, customDrinkID: customDrinkID)
                    
                    CustomDrinkController.sharedInstance.customDrinks.append(customDrink)
                    
                }
                
                completion(true)
                
            }
            
        }
        
        
        
        // Here, we should be able to pass in a user's ID, then navigate to that Drink's ID that was tapped on, to then get the data about the drink.
    }
    
    // MARK: - DELETE A DRINK
    
    func deleteUserCustomDrink(drink: CustomDrink) {
        guard let user = UserController.sharedInstance.currentUser else { return }
        db.collection("users").document(user.userId).collection("custom drinks").document(drink.customDrinkID).delete()
        guard let index = CustomDrinkController.sharedInstance.customDrinks.firstIndex(of: drink) else { return }
        customDrinks.remove(at: index)
        print("\(drink.recipeTitle) was successfully deleted from the database.")
    
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

