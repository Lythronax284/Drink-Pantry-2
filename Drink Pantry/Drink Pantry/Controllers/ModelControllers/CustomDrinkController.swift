//
//  CustomDrinkController.swift
//  Drink Pantry
//
//  Created by Jared Wolthuis on 10/1/20.
//
import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift


class CustomDrinkController {
	
	
	// MARK: - Database Reference
	let db = Firestore.firestore()
	lazy var drinkRef = db.collection("users")
	//MARK: - Shared Instance
	static let sharedInstance = CustomDrinkController()
	//static  let drinkDocument = db.collection("users")
	
	//MARK: - Source of Truth
	
	var customDrinks: [CustomDrink] = []
	
	// MARK: - CRUD FUNCTIONS
	
	
	// MARK: - CREATE A DRINK
	func createCustomDrink(recipeTitle: String, recipeDescription: String, recipeIngredients: String, recipeInstructions: String, customDrinkPhoto: String, prepTime: String, difficulty: String) {
		let newCustomDrink = CustomDrink(recipeTitle: recipeTitle, recipeDescription: recipeDescription, recipeIngredients: recipeIngredients, recipeInstructions: recipeInstructions, customDrinkPhoto: customDrinkPhoto, prepTime: prepTime, difficulty: difficulty)
		
		guard let user = UserController.sharedInstance.currentUser else { return
		}
		
		
		drinkRef.document(user.userId).collection("custom drinks").document(newCustomDrink.customDrinkID).setData(
			["recipe title": newCustomDrink.recipeTitle as Any,
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
		drinkRef.document(user.userId).collection("custom drinks").addSnapshotListener { (querysnapshot, error) in
			
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
		
	}
	
	// MARK: - DELETE A DRINK
	
	func deleteUserCustomDrink(drink: CustomDrink) {
		guard let user = UserController.sharedInstance.currentUser else { return }
		db.collection("users").document(user.userId).collection("custom drinks").document(drink.customDrinkID).delete()
		guard let index = CustomDrinkController.sharedInstance.customDrinks.firstIndex(of: drink) else { return }
		customDrinks.remove(at: index)
		print("\(drink.recipeTitle) was successfully deleted from the database.")
		
	}
	
	// MARK: - UPDATE A DRINK
	
	
	func updateUserCustomDrink(drink: CustomDrink) {
		
		guard let user = UserController.sharedInstance.currentUser else { return }
		let drinkRef = db.collection("users").document(user.userId).collection("custom drinks").document(drink.customDrinkID)
		//        let drinkData = ["custom drink" : drink.customDrinkID, "recipe title" : drink.recipeTitle, "recipe description" : drink.recipeDescription, "recipeIngredients" : drink.recipeIngredients, "recipe instructions" : drink.recipeInstructions, "custom drink photo" : drink.customDrinkPhoto, "prep time" : drink.prepTime, "difficulty" : drink.difficulty, "custom drink ID" : drink.customDrinkID]
		
		do {
			try drinkRef.setData(from: drink, merge: true)
		} catch let error {
			print("Error writing drink update to Firestore: \(error)")
		}
		
	}
	
}
