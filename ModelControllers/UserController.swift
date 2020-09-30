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
    
    func createUser(name: String, email: String, UUID: String) {
        let newUser = User(name: name, email: email, userId: UUID)
        let db = Firestore.firestore()
        
        db.collection("users").document(newUser.userId).setData(["name": newUser.name, "email" : newUser.email, "userID": newUser.userId])
        
        self.currentUser = newUser
    }
    
    func retrieveProfile(userId: String, completion: @escaping (User?) -> Void) {
        
        let db = Firestore.firestore()
        
        db.collection("users").document(userId).getDocument { (snapshot, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
            
            if let profile = snapshot?.data() {
                // Profile was found, create new user
                let userId = snapshot?.documentID as! String
                let email = profile["email"] as? String ?? ""
                let name = profile["name"] as? String ?? ""
                
                let user = User(name: name, email: email, userId: userId)
                self.currentUser = user
                completion(user)
            }
            
            else {
                completion(nil)
            }
        }
    }
}
