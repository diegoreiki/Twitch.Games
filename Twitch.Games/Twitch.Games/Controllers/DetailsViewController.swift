import UIKit
import CoreData

class DetailsViewController: UIViewController {
    
    //MARK: Property   
    var context:NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate;
        return appDelegate.persistentContainer.viewContext;
    }     
    var games: Games?;
    
    //MARK: IBOutlet
    @IBOutlet weak var imageGame: UIImageView!;
    @IBOutlet weak var labelName: UILabel!;
    @IBOutlet weak var labelViewers: UILabel!;
    
    //MARK: Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad();
        setupDetailsGame();
        
        let buttonFavorite = UIBarButtonItem(image: UIImage(named: "FavoriteOn"), style: .plain, target: self, action: #selector(addFavorite));
        self.navigationItem.rightBarButtonItem  = buttonFavorite;
    }
    
    //MARK: Methods
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
    }
    
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
