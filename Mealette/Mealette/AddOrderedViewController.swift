//
//  AddOrderedViewController.swift
//  Mealette
//
//  Created by Bhavya Shah on 2019-12-31.
//  Copyright © 2019 Bhavya Shah. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class AddOrderedViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var foodCusiTxt: UITextField!
    @IBOutlet var addOrdered: UIButton!
    let df = Firestore.firestore()
    let currUser = Auth.auth().currentUser?.uid
    
    @IBOutlet var favSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
        setupView()
    }
    
    func setupView() {
        //Style the look of each component
        UIStyles.txtFieldStyling(txtField: foodCusiTxt)
        UIStyles.styleBtn(btn: addOrdered, col: UIColor(red: 0.0471, green: 0.7569, blue: 0, alpha: 1.0).cgColor)
        addOrdered.backgroundColor = UIColor(red: 0.0471, green: 0.7569, blue: 0, alpha: 1.0)
        //Style while editing properties of each component
        favSwitch.isOn = false
        //Set up keyboards return key properties for each field
        UIStyles.txtDelegateTag(txtField: foodCusiTxt, tag: 0, view: self, retKeyType: .done)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nexttxtField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nexttxtField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            return true
        }
        return false
    }
    
    @IBAction func addOrd(_ sender: Any) {
        if foodCusiTxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            UIStyles.alertBox(title: "Error", msg: "Fill in all fields", view: self, action: "Ok")
        } else {
            let newOrdItemDoc = df.collection("ordered").document()
            var fav : Bool
            if favSwitch.isOn {
                fav = true
            } else {
                fav = false
            }
            newOrdItemDoc.setData(["uid" : currUser!, "foodOrCusi" : foodCusiTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines), "fav" : fav]) { (err) in
                if err != nil {
                    UIStyles.alertBox(title: "Error", msg: "Unable to record food", view: self, action: "Cancel")
                } else {
                    UIStyles.alertBox(title: "Success", msg: "Added food/cuisine item", view: self, action: "Thank You!")
                    self.foodCusiTxt.text = ""
                    self.favSwitch.isOn = false
                }
            }
        }
    }
}
