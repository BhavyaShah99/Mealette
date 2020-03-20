import UIKit
import FirebaseAuth
import Firebase

class AddCookedViewController: UIViewController, UITextFieldDelegate {
    
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
        //Style the look of all components
        UIStyles.txtFieldStyling(txtField: foodNametxt)
        UIStyles.txtFieldStyling(txtField: ingrdTxt)
        UIStyles.txtViewStyling(txtView: recptxtView)
        UIStyles.styleBtn(btn: addCookedbtn, col: UIColor(red: 0.0471, green: 0.7569, blue: 0, alpha: 1.0).cgColor)
        addCookedbtn.backgroundColor = UIColor(red: 0.0471, green: 0.7569, blue: 0, alpha: 1.0)
        //Style while editing properties of each component
        favSwitch.isOn = false
        //Set up keyboards return key properties for each field
        UIStyles.txtDelegateTag(txtField: foodNametxt, tag: 0, view: self, retKeyType: .next)
        UIStyles.txtDelegateTag(txtField: ingrdTxt, tag: 1, view: self, retKeyType: .done)
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
