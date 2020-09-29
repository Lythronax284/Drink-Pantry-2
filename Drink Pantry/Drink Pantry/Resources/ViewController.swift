//
//  ViewController.swift
//  Drink Pantry
//
//  Created by Jared Wolthuis on 9/28/20.
//

import UIKit
import FirebaseFirestore
import Firebase
import FirebaseFirestoreSwift

class ViewController: UIViewController {
    let db = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        writeTest()
        
        // Do any additional setup after loading the view.
    }

    func writeTest() {
        
        db.collection("test").addDocument(data: ["test" : "document"])
        
       // db.collection("test").addDocument(data: ["test" : Any])
    }
    
}

