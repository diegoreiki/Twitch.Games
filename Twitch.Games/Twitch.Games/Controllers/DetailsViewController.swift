import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: Property
    var listFavorites: [Favorites] = []
    var game: Game?
    var viewers: Int?
    let buttonFavorite = UIButton(type: .custom)
    
    //MARK: IBOutlet
    @IBOutlet weak var imageGame: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelViewers: UILabel!
    
    //MARK: Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listFavorites = FavoritesDAO.shared.getFavorites()
        checkFavorites()
        setupGameInfo()
    }
    
    //MARK: Methods
    @objc func addFavorite() {
        
        guard let game = game else { return }
        FavoritesDAO.shared.addFavorite(game: game)
        setButtonAddFavorite(status: false)
    }
    
    @objc func removeFavorite(){
        
        guard let game = game else { return }
        FavoritesDAO.shared.removeFavorite(game: game)
        setButtonAddFavorite(status: true)
    }
    
    func checkFavorites(){
        
        if listFavorites.count == 0{
            setButtonAddFavorite(status: true)
            return
        }
        
        for favorite in listFavorites{
            if Int(favorite.id) == game!.id!{
                setButtonAddFavorite(status: false)
                return
            } else {
                setButtonAddFavorite(status: true)
            }
        }
    }
    
    func setupGameInfo(){
        guard let infoGame = game else { return }
        self.navigationItem.title = infoGame.name
        let imageUrl = URL(string: (infoGame.image?.large)!)
        let imageData = NSData(contentsOf: imageUrl!)
        imageGame.image = UIImage(data: imageData! as Data)
        labelName.text = infoGame.name
        
        guard let viewsGame = viewers else { return }
        labelViewers.text = "Visualizações: \(String(viewsGame))"
    }
    
    func setButtonAddFavorite(status: Bool){
        
        if status{
            buttonFavorite.setImage(UIImage (named: "AddFavorite"), for: .normal)
            buttonFavorite.removeTarget(self, action: #selector(removeFavorite), for: .touchUpInside)
            buttonFavorite.addTarget(self, action: #selector(addFavorite), for: .touchUpInside)
        } else {
            buttonFavorite.setImage(UIImage (named: "RemoveFavorite"), for: .normal)
            buttonFavorite.removeTarget(self, action: #selector(addFavorite), for: .touchUpInside)
            buttonFavorite.addTarget(self, action: #selector(removeFavorite), for: .touchUpInside)
        }
        
        buttonFavorite.frame = CGRect(x: 0.0, y: 0.0, width: 35.0, height: 35.0)
        let barButtonFavorite = UIBarButtonItem(customView: buttonFavorite)
        
        self.navigationItem.rightBarButtonItems = [barButtonFavorite]
    }
}
