//
//  ProfileLandingViewController.swift
//  Drink Pantry
//
//  Created by Colton Swapp on 10/8/20.
//

import UIKit

class ProfileLandingViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var myCreationsButton: UIButton!
    @IBOutlet weak var myAccountButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    // MARK: - Properties
    var user = UserController.sharedInstance.currentUser

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - Actions
    
    @IBAction func myCreationsButtonTapped(_ sender: Any) {
    }
    
    @IBAction func myAccountButtonTapped(_ sender: Any) {
    }
    
    @IBAction func logoutButtonTapped(_ sender: Any) {
        
        // UserController.sharedInstance.logoutUser?
        
    }
    
    
    
    // MARK: - Helper Methods
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMyAccountVC" {
            guard let destinationVC = segue.destination as? MyAccountTableViewController else { return }
            let userToSend = user
            destinationVC.user = userToSend
        }
    }
    

}
