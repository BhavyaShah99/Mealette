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
