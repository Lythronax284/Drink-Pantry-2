//
//  TheHubViewController.swift
//  Drink Pantry
//
//  Created by Colton Swapp on 10/7/20.
//

import UIKit

class TheHubViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = UIApplication.shared.delegate as? UITabBarControllerDelegate
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
