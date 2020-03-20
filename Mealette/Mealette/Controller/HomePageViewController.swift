import UIKit
import FirebaseAuth
import Firebase

class HomePageViewController: UITabBarController {
    
    let currUser = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.hideKeyboardWhenTappedAround()
    }
}
