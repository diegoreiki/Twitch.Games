import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: Property   
    var games: Games?;
    @IBOutlet weak var imageGame: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelViewers: UILabel!
    
    //MARK: Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad();
        setupDetailsGame();
        
        let buttonFavorite = UIBarButtonItem(image: UIImage(named: "FavoriteOn"), style: .plain, target: self, action: #selector(addFavorite));
        self.navigationItem.rightBarButtonItem  = buttonFavorite;
    }
    
    //MARK: Methods
    @objc func addFavorite() {
        
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
