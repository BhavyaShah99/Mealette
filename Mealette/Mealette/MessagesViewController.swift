//
//  MessagesViewController.swift
//  Mealette
//
//  Created by Bhavya Shah on 2020-01-06.
//  Copyright © 2020 Bhavya Shah. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController {

    @IBOutlet var topnav: UINavigationItem!
    @IBOutlet var filterbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        topnav.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(newMsg))
    }
    
    @objc func newMsg() {
        
    }
}
