//
//  FriendsViewController.swift
//  Mealette
//
//  Created by Bhavya Shah on 2020-01-06.
//  Copyright © 2020 Bhavya Shah. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {
    
    @IBOutlet var topnav: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        topnav.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
    }
    
    @objc func addFriend() {
        
    }
}
