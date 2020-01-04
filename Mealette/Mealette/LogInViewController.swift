//
//  LogInViewController.swift
//  Mealette
//
//  Created by Bhavya Shah on 2019-12-23.
//  Copyright © 2019 Bhavya Shah. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController {

    @IBOutlet var emailtxt: UITextField!
    @IBOutlet var passtxt: UITextField!
    @IBOutlet var signin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        UIStyles.txtFieldStyling(txtField: emailtxt)
        UIStyles.txtFieldStyling(txtField: passtxt)
        UIStyles.styleBtn(btn: signin, col: UIColor(red: 0.0471, green: 0.7569, blue: 0, alpha: 1.0).cgColor)
        signin.backgroundColor = UIColor(red: 0.0471, green: 0.7569, blue: 0, alpha: 1.0)
    }
    

    @IBAction func logIn(_ sender: Any) {
        if  emailtxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            passtxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            UIStyles.alertBox(title: "Error", msg: "Fill in all fields", view: self, action: "Ok")
        } else {
            let em = emailtxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pass = passtxt.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().signIn(withEmail: em, password: pass) { (result, err) in
                if err != nil {
                    UIStyles.alertBox(title: "Error", msg: err!.localizedDescription, view: self, action: "Cancel")
                } else {
                    //log in
                    let home = self.storyboard?.instantiateViewController(identifier: "homeScreen") as? HomePageViewController
                    self.view.window?.rootViewController = home
                    self.view.window?.makeKeyAndVisible()
                }
            }
        }
    }
}
