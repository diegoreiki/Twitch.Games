import UIKit
import Alamofire
import ObjectMapper

class GamesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    //MARK: Data
    var topGames: TopGames?;
    var games: [Games] = [];    
    
    //MARK: Property
    
    //MARK: IBOutlet
    @IBOutlet weak var activityLoading: UIActivityIndicatorView!
    @IBOutlet weak var collectionViewTopGames: UICollectionView!    
    
    //MARK: Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        logoInNavigation();
        
        self.collectionViewTopGames.delegate = self;
        self.collectionViewTopGames.dataSource = self;        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true);
        
        getLastTopGames();
        activityLoading.startAnimating();
        activityLoading.hidesWhenStopped = true;
    }    
    
    //MARK: Methods API
    func getLastTopGames(
        url: String = Constants.api + Constants.url.last + "?limit=20&offset=0&&client_id=" + Constants.client_id, refreshGames: Bool = false){
        Alamofire.request(url, method: .get).validate().responseJSON { (response) in
            
            switch response.result{
                
            case .success:
                let resultData = response.result.value as! Dictionary<String, Any>; 
                let resultTopGames = Mapper<TopGames>().map(JSON: resultData);
                
                self.topGames = resultTopGames;
                
                if refreshGames == true{
                    self.games = (resultTopGames?.games)!;
                } else {
                    for item in (resultTopGames?.games)!{
                        self.games.append(item)   
                    }                    
                }
                
                self.activityLoading.stopAnimating();
                self.collectionViewTopGames.reloadData();
            case .failure:
                
                self.alert(title: Constants.message.warning, message: Constants.message.no_connection, view: self, callback: {
                    self.activityLoading.stopAnimating();
                    return;
                });
            }
        }
    }    
    
    //MARK: Delegate UICollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: " ", for: indexPath);
        return cell;
    }    
}
