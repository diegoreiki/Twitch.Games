import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: Property
    var listFavorites: [Favorites] = []
    
    //MARK: IBOutlet
    @IBOutlet weak var collectionFavorite: UICollectionView!    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionFavorite.delegate = self
        collectionFavorite.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        listFavorites = FavoritesDAO.shared.getFavorites()
        self.collectionFavorite.reloadData()
        
        if listFavorites.count == 0{
            collectionFavorite.isHidden = true
        }        
    }
    
    //MARk: Delegate UICollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listFavorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFavoriteGame", for: indexPath) as! FavoriteCollectionViewCell;
        let imageURL = URL(string: listFavorites[indexPath.row].image!);
        let imageData = NSData(contentsOf: imageURL!);
        cell.imageGame.image = UIImage(data: imageData! as Data);
        cell.imageGame.clipsToBounds = false;
        cell.imageGame.contentMode = .top;        
        return cell;
    }   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.bounds.width/2.1;
        let itemHeight = itemWidth;
        
        return CGSize(width: itemWidth, height: itemHeight);
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 1, left: 1, bottom: 1, right: 1);
    }
}
