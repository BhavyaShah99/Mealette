//
//  FriendsViewController.swift
//  Mealette
//
//  Created by Bhavya Shah on 2020-01-06.
//  Copyright © 2020 Bhavya Shah. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {
    
    @IBOutlet var topNav: UINavigationItem!
    @IBOutlet var existingFriendsTbl: UITableView!
    @IBOutlet var filtertbn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    func setupView() {
        topNav.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
    }
    
    @objc func addFriend() {
        showNewFriendsView()
    }
    
    func showNewFriendsView() {
        UIView.animate(withDuration: 0.5) {
            
        }
    }
}
