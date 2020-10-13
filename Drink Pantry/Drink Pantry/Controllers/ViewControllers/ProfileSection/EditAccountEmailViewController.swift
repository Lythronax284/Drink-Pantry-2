//
//  EditAccountEmailViewController.swift
//  Drink Pantry
//
//  Created by Colton Swapp on 10/8/20.
//

import UIKit

class EditAccountEmailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    
    
    // MARK: - Properties
    
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
        emailTextField.text = user?.email
    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        // Update the user's email address
        
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
