//
//  UpdateProfileViewController.swift
//  Mealette
//
//  Created by Bhavya Shah on 2020-01-05.
//  Copyright © 2020 Bhavya Shah. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class UpdateProfileViewController: UIViewController {

    let currUser = Auth.auth().currentUser?.uid
    let db = Firestore.firestore()
    
    @IBOutlet var newUsername : UITextField!
    @IBOutlet var newEmail : UITextField!
    @IBOutlet var newFullname : UITextField!
    @IBOutlet var newDietpref : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    func update() {
        let query = db.collection("users").whereField("uid", isEqualTo: currUser!)
        if newUsername.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            // leave username the same
        } else {
            query.setValue(newUsername.text!.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "username")
        }
        if newFullname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            // leave fulname the same
        } else {
            query.setValue(newFullname.text!.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "fullname")
        }
        if newEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            // leave email the same
        } else {
            query.setValue(newEmail.text!.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "email")
        }
        if newDietpref.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            //leave dietpref the same
        } else {
            query.setValue(newDietpref.text!.trimmingCharacters(in: .whitespacesAndNewlines), forKey: "dietarypref")
        }
    }

}
