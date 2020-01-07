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
    @IBOutlet var newFriendsTbl: UITableView!
    @IBOutlet var existingFriendsTbl: UITableView!
    @IBOutlet var newFriendsView: UIView!
    @IBOutlet var searchExisting: UISearchBar!
    @IBOutlet var searchNew: UISearchBar!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        topNav.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addFriend))
    }
    
    func setupView() {
        newFriendsView.layer.cornerRadius = 7
    }
    
    @objc func addFriend() {
        showNewFriendsView()
    }
    
    func showNewFriendsView() {
        self.view.addSubview(newFriendsView)
        newFriendsView.center = self.view.center
        
        newFriendsView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        newFriendsView.alpha = 0
        
        UIView.animate(withDuration: 0.5) {
            self.newFriendsView.alpha = 1
            self.newFriendsView.transform = CGAffineTransform.identity
        }
    }
}
