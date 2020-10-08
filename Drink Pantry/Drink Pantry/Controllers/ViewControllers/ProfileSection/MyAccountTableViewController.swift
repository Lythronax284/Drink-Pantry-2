//
//  MyAccountTableViewController.swift
//  Drink Pantry
//
//  Created by Colton Swapp on 10/8/20.
//

import UIKit

class MyAccountTableViewController: UITableViewController {
    
    // MARK: - Outlet
    @IBOutlet weak var userEmailLabel: UITableViewCell!
    
    // MARK: - Properties
    var user: User? {
        didSet {
            guard let user = user else { return }
            setupViews()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    // MARK: - HelperMethods
    
    func setupViews() {
        userEmailLabel.textLabel?.text = user?.email
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toEditAccountEmailVC" {
            guard let destinationVC = segue.destination as? EditAccountEmailViewController else { return }
            let userToSend = user
            destinationVC.user = userToSend
        }
        
        else if segue.identifier == "toEditAccountPasswordVC" {
            guard let destinationVC = segue.destination as? EditAccountPasswordViewController else { return }
            let userToSend = user
            destinationVC.user = userToSend
        }
    }
    

}
