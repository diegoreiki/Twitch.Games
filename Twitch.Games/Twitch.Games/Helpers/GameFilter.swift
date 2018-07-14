import UIKit

class GameFilter: NSObject {
    
    static var shared = GameFilter()
    
    func returnGamesFound(listGames: Array<Games>, text: String) -> Array<Games> {
        let listGamesFound = listGames.filter { (games) -> Bool in
            if let name = games.game!.name?.lowercased(){
                return name.contains(text.lowercased())
            }
            return false
        }
        return listGamesFound
    }
}
