//
//  LoginViewController.swift
//  Drink Pantry
//
//  Created by Colton Swapp on 9/30/20.
//

import UIKit
import FirebaseUI
import Firebase
import FirebaseAuth


class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        emailTextField.delegate = self
        passwordTextField.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if UserController.sharedInstance.currentUser != nil {
            performSegue(withIdentifier: "toHomeScreenVC", sender: nil)
        }
    }
    
    // MARK: - Actions
    @IBAction func signInButtonTapped(_ sender: Any) {
        guard let emailText = emailTextField.text, !emailText.isEmpty,
              let passwordText = passwordTextField.text, !passwordText.isEmpty else { return }
        
        Auth.auth().signIn(withEmail: emailText, password: passwordText) { (user, error) in
            if let error = error {
                print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                // Present some sort of could not log in alert
            }
            if let user = user?.user {
                UserController.sharedInstance.retrieveProfile(userId: user.uid) { (result) in
                    switch result {
                    case .success(let user):
                        print("\(user?.name) was successfully signed in.")
                        self.dismiss(animated: true, completion: nil)
                    case .failure(let error):
                        print("Error in \(#function) : \(error.localizedDescription) \n---\n \(error)")
                    }
                }
            }
        }
    }
    
    @IBAction func signUpButtonTapped(_ sender: Any) {
        let signUpStoryboard = UIStoryboard(name: "SignUp", bundle: nil)
        guard let signUpViewController = signUpStoryboard.instantiateInitialViewController() else { return }
        self.navigationController?.pushViewController(signUpViewController, animated: true)
        
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
        scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom + 40, right: 0)
      }
      scrollView.scrollIndicatorInsets = scrollView.contentInset
    }
    
    func enableSignInButton() {
        guard let emailText = emailTextField.text, let passwordText = passwordTextField.text else { return }
        if !emailText.isEmpty && !passwordText.isEmpty {
            self.signInButton.setTitleColor(.red, for: .normal)
            self.signInButton.isEnabled = true
        } else {
            self.signInButton.isEnabled = false
            self.signInButton.setTitleColor(.gray, for: .normal)
        }
    }
    
    // MARK: - Navigation
   
    

}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailTextField.isFirstResponder {
            return emailTextField.resignFirstResponder()
        } else {
            return passwordTextField.resignFirstResponder()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        enableSignInButton()
    }
}
