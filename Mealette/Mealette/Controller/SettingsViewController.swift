import UIKit
import FirebaseAuth
import Firebase

class SettingsViewController: UIViewController {
    
    let currUser = Auth.auth().currentUser?.uid
    var username : String!
    var fullname : String!
    var dietpref : String!
    let db = Firestore.firestore()
    
    @IBOutlet var topNav: UINavigationBar!
    @IBOutlet var bottomNav: UITabBarItem!
    @IBOutlet var topnavItem: UINavigationItem!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var dietLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard let currUser = Auth.auth().currentUser?.uid else {return}
        
        // set up view items
        topnavItem.rightBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .done, target: self, action: #selector(signOut))
        self.hideKeyboardWhenTappedAround()
        
        readUserData()
    }
    
    func readUserData() {
        let query = db.collection("users").document(currUser!)
        query.getDocument { snapshot, error in
          if let snapshot = snapshot {
            let data = snapshot.data()!
            let name = data["fullname"]
            let diet = data["dietarypref"]
            let email = data["email"]
            let username = data["username"]
            self.topnavItem.title = name as? String
            var temp = "Username: "
            var temp2 = "Email: "
            var temp3 = "Diet: "
            temp += username as! String
            temp2 += email as! String
            temp3 += diet as! String
            self.usernameLabel.text = temp
            self.dietLabel.text = temp3
            self.emailLabel.text = temp2
          } else {
              return
          }
        }
        print(query)
    }
    
    @objc fileprivate func signOut() {
        let signoutsheet = UIAlertController(title: "Confirm", message: "Are you sure you want to Sign Out", preferredStyle: .actionSheet)
        signoutsheet.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (action) in
            do {
                try Auth.auth().signOut()
                let main = self.storyboard?.instantiateViewController(identifier: "main") as? ViewController
                self.view.window?.rootViewController = main
                self.view.window?.makeKeyAndVisible()
            } catch let error {
                UIStyles.alertBox(title: "Error", msg: error.localizedDescription, view: self, action: "Cancel")
            }
        }))
        signoutsheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(signoutsheet, animated: true, completion: nil)
    }
    
    @IBAction func updatePressed(_ sender: Any) {
        let update = self.storyboard?.instantiateViewController(identifier: "update") as? UpdateProfileViewController
        self.view.window?.rootViewController = update
        self.view.window?.makeKeyAndVisible()
    }
    
}
