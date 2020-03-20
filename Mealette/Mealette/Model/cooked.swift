import Foundation

class cooked: NSObject {
    
    var name: String!
    var ingredients: String!
    var recipe: String!
    var fav: Bool!
    
    init(item: String?, ing: String?, rec: String?, f: Bool?) {
        self.name = item
        self.ingredients = ing
        self.recipe = rec
        self.fav = f
    }
}
