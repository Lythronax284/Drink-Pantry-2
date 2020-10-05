//
//  HomeScreenViewController.swift
//  Drink Pantry
//
//  Created by Colton Swapp on 9/30/20.
//

import UIKit
import Firebase

class HomeScreenViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var welcomeLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        welcomeLabel.text = ""
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let user = Auth.auth().currentUser {
            UserController.sharedInstance.retrieveProfile(userId: user.uid) { (result) in
                switch result {
                case .success(let user):
                    guard let user = user else { return }
                    self.welcomeLabel.text = "Welcome, \(user.name)"
                case .failure(let error):
                    print("Unable to log in. \(error)")
                }
            }
            
        } else {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let newController = SignUpViewController()
//            self.addChild(newController)
//            self.view.addSubview(newController.view)
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            guard let VC = storyboard.instantiateInitialViewController() else { return }
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Actions
    @IBAction func signOutButtonTapped(_ sender: Any) {
        try? Auth.auth().signOut()
        if let user = Auth.auth().currentUser {
            UserController.sharedInstance.retrieveProfile(userId: user.uid) { (result) in
                switch result {
                case .success(let user):
                    guard let user = user else { return }
                    self.welcomeLabel.text = "Welcome, \(user.name)"
                case .failure(let error):
                    print("Unable to log in. \(error)")
                }
            }
            
        } else {
            
            let storyboard = UIStoryboard(name: "Login", bundle: nil)
            guard let VC = storyboard.instantiateInitialViewController() else { return }
            VC.modalPresentationStyle = .fullScreen
            self.present(VC, animated: true, completion: nil)
            
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
