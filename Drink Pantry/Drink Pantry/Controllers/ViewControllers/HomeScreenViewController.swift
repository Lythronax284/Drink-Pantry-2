//
//  HomeScreenViewController.swift
//  Drink Pantry
//
//  Created by Colton Swapp on 9/30/20.
//

import UIKit
import Firebase
import FirebaseAuth

class HomeScreenViewController: UIViewController {
	
	// MARK: - Outlets
	@IBOutlet weak var welcomeLabel: UILabel!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let currentUser = Auth.auth().currentUser
		guard let currentUserID = Auth.auth().currentUser?.uid else { return }
		if currentUser != nil {
			UserController.sharedInstance.retrieveProfile(userId: currentUserID) { (result) in
				switch result {
					case .success(let user):
						guard let user = user  else { return }
							print("\(user.name)")
							self.welcomeLabel.text = "Welcom, \(user.name)"
					case .failure(let error):
						print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
				}
			}
		}
	}
	
	
	// MARK: - Actions
	func showAlert(message:String) {
		let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
		self.present(alert, animated: true)
	}
	
	@IBAction func signOutButtonTapped(_ sender: Any) {
		let firebaseAuth = Auth.auth()
		do {
			try firebaseAuth.signOut()
			self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
		} catch let signOutError as NSError {
			print ("Error signing out: %@", signOutError)
			self.showAlert(message: signOutError.localizedDescription)
		}
		
	}
	
	@IBAction func whatever(_ sender: Any) {
		
		CustomDrinkController.sharedInstance.createCustomDrink(recipeTitle: "Jared's drink", recipeDescription: "carbonated citrus beverage", recipeIngredients: "sunshine", recipeInstructions: "enjoy", customDrinkPhoto: "string", prepTime: "none", difficulty: "hard")
	}
	
}
