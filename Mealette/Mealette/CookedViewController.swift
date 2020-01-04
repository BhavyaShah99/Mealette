//  CookedViewController.swift
//  Mealette
//  Created by Bhavya Shah on 2019-12-23.
//  Copyright © 2019 Bhavya Shah. All rights reserved.

import UIKit
import FirebaseAuth
import Firebase

class CookedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let currUser = Auth.auth().currentUser?.uid
    let cellId = "cell"
    let db = Firestore.firestore()
    var cookedData = [cooked]()
    @IBOutlet var cookedNavItem: UINavigationItem!
    @IBOutlet var foodsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        readCookedData(cUser: currUser)
    }
    
    func setupView() {
        cookedNavItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCooked))
        readCookedData()
    }
    
    func readCookedData() {
      let query = db.collection("cooked").whereField("uid", isEqualTo: currUser!)
      query.getDocuments { snapshot, error in
        if let snapshot = snapshot {
            for doc in snapshot.documents {
                let name = doc.data()["foodItem"]
                let ing = doc.data()["ingredients"] ?? ""
                let rec = doc.data()["recipe"] ?? ""
                let fav = doc.data()["favourite"] ?? false
                let food = cooked(item: (name as! String), ing: (ing as! String), rec: (rec as! String), f: (fav as! Bool))
                self.cookedData.append(food)
            }
            self.foodsTableView.reloadData()
        } else {
            return
        }
      }
    }
    
    @objc func addCooked() {
        let addCooked = storyboard?.instantiateViewController(withIdentifier: "addCooked") as! AddCookedViewController
        present(addCooked, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cookedData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        let food = cookedData[indexPath.row]
        cell.textLabel?.text = food.name
        var fav : String
        if food.fav == true {
            fav = "Yes"
        } else {
            fav = "No"
        }
        cell.detailTextLabel?.text = "Favourites : " + fav
        return cell
    }
}
