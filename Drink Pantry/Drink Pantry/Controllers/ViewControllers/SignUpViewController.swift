//
//  SignUpViewController.swift
//  Drink Pantry
//
//  Created by Colton Swapp on 10/1/20.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
//        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        nameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        confirmPasswordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Actions
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let emailText = emailTextField.text
        let nameText = nameTextField.text
        let passwordText = passwordTextField.text
        let confirmPasswordText = confirmPasswordTextField.text
        if ((nameText?.isEmpty)! || (emailText?.isEmpty)! || (passwordText?.isEmpty)! || (confirmPasswordText?.isEmpty)!) {
            // Present alert "All fields required"
            print("Missing field")
        } else if passwordTextField.text != confirmPasswordTextField.text {
            // Present alert "Passwords don't match"
            print("Passwords do not match")
        } else {
            guard let nameText = nameTextField.text, !nameText.isEmpty, let emailText = emailTextField.text, !emailText.isEmpty, let passwordText = passwordTextField.text, !passwordText.isEmpty else { return }
           
			UserController.sharedInstance.createUser(name: <#T##String#>, email: <#T##String#>, UUID: <#T##String#>, completion: <#T##(Result<Bool, LoginError>) -> Void#>) { (user, error) in
                if let error = error {
                    print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
            }
           
                if let user = user?.user {
                    UserController.sharedInstance.createUser(name: nameText, email: emailText, UUID: user.uid) { success in
						self.performSegue(withIdentifier: "theHub", sender: nil)
                        self.dismiss(animated: true)
                    }
                }
            }
        }
        
        
    }
    
    
    // MARK: - HelperMethods
    // Keyboard Adjust Frame
    @objc func adjustForKeyboard(notification: Notification) {
      guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
      
      let keyboardScreenEndFrame = keyboardValue.cgRectValue
      let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
      
      if notification.name == UIResponder.keyboardWillHideNotification {
        scrollView.contentInset = .zero
      } else {
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom, right: 0)
      }
      scrollView.scrollIndicatorInsets = scrollView.contentInset
    }


}

extension SignUpViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if nameTextField.isFirstResponder {
            return nameTextField.resignFirstResponder()
        } else if emailTextField.isFirstResponder {
            return emailTextField.resignFirstResponder()
        } else if passwordTextField.isFirstResponder {
            return passwordTextField.resignFirstResponder()
        } else {
            return confirmPasswordTextField.resignFirstResponder()
        }
    }
}
