import UIKit
import CoreData

class FavoritesDAO: NSObject, NSFetchedResultsControllerDelegate {
    
    static var shared = FavoritesDAO()
    
    //MARK: Property
    var context:NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    var manageResults: NSFetchedResultsController<Favorites>?
    
    //MARK: Methods
    func getFavorites() -> [Favorites]{
        manageResults?.delegate = self
        
        let searchFavorites: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        let sortFavorites = NSSortDescriptor(key: "name", ascending: true)
        searchFavorites.sortDescriptors = [sortFavorites]
        manageResults = NSFetchedResultsController(fetchRequest: searchFavorites, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do{
            try manageResults?.performFetch()
        } catch{
            print(error.localizedDescription)
        }
        
        guard let listFavorites = manageResults?.fetchedObjects else { return [] }
        return listFavorites
    }
    
    func addFavorite(game: Game){
        let favorite = Favorites(context: context)
        
        favorite.id = Int32(game.id!)
        favorite.name = game.name
        favorite.image = game.image?.medium
        
        updateContext()
    }
    
    func removeFavorite(game: Game) {
        
        guard let favorites = manageResults?.fetchedObjects! else { return }
        for favorite in favorites{
            if Int(favorite.id) == game.id!{
                context.delete(favorite)
            }
        }
        updateContext()
    }
    
    func updateContext(){
        do{
            try context.save()
        } catch{
            print(error.localizedDescription)
        }
    }
}
