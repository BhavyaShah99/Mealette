//
//  SingUpViewController.swift
//  Mealette
//
//  Created by Bhavya Shah on 2019-12-23.
//  Copyright © 2019 Bhavya Shah. All rights reserved.
//

import UIKit
import CoreGraphics
import FirebaseAuth
import Firebase
import FirebaseStorage

class SingUpViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet var username: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var fullname: UITextField!
    @IBOutlet var dietarypref: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var confpassword: UITextField!
    @IBOutlet var signupbtn: UIButton!
    @IBOutlet var profileImageView: UIImageView!
    let seebtn = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        self.hideKeyboardWhenTappedAround()
    }
    
    func setupView() {
        //Style the look of each textfield
        UIStyles.txtFieldStyling(txtField: username)
        UIStyles.txtFieldStyling(txtField: email)
        UIStyles.txtFieldStyling(txtField: fullname)
        UIStyles.txtFieldStyling(txtField: dietarypref)
        UIStyles.txtFieldStyling(txtField: password)
        UIStyles.txtFieldStyling(txtField: confpassword)
        UIStyles.styleBtn(btn: signupbtn, col: UIColor(red: 0.0471, green: 0.7569, blue: 0, alpha: 1.0).cgColor)
       //Set up what happens when each field is tapped on
        profileImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chooseProfileImage)))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.layer.cornerRadius = 52.5
        signupbtn.backgroundColor = UIColor(red: 0.0471, green: 0.7569, blue: 0, alpha: 1.0)
        self.seebtn.setTitle("See", for: .normal)
        username.rightView = seebtn
        username.clearButtonMode = .whileEditing
        email.clearButtonMode = .whileEditing
        fullname.clearButtonMode = .whileEditing
        dietarypref.clearButtonMode = .whileEditing
        password.clearButtonMode = .whileEditing
        confpassword.clearButtonMode = .whileEditing
        //Set up keyboards return key properties for each field
        UIStyles.txtDelegateTag(txtField: username, tag: 0, view: self, retKeyType: .next)
        UIStyles.txtDelegateTag(txtField: email, tag: 1, view: self, retKeyType: .next)
        UIStyles.txtDelegateTag(txtField: fullname, tag: 2, view: self, retKeyType: .next)
        UIStyles.txtDelegateTag(txtField: dietarypref, tag: 3, view: self, retKeyType: .next)
        UIStyles.txtDelegateTag(txtField: password, tag: 4, view: self, retKeyType: .next)
        UIStyles.txtDelegateTag(txtField: confpassword, tag: 5, view: self, retKeyType: .go)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nexttxtField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nexttxtField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            if textField.returnKeyType == .go {
                self.signUpPerform()
            }
            return true
        }
        return false
        
    }
    
    @objc func chooseProfileImage() {
        let newPhotosAction = UIAlertController(title: "Select Photo", message: nil, preferredStyle: .actionSheet)
        newPhotosAction.addAction(UIAlertAction(title: "Camera", style: .default, handler: { action in
            self.bringUpCamera()
        }))
        newPhotosAction.addAction(UIAlertAction(title: "Photos", style: .default, handler: { action in
            self.bringUpAlbum()
        }))
        newPhotosAction.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil ))
        self.present(newPhotosAction, animated: true, completion: nil)
    }
    
    func bringUpCamera() {
        let camera = UIImagePickerController()
        camera.delegate = self
        camera.sourceType = .camera
        camera.allowsEditing = true
        present(camera, animated: true, completion: nil)
    }
    
    func bringUpAlbum() {
        let camera = UIImagePickerController()
        camera.delegate = self
        camera.sourceType = .photoLibrary
        camera.allowsEditing = true
        present(camera, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        let pickedImg = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        profileImageView.image = pickedImg
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func validate() -> String? {
        if username.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            email.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            fullname.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            dietarypref.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            password.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" ||
            confpassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                return "Make sure all fields are filled"
        } else if passIsValid(password: password.text!.trimmingCharacters(in: .whitespacesAndNewlines)) == false{
            return "Password must have atleast 8 characters, one number and ons special character"
        } else if password.text?.trimmingCharacters(in: .whitespacesAndNewlines) !=
            confpassword.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            return "Passwords don't match"
        } else if dietarypref.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "Veg" &&
            dietarypref.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "Non-Veg" {
            return "Dietary restrictions must be either 'Veg'/'Non-Veg'"
        }
        return nil
    }
    
    func passIsValid(password : String) -> Bool {
        let pass = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return pass.evaluate(with: password)
    }
    
    @IBAction func signUp(_ sender: Any) {
        signUpPerform()
    }
    
    func signUpPerform() {
        let validated = validate()
        if validated != nil {
            UIStyles.alertBox(title: "Error", msg: validated!, view: self, action: "Ok")
        } else {
            let fname = fullname.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let uname = username.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let dpref = dietarypref.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let em = email.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let pass = password.text!.trimmingCharacters(in: .whitespacesAndNewlines)
             Auth.auth().createUser(withEmail: em , password: pass) { (result, err) in
                 if err != nil {
                    UIStyles.alertBox(title: "Error", msg: err!.localizedDescription, view: self, action: "Cancel")
                 } else {
                    let uid = result!.user.uid
                    // user created store name and other info
                    let storage = Storage.storage().reference().child(uid+"image.png")
                    if let uploadImg = self.profileImageView.image!.pngData() {
                        storage.putData(uploadImg, metadata: nil) { (metadata, err) in
                            if err != nil {
                                UIStyles.alertBox(title: "Error", msg: err!.localizedDescription, view: self, action: "Cancel")
                                return
                            }
                            storage.downloadURL { (url, err) in
                                if err != nil {
                                    //present error alert
                                    UIStyles.alertBox(title: "Error", msg: err!.localizedDescription, view: self, action: "Cancel")
                                }
                                guard let url = url?.absoluteString else {
                                    return
                                }
                                let data = ["fullname":fname,"username":uname,"dietarypref":dpref,"email":em,"profpic":url, "friends":[]] as [String : Any]
                                self.addUserData(userid: uid, dict: data as [String : AnyObject])
                            }
                        }
                    }
                 }
             }
        }
    }
    
    private func addUserData(userid : String!, dict : [String:AnyObject]) {
        let db = Firestore.firestore()
        db.collection("users").document(userid).setData(dict) { (err) in
             if err != nil {
                UIStyles.alertBox(title: "Error", msg: err!.localizedDescription, view: self, action: "Cancel")
             } else {
                // create a user object and send the data and user to home screen
                let home = self.storyboard?.instantiateViewController(identifier: "homeScreen") as? HomePageViewController
                self.view.window?.rootViewController = home
                self.view.window?.makeKeyAndVisible()
            }
        }
    }
}
