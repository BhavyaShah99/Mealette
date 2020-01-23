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
    var searchResult = [ordered]()
    var filterResult = [ordered]()
    var searchSelected = false
    var filterSelected = false
    @IBOutlet var orderedNavItem: UINavigationItem!
    @IBOutlet var ordTableView: UITableView!
    @IBOutlet var filterbtn: UIButton!
    let db = Firestore.firestore()
    var orderedData = [ordered(item: "Italian", f: false), ordered(item: "Indian", f: false), ordered(item: "Fast Food", f: false), ordered(item: "Thai", f: false), ordered(item: "Greek", f: false), ordered(item: "Japaneese", f: false), ordered(item: "French", f: false), ordered(item: "Chinese", f: false), ordered(item: "Burmese", f: false), ordered(item: "Mediterranean", f: false)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        orderedNavItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addOrdered))
        orderedNavItem.leftBarButtonItem = UIBarButtonItem(title: "Choose meal!", style: .done, target: self, action: #selector(randomize))
        readOrdData()
        self.hideKeyboardWhenTappedAround()
//        let i = [1,12,234,534,5]
//        let j = Array(i.sorted().reversed())
//        print(sqrt(2).rounded() as! Int)
//        var k = 0
//        for i in 0..<7 {
//            ++k
//        }
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
            let foodCusi = orderedData[indexPath.row]
            cell.textLabel?.text = foodCusi.name
            var fav : String
            if foodCusi.fav == true {
                fav = "Yes"
            } else {
                fav = "No"
            }
            cell.detailTextLabel?.text = "Favourites : " + fav
        }
        
        cell.backgroundColor = UIColor.systemBackground
        return cell
    }
    
    @IBAction func filterPressed(_ sender: UIButton) {
        if sender.isSelected {
            filterResult = mergeSort(arr: orderedData)
            filterSelected = true
            ordTableView.reloadData()
            sender.isSelected = false
        } else {
            ordTableView.reloadData()
            filterSelected = false
            sender.isSelected = true
        }
    }
}

extension OrderedViewController {
    
    // mergesort
    func mergeSort(arr : [ordered]) -> [ordered] {
        guard arr.count > 1 else {
            return arr
        }
        let lArr = Array(arr[0 ..< arr.count/2])
        let rArr = Array(arr[arr.count/2 ..< arr.count])
        
        return merge(lArr: mergeSort(arr: lArr), rArr: mergeSort(arr: rArr))
    }
    
    func merge(lArr : [ordered], rArr : [ordered]) -> [ordered] {
        var merged : [ordered] = []
        var l = lArr
        var r = rArr
        
        while l.count > 0 && r.count > 0 {
            if l.first!.name.lowercased() <  r.first!.name.lowercased() {
                merged.append(l.removeFirst())
            } else {
                merged.append(r.removeFirst())
            }
        }
        return merged + l + r
    }
    
//    quicksort
//    func partitionArr(low: Int, high: Int) -> Int {
//        let pivot = filterResult[low]
//        var i = low
//        var j = high
//        while i < j {
//            repeat {
//                i += 1
//                print(i)
//            } while filterResult[i].name < pivot.name
//            repeat {
//                j -= 1
//            } while filterResult[j].name > pivot.name
//            if i < j {
//                filterResult.swapAt(i, j)
//            }
//        }
//        filterResult.swapAt(low, j)
//        return j
//    }
//
//    func quickSort(low: Int, high: Int) {
//        if low < high {
//            let j = partitionArr(low: low, high: high)
//            quickSort(low: low, high: j)
//            quickSort(low: j+1, high: high)
//        }
//    }
}
