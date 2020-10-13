//
//  EditAccountPasswordViewController.swift
//  Drink Pantry
//
//  Created by Colton Swapp on 10/8/20.
//

import UIKit

class EditAccountPasswordViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var currentPasswordTextfield: UITextField!
    @IBOutlet weak var newPassswordTextfield: UITextField!
    @IBOutlet weak var confirmNewPasswordTextfield: UITextField!
    
    // MARK: - Propertires
    
    var user: User? {
        didSet {
//            guard let user = user else { return }
            setupViews()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - Helper Methods
    func setupViews() {
        
    }
    
    // MARK: - Actions
    @IBAction func savebuttonTapped(_ sender: Any) {
        // UserController.sharedInstance.updatePassword ??
        // In the closure, pop the view controller
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
