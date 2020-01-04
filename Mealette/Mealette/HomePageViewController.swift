//
//  HomePageViewController.swift
//  Mealette
//
//  Created by Bhavya Shah on 2019-12-23.
//  Copyright © 2019 Bhavya Shah. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class HomePageViewController: UITabBarController {
    
    let currUser = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
