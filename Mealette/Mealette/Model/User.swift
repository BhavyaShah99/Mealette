import Foundation
import UIKit

class User {
    
    var userId : String!
    var userName : String!
    var fullName : String!
    var email : String!
    var friends : [String]
    var profileImg : UIImage!
    
    init(uid: String, uname: String, fname: String, em: String, fri: [String], profImg: UIImage!) {
        self.userId = uid
        self.userName = uname
        self.fullName = fname
        self.email = em
        self.friends = fri
        self.profileImg = profImg
    }
}
