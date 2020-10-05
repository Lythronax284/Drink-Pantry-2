//
//  CustomDrinkController.swift
//  Drink Pantry
//
//  Created by Jared Wolthuis on 10/1/20.
//

import UIKit
import FirebaseFirestore
import Firebase


class CustomDrinkController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let db = Firestore.firestore()
        
        //MARK: - shared instance
        static let sharedInstance = CustomDrinkController()
        
        func createCustomDrink(recipeTitle: String, recipeDescription: String, recipeIngredients: String, recipeInstructions: String) {
            let newCustomDrink = CustomDrink(recipeTitle: recipeTitle, recipeDescription: recipeDescription, recipeIngredients: recipeIngredients, recipeInstructions: recipeInstructions, customDrinkPhoto: customDrinkPhoto, prepTime: prepTime, difficulty: difficulty)
            
            let newDocument = db.collection("custom drinks").document()
            newDocument.setData(["newCustomDrink: newCustomDrink"])
            
            db.collection("custom drinks").document("newCustomDrink").delete()
            
            self.CustomDrink = newCustomDrink
        }
        
        db.collection("custom drinks").addDocument(data: ["custom drinks: custom drinks"]) { (error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
            if let profile = snapshot?.data() {
            }
            
            else {
                completion(nil)
            }
        }
    }
}
