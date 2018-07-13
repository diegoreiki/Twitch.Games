import UIKit
import CoreData

class DetailsViewController: UIViewController, NSFetchedResultsControllerDelegate {
    
    //MARK: Property   
    var context:NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        return appDelegate.persistentContainer.viewContext;
    }
    var manageResults: NSFetchedResultsController<Favorites>?;
    var games: Games?;
    let buttonFavorite = UIButton(type: .custom)
    
    //MARK: IBOutlet
    @IBOutlet weak var imageGame: UIImageView!;
    @IBOutlet weak var labelName: UILabel!;
    @IBOutlet weak var labelViewers: UILabel!;
    
    //MARK: Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getFavorites()
        setupDetailsGame()
    }
    
    func checkFavoriteGame(status: Bool){
        
        if status{
            buttonFavorite.setImage(UIImage (named: "FavoriteOn"), for: .normal)
            buttonFavorite.isEnabled = false
        } else {
            buttonFavorite.setImage(UIImage (named: "FavoriteOff"), for: .normal)
            buttonFavorite.addTarget(self, action: #selector(addFavorite), for: .touchUpInside)
        }
        
        buttonFavorite.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        let barButtonFavorite = UIBarButtonItem(customView: buttonFavorite)
        
        self.navigationItem.rightBarButtonItems = [barButtonFavorite];
    }
    
    //MARK: Methods CoreData
    @objc func addFavorite() {
        let favorite = Favorites(context: context);
        
        guard let game = games?.game else {
            return;
        }
        favorite.id = Int32(game.id!);
        favorite.name = game.name
        favorite.image = game.image!.medium;
        
        do{
            try context.save();
        } catch{
            print(error.localizedDescription);
        }
        buttonFavorite.setImage(UIImage (named: "FavoriteOn"), for: .normal)
    }
    
    func getFavorites(){
        manageResults?.delegate = self
        
        let searchFavorites: NSFetchRequest<Favorites> = Favorites.fetchRequest()
        let sortFavorites = NSSortDescriptor(key: "id", ascending: true)
        searchFavorites.sortDescriptors = [sortFavorites]
        manageResults = NSFetchedResultsController(fetchRequest: searchFavorites, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        do{
            try manageResults?.performFetch()
            
            guard let myFavorites = manageResults?.fetchedObjects else { return }
            
            if myFavorites.count == 0{
                checkFavoriteGame(status: false)
                return
            }
            
            for favorite in myFavorites{
                if favorite.id == games?.game?.id! as! Int{
                    checkFavoriteGame(status: true)
                    return
                } else {
                    checkFavoriteGame(status: false)
                }
            }
        } catch{
            print(error.localizedDescription);
        }
    }
    
    //MARK: Methods
    func setupDetailsGame(){
        if let details = games{
            let detailGame = details.game!;
            
            self.navigationItem.title = detailGame.name;
            let imageUrl = URL(string: (detailGame.image?.large)!);
            let imageData = NSData(contentsOf: imageUrl!);
            imageGame.image = UIImage(data: imageData! as Data);
            labelName.text = detailGame.name;
            
            guard let viewers = details.viewers else{
                return;
            }            
            labelViewers.text = "Visualizações: \(viewers)";
        }        
    }
}
