//
//  UserController.swift
//  Drink Pantry
//
//  Created by Colton Swapp on 9/29/20.
//

import Foundation
import Firebase
import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift

class UserController {
	
	// MARK: - SharedInstance
	static let sharedInstance = UserController()
	
	// MARK: - Current User
	var currentUser: User?
	private static let db = Firestore.firestore()
	private static let currentID = Auth.auth().currentUser?.uid
	
	//	func createUser(name: String, email: String, completion: @escaping(Result<Bool, LoginError>) -> Void) {
	//
	//["name": newUser.name, "email" : newUser.email, "userID": newUser.userId]
	func createUser(name: String, email: String, password: String, completion: @escaping(Result<User, LoginError>) -> Void) {
		let newUser = User(name: name, email: email)
		Auth.auth().createUser(withEmail: email, password: password) { users, error in
			print(users?.user ?? "Could not find Authed User")
			if let error = error {
			print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
			}
			if error == nil {
				Auth.auth().signIn(withEmail: email, password: password)
				print("First Authentication Successful")
				print("\(UserController.currentID ?? "no uuid found")")
				
				do {
					guard let userID = UserController.currentID else {return completion(.failure(.noData))}
					try UserController.db.collection("users").document(userID).setData(from: newUser) { (error) in
						if let error = error {
							print("Save Data Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
							completion(.failure(.thrownError(error)))
						} else {
							self.currentUser = newUser
							print("Successfully created User. \(newUser)")
							completion(.success(newUser))
						}
					}
				} catch {
					print("The Do Try Failed horribly and has an Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
				}
			}
			
		}
		
	}
	
	func retrieveProfile(userId: String, completion: @escaping (Result<User?, LoginError>) -> Void) {
		
		
		UserController.db.collection("users").document(userId).getDocument { (snapshot, error) in
			if let error = error {
				return completion(.failure(LoginError.thrownError(error)))
			}
			
			if let profile = snapshot?.data() {
				// Profile was found, create new user
				let userId = snapshot?.documentID ?? ""
				let email = profile["email"] as? String ?? ""
				let name = profile["name"] as? String ?? ""
				
				let user = User(name: name, email: email, userId: userId)
				self.currentUser = user
				completion(.success(user))
			}
			
			else {
				return completion(.failure(LoginError.unableToDecode))
			}
		}
	}
}
