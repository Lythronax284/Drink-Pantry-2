//
//  LoginViewController.swift
//  Drink Pantry
//
//  Created by Colton Swapp on 9/30/20.
//

import UIKit
import FirebaseUI
import Firebase
import GoogleSignIn

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func getStartedButtonTapped(_ sender: Any) {
        presentEmailGoogleSignIn()
    }
    
    
    // MARK: - HelperMethods
    
    func presentEmailGoogleSignIn() {
        let authUI = FUIAuth.defaultAuthUI()
        
        
        if let authUI = authUI {
            
//             Set self as the delegate of AuthUI
            authUI.delegate = self
            
            
            authUI.providers = [FUIEmailAuth(), FUIGoogleAuth()]
            
            
            let authViewController = authUI.authViewController()
            
            
            present(authViewController, animated: true, completion: nil)
        }
    }
}

extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        if let error = error {
            print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
        }
        
        let user = authDataResult?.user
        
        if let user = user {
            
            
            UserController.sharedInstance.retrieveProfile(userId: user.uid) { (foundUser) in
                if let foundUser = foundUser {
                    // go home page
                    self.dismiss(animated: true, completion: nil)
                }
                else {
                    guard let username = user.displayName, let email = user.email else { return }
                    UserController.sharedInstance.createUser(name: username, email: email, UUID: user.uid)
                    self.dismiss(animated: true, completion: nil)
                    
                }
            }
            
        }
    }
}
