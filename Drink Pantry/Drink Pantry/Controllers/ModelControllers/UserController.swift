//
//  UserController.swift
//  Drink Pantry
//
//  Created by Colton Swapp on 9/29/20.
//

import Foundation
import FirebaseFirestore
import Firebase

class UserController {
    
    // MARK: - SharedInstance
    static let sharedInstance = UserController()
    
    // MARK: - Current User
    var currentUser: User?
    
    func createUser(name: String, email: String, UUID: String, completion: @escaping(Bool) -> Void) {
        let newUser = User(name: name, email: email, userId: UUID)
        let db = Firestore.firestore()
        
        db.collection("users").document(newUser.userId).setData(["name": newUser.name, "email" : newUser.email, "userID": newUser.userId]) { (error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                completion(false)
            }
            
            self.currentUser = newUser
            completion(true)
        }
    }
    
    func retrieveProfile(userId: String, completion: @escaping (Result<User?, LoginError>) -> Void) {
        
        let db = Firestore.firestore()
        
        db.collection("users").document(userId).getDocument { (snapshot, error) in
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
