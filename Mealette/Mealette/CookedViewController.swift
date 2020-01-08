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
    let date = Date()
    let cal = Calendar.current
    var cookedData = [cooked]()
    var searchResult = [cooked]()
    var filterResult = [cooked]()
    var searchSelected = false
    var filterSelected = false
    @IBOutlet var cookedNavItem: UINavigationItem!
    @IBOutlet var foodsTableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var filterBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        readCookedData()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        readCookedData(cUser: currUser)
    }
    
    func setupView() {
        cookedNavItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCooked))
        cookedNavItem.leftBarButtonItem = UIBarButtonItem(title: "Choose meal!", style: .done, target: self, action: #selector(randomize))
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
                if self.cookedData.contains(food) {
                    return
                } else {
                    self.cookedData.append(food)
                }
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
    
    @objc func randomize() {
        if cookedData.count == 0 {
            return
        } else {
            let ranIndex = Int.random(in: 0..<self.cookedData.count)
            let randomized = cookedData[ranIndex]
            print(randomized.name!)
            let hour = self.cal.component(.hour, from: self.date)
            var meal : String!
            if hour >= 12 && hour <= 16 {
                meal = "Here's Your Lunch For Today"
            } else if hour > 16 && hour < 22 {
                meal = "Here's Your Dinner For Today"
            } else {
                meal = "You shouldn't be eating at this hour"
            }
            let randName = randomized.name!
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
            alert.addAction(UIAlertAction(title: "See Dish Details", style: .default, handler: nil))
            alert.addAction(UIAlertAction(title: "Choose Again", style: .default, handler: { (action) in
                self.randomize()
            }))
            alert.addAction(UIAlertAction(title: "Thank You!", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cookedData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellId)
        
        if filterSelected == true {
            let filteredFood = filterResult[indexPath.row]
            cell.textLabel?.text = filteredFood.name
            var filterFav : String
            if filteredFood.fav == true {
                filterFav = "Yes"
            } else {
                filterFav = "No"
            }
            cell.detailTextLabel?.text = "Favourites : " + filterFav
        } else {
            let food = cookedData[indexPath.row]
            cell.textLabel?.text = food.name
            var fav : String
            if food.fav == true {
                fav = "Yes"
            } else {
                fav = "No"
            }
            cell.detailTextLabel?.text = "Favourites : " + fav
        }
            
        cell.backgroundColor = UIColor.systemBackground
        return cell
    }
    
    @IBAction func filterPressed(_ sender: Any) {
        filterResult = mergeSort(arr: cookedData)
        filterSelected = true
        foodsTableView.reloadData()
    }
}

extension CookedViewController {
    func mergeSort(arr : [cooked]) -> [cooked] {
        guard arr.count > 1 else {
            return arr
        }
        let lArr = Array(arr[0 ..< arr.count/2])
        let rArr = Array(arr[arr.count/2 ..< arr.count])
        
        return merge(lArr: mergeSort(arr: lArr), rArr: mergeSort(arr: rArr))
    }
    
    func merge(lArr : [cooked], rArr : [cooked]) -> [cooked] {
        var merged : [cooked] = []
        var l = lArr
        var r = rArr
        
        while l.count > 0 && r.count > 0 {
            if l.first!.name <  r.first!.name {
                merged.append(l.removeFirst())
            } else {
                merged.append(r.removeFirst())
            }
        }
        
        return merged + l + r
    }
}
