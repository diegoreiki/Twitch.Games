import UIKit
import Alamofire
import ObjectMapper

class GamesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    //MARK: Data
    let searchController = UISearchController(searchResultsController: nil)
    var topGames: TopGames?
    var games: [Games] = []
    
    //MARK: Property
    var refresh: UIRefreshControl!
    
    //MARK: IBOutlet
    @IBOutlet weak var activityLoading: UIActivityIndicatorView!
    @IBOutlet weak var collectionViewTopGames: UICollectionView!    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    
    //MARK: Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logoInNavigation()
        activityLoading.startAnimating()
        activityLoading.hidesWhenStopped = true        
        
        configuraSearch()
        getLastTopGames()
        
        collectionViewTopGames.delegate = self
        collectionViewTopGames.dataSource = self
        
        refresh = UIRefreshControl()
        refresh.tintColor = UIColor.white
        refresh.addTarget(self, action: #selector(GamesViewController.refreshControl), for: UIControlEvents.valueChanged)
        
        collectionViewTopGames.addSubview(refresh)        
    }
    
    //MARK: Methods
    @objc func refreshControl() {
        getLastTopGames(refreshGames: true)
        refresh.endRefreshing()
    }    
    
    func configuraSearch() {
        self.searchController.searchBar.delegate = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
    }    
    
    func getLastTopGames(
        url: String = Constants.api + Constants.url.last + "?limit=20&offset=0&&client_id=" + Constants.client_id, refreshGames: Bool = false){
        Alamofire.request(url, method: .get).validate().responseJSON { (response) in
            
            switch response.result{
                
            case .success:
                let resultData = response.result.value as! Dictionary<String, Any>
                let resultTopGames = Mapper<TopGames>().map(JSON: resultData)
                
                self.topGames = resultTopGames
                
                if refreshGames == true{
                    self.games = (resultTopGames?.games)!
                } else {
                    for item in (resultTopGames?.games)!{
                        self.games.append(item)   
                    }                    
                }
                
                self.activityLoading.stopAnimating()
                self.collectionViewTopGames.reloadData()
            case .failure:
                
                self.alert(title: Constants.message.warning, message: Constants.message.no_connection, view: self, callback: {
                    self.activityLoading.stopAnimating()
                    return
                });
            }
        }
    }    
    
    //MARK: Delegate UICollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellGame", for: indexPath) as! GameCollectionViewCell
        cell.labelName.text = games[indexPath.row].game?.name
        
        let imageURL = URL(string: (self.games[indexPath.row].game?.image?.medium)!)
        let imageData = NSData(contentsOf: imageURL!)
        cell.imageGame.image = UIImage(data: imageData! as Data)
        cell.imageGame.clipsToBounds = false
        cell.imageGame.contentMode = .top
        
        return cell;
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let itemWidth = collectionView.bounds.width/2.1
//        let itemHeight = itemWidth
//        
//        return CGSize(width: itemWidth, height: itemHeight)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets.init(top: 1, left: 1, bottom: 1, right: 1)
//    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {        
        
        if !searchController.isActive{
            let lastCell = games.count - 1
            
            if indexPath.row == lastCell {
                self.getLastTopGames(url: (self.topGames?.links?.next)! + "&client_id=" + Constants.client_id)
            }
        }
    } 
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "detailsGame") as! DetailsViewController
        viewController.game = self.games[indexPath.row].game
        viewController.viewers = self.games[indexPath.row].viewers
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
    //MARK: Delegate SearchBar
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text{
            games = GameFilter.shared.returnGamesFound(listGames: games, text: text)
            collectionViewTopGames.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        getLastTopGames(refreshGames: true)
    }
 
}
