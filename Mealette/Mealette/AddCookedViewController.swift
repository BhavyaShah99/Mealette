//
//  AddCookedViewController.swift
//  Mealette
//
//  Created by Bhavya Shah on 2019-12-31.
//  Copyright © 2019 Bhavya Shah. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class AddCookedViewController: UIViewController {
    
    let currUser = Auth.auth().currentUser?.uid
    let df = Firestore.firestore()
    @IBOutlet var foodNametxt: UITextField!
    @IBOutlet var addCookedbtn: UIButton!
    @IBOutlet var ingrdTxt: UITextField!
    @IBOutlet var recptxtView: UITextView!
    @IBOutlet var favSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        self.hideKeyboardWhenTappedAround()
    }
    
    func setupView() {
        UIStyles.txtFieldStyling(txtField: foodNametxt)
        UIStyles.txtFieldStyling(txtField: ingrdTxt)
        UIStyles.txtViewStyling(txtView: recptxtView)
        UIStyles.styleBtn(btn: addCookedbtn, col: UIColor(red: 0.0471, green: 0.7569, blue: 0, alpha: 1.0).cgColor)
        addCookedbtn.backgroundColor = UIColor(red: 0.0471, green: 0.7569, blue: 0, alpha: 1.0)
        favSwitch.isOn = false
    }
    
    @IBAction func addCookedItem(_ sender: UIButton) {
        if foodNametxt.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            UIStyles.alertBox(title: "Error", msg: "Need to enter food name atleast", view: self, action: "Ok")
        } else {
            let newCookedItemDoc = df.collection("cooked").document()
            var fav : Bool
            if favSwitch.isOn {
                fav = true
            } else {
                fav = false
            }
            newCookedItemDoc.setData(["uid" : currUser!, "foodItem" : foodNametxt.text!.trimmingCharacters(in: .whitespacesAndNewlines), "ingredients" : ingrdTxt.text!.trimmingCharacters(in: .whitespacesAndNewlines), "recipe" : recptxtView.text!.trimmingCharacters(in: .whitespacesAndNewlines), "favourite" : fav]) { (err) in
                if err != nil {
                    UIStyles.alertBox(title: "Error", msg: "Unable to record food", view: self, action: "Cancel")
                } else {
                    UIStyles.alertBox(title: "Success", msg: "Added food item", view: self, action: "Thank You!")
                    self.foodNametxt.text = ""
                    self.ingrdTxt.text = ""
                    self.recptxtView.text = "Click to add Recipe"
                    self.favSwitch.isOn = false
                }
            }
        }
    }
}
