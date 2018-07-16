import UIKit

class FavoriteViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    //MARK: Property
    var listFavorites: [Favorites] = []
    
    //MARK: IBOutlet
    @IBOutlet weak var collectionFavorite: UICollectionView!    
    @IBOutlet weak var viewFavoriteEmpty: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionFavorite.delegate = self
        collectionFavorite.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        listFavorites = FavoritesDAO.shared.getFavorites()
        
        if listFavorites.count == 0{
            collectionFavorite.isHidden = true
        } else {
            collectionFavorite.isHidden = false
        }
        collectionFavorite.reloadData()
    }
    
    //MARk: Delegate UICollectionView
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listFavorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellFavoriteGame", for: indexPath) as! FavoriteCollectionViewCell
        cell.labelName.text = listFavorites[indexPath.row].name!

        if let imageURL = URL(string: listFavorites[indexPath.row].image!){
            let imageData = NSData(contentsOf: imageURL)
            cell.imageGame.image = UIImage(data: imageData! as Data)
            cell.imageGame.clipsToBounds = false
            cell.imageGame.contentMode = .top            
        }
      
        return cell
    }   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 1, left: 2, bottom: 1, right: 2)
    }
}
