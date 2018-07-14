import UIKit

class FilterGame: NSObject {
    
    static var shared = FilterGame()
    
    func returnGamesFound(listGames: Array<Games>, text: String) -> Array<Games> {
        let listGamesFound = listGames.filter { (games) -> Bool in
            if let name = games.game!.name{
                return name.contains(text)
            }
            return false
        }
        return listGamesFound
    }
}
