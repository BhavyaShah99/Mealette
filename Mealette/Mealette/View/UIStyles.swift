import UIKit
import Foundation

class UIStyles {
    
    static func txtFieldStyling(txtField : UITextField!) {
        let line = CALayer()
        line.frame = CGRect(x: 0, y: txtField.frame.height-2, width: txtField.frame.width, height: 2)
        line.backgroundColor = UIColor(red: 0.0471, green: 0.7569, blue: 0, alpha: 1.0).cgColor
        txtField.borderStyle = .none
        txtField.layer.addSublayer(line)
    }
    
    static func txtViewStyling(txtView : UITextView!) {
        txtView.layer.borderWidth = 2
        txtView.layer.borderColor = UIColor(red: 0.0471, green: 0.7569, blue: 0, alpha: 1.0).cgColor
    }
       
    static func styleBtn(btn : UIButton!, col : CGColor) {
        btn.layer.cornerRadius = 20
        btn.layer.borderWidth = 1/UIScreen.main.nativeScale
        btn.layer.borderColor = col
    }
    
    static func alertBox(title: String, msg: String, view: UIViewController, action: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: action, style: .cancel, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
    static func txtDelegateTag(txtField: UITextField, tag: Int, view: UITextFieldDelegate, retKeyType : UIReturnKeyType) {
        txtField.delegate = view
        txtField.tag = tag
        txtField.returnKeyType = retKeyType
    }
}
