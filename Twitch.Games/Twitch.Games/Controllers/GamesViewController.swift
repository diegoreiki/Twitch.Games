import UIKit

class GamesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    //MARK: Data
    var topGames: TopGames?;
    var games: [Games] = [];    
    
    //MARK: Property
    
    //MARK: IBOutlet
    @IBOutlet weak var collectionViewTopGames: UICollectionView!    
    
    //MARK: Lifecicle
    override func viewDidLoad() {
        super.viewDidLoad()
        logoInNavigation();
        
        self.collectionViewTopGames.delegate = self;
        self.collectionViewTopGames.dataSource = self;        
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
