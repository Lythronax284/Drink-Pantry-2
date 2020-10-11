//
//  UserController.swift
//  Drink Pantry
//
//  Created by Colton Swapp on 9/29/20.
//

import Foundation
import Firebase
import FirebaseFirestore

class UserController {
    
    // MARK: - SharedInstance
    static let sharedInstance = UserController()
    
    // MARK: - Current User
    var currentUser: User?
	private static let db = Firestore.firestore()
    
	func createUser(name: String, email: String, completion: @escaping(Result<Bool, LoginError>) -> Void) {
        let newUser = User(name: name, email: email)
        //["name": newUser.name, "email" : newUser.email, "userID": newUser.userId]
		UserController.db.collection("users").document(newUser.userId).se { (error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
				completion(.failure(.thrownError(error)))
            }
            
            self.currentUser = newUser
			print("Successfully created User. \(newUser)")
			completion(.success(true))
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
