import UIKit
import CoreData

class FavoriteViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {
    
    //MARK: Property
    var context:NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        return appDelegate.persistentContainer.viewContext;
    }      
    var manageResults: NSFetchedResultsController<Favorites>?;
    
    //MARK: IBOutlet
    @IBOutlet weak var collectionFavorite: UICollectionView!    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        collectionFavorite.delegate = self;
        collectionFavorite.dataSource = self;
        
        logoInNavigation();
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true);
        getFavorites();
    }
    
    //MARK: Methods CoreData
    func getFavorites(){
        manageResults?.delegate = self;
        
        let searchFavorites: NSFetchRequest<Favorites> = Favorites.fetchRequest();
        let sortFavorites = NSSortDescriptor(key: "name", ascending: true);
        searchFavorites.sortDescriptors = [sortFavorites];
        manageResults = NSFetchedResultsController(fetchRequest: searchFavorites, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil);
        
        do{
            try manageResults?.performFetch();
            collectionFavorite.reloadData();
        } catch{
            print(error.localizedDescription);
        }
    }
    
    //MARK: Delegate CoreData
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .delete:
            break;
        default:
            collectionFavorite.reloadData();
        }
    }
    
    //MARk: Delegate UICollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (manageResults?.fetchedObjects?.count)!;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFavoriteGame", for: indexPath) as! FavoriteCollectionViewCell;
        let imageURL = URL(string: (manageResults?.fetchedObjects![indexPath.row].image)!);
        let imageData = NSData(contentsOf: imageURL!);
        cell.imageGame.image = UIImage(data: imageData! as Data);
        cell.imageGame.clipsToBounds = false;
        cell.imageGame.contentMode = .top;        
        return cell;
    }     
}
