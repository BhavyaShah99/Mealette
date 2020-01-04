//  SettingsViewController.swift
//  Created by Bhavya Shah on 2019-12-24.

import UIKit
import FirebaseAuth
import Firebase

class SettingsViewController: UIViewController {

    let currUser = Auth.auth().currentUser?.uid
    var username : String!
    var fullname : String!
    var dietpref : String!
    @IBOutlet var topNav: UINavigationBar!
    @IBOutlet var bottomNav: UITabBarItem!
    @IBOutlet var settingsTbl: UITableView!
    @IBOutlet var topnavItem: UINavigationItem!
    @IBOutlet var usernameTxt: UITextField!
    @IBOutlet var fullnameTxt: UITextField!
    @IBOutlet var dietTxt: UITextField!
    @IBOutlet var updatebtn: UIButton!
    @IBOutlet var emailtxt: UITextField!
    @IBOutlet var profImg: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        topnavItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signOut))
        guard let currUser = Auth.auth().currentUser?.uid else {return}
        print(currUser)
        print(getInfo(currUser: currUser))
        setUpView()
    }
    
    func setUpView() {
        UIStyles.styleBtn(btn: updatebtn, col: UIColor(red: 0.0471, green: 0.7569, blue: 0, alpha: 1.0).cgColor)
        updatebtn.backgroundColor = UIColor(red: 0.0471, green: 0.7569, blue: 0, alpha: 1.0)
        usernameTxt.borderStyle = .none
        fullnameTxt.borderStyle = .none
        dietTxt.borderStyle = .none
        emailtxt.borderStyle = .none
        usernameTxt.isUserInteractionEnabled = false
        fullnameTxt.isUserInteractionEnabled = false
        dietTxt.isUserInteractionEnabled = false
        emailtxt.isUserInteractionEnabled = false
        profImg.layer.cornerRadius = 52.5
    }
    
    @objc fileprivate func signOut() {
        let signoutsheet = UIAlertController(title: "Confirm", message: "Are you sure you want to sign Out", preferredStyle: .actionSheet)
        signoutsheet.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            do {
                try Auth.auth().signOut()
                let main = self.storyboard?.instantiateViewController(identifier: "main") as? ViewController
                self.view.window?.rootViewController = main
                self.view.window?.makeKeyAndVisible()
            } catch let error {
                UIStyles.alertBox(title: "Error", msg: error.localizedDescription, view: self, action: "Cancel")
            }
        }))
        signoutsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(signoutsheet, animated: true, completion: nil)
    }
    
    func getInfo(currUser: String!) {
        let db = Firestore.firestore()
        db.collection("users").document(currUser).getDocument { (document, err) in
            if err == nil {
                if document != nil && document!.exists {
                    let userInfo = document!.data()
                    self.topnavItem.title = "Profile"
                    print(userInfo!)
                    self.usernameTxt.text = (userInfo!["username"] as! String)
                    self.fullnameTxt.text = (userInfo!["fullname"] as! String)
                    self.dietTxt.text = (userInfo!["dietarypref"] as! String)
                    self.emailtxt.text = (userInfo!["email"] as! String)
                }
            } else {
                UIStyles.alertBox(title: "Error", msg: "User data not found", view: self, action: "Cancel")
            }
        }
    }
}
