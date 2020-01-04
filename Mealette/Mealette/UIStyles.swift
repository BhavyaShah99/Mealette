//
//  UIStyles.swift
//  Mealette
//
//  Created by Bhavya Shah on 2019-12-31.
//  Copyright © 2019 Bhavya Shah. All rights reserved.
//

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
}
