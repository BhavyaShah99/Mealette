import UIKit
import Firebase
import FirebaseAuth

class LogInViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var emailtxt: UITextField!
    @IBOutlet var passtxt: UITextField!
    @IBOutlet var signin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        self.hideKeyboardWhenTappedAround()
    }
    
    func setupView() {
        //Style the looks of all components
        UIStyles.txtFieldStyling(txtField: emailtxt)
        UIStyles.txtFieldStyling(txtField: passtxt)
        UIStyles.styleBtn(btn: signin, col: UIColor(red: 0.0471, green: 0.7569, blue: 0, alpha: 1.0).cgColor)
        signin.backgroundColor = UIColor(red: 0.0471, green: 0.7569, blue: 0, alpha: 1.0)
        //Style compoments while editing
        emailtxt.clearButtonMode = .whileEditing
        passtxt.clearButtonMode = .whileEditing
        //Style keyboard properties for when each component is selected
        UIStyles.txtDelegateTag(txtField: emailtxt, tag: 0, view: self, retKeyType: .next)
        UIStyles.txtDelegateTag(txtField: passtxt, tag: 1, view: self, retKeyType: .go)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nexttxtField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nexttxtField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
            if textField.returnKeyType == .go {
                self.loginPerform()
            }
            return true
        }
        return false
    }
    

    @IBAction func logIn(_ sender: Any) {
       loginPerform()
    }
    
    func loginPerform() {
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
