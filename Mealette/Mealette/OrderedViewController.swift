//
//  OrderedViewController.swift
//  Mealette
//
//  Created by Bhavya Shah on 2019-12-23.
//  Copyright © 2019 Bhavya Shah. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class OrderedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let currUser = Auth.auth().currentUser?.uid
    let date = Date()
    let cal = Calendar.current
    @IBOutlet var orderedNavItem: UINavigationItem!
    @IBOutlet var ordTableView: UITableView!
    let db = Firestore.firestore()
    var orderedData = [ordered(item: "Italian", f: false), ordered(item: "Indian", f: false), ordered(item: "Fast Food", f: false), ordered(item: "Thai", f: false), ordered(item: "Greek", f: false), ordered(item: "Japaneese", f: false), ordered(item: "French", f: false), ordered(item: "Chinese", f: false), ordered(item: "Burmese", f: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        orderedNavItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addOrdered))
        orderedNavItem.leftBarButtonItem = UIBarButtonItem(title: "Randomize", style: .done, target: self, action: #selector(randomize))
        readOrdData()
    }
    
    func readOrdData() {
      let query = db.collection("ordered").whereField("uid", isEqualTo: currUser!)
      query.getDocuments { snapshot, error in
        if let snapshot = snapshot {
            for doc in snapshot.documents {
                let name = doc.data()["foodOrCusi"]
                let fav = doc.data()["favourite"] ?? false
                let foodCusi = ordered(item: (name as! String), f: (fav as! Bool))
                self.orderedData.append(foodCusi)
            }
            self.ordTableView.reloadData()
        } else {
            return
        }
      }
    }
    
    @objc func addOrdered() {
        let addOrd = storyboard?.instantiateViewController(withIdentifier: "addOrdered") as! AddOrderedViewController
        present(addOrd, animated: true, completion: nil)
    }
    
    @objc func randomize() {
        let ranIndex = Int.random(in: 0..<orderedData.count)
        let randomized = orderedData[ranIndex]
        print(randomized.name)
        let hour = self.cal.component(.hour, from: self.date)
        var meal : String!
        if hour >= 12 && hour <= 16 {
            meal = "Here's Your Lunch For Today"
        } else if hour > 16 && hour < 22 {
            meal = "Here's Your Dinner For Today"
        } else {
            meal = "You shouldn't be eating at this hour"
        }
        let randName = randomized.name
        var randFav : String!
        if randomized.fav == true {
            randFav = "Yes"
        } else {
            randFav = "No"
        }
        let msg = """
                    Dish Name : \(randName)
                    Favourite : \(randFav ?? "No")
                  """
        let alert = UIAlertController(title: meal, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Show me options nearby", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Choose Again", style: .default, handler: { (action) in
            self.randomize()
        }))
        alert.addAction(UIAlertAction(title: "Thank You!", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orderedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cellId")
        let foodCusi = orderedData[indexPath.row]
        cell.textLabel?.text = foodCusi.name
        var fav : String
        if foodCusi.fav == true {
            fav = "Yes"
        } else {
            fav = "No"
        }
        cell.detailTextLabel?.text = "Favourites : " + fav
        return cell
    }
}
