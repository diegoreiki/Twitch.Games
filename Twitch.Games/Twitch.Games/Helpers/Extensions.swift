import Foundation
import UIKit

extension UIColor {
    func toImage() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1);
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0);
        self.setFill();
        UIRectFill(rect);
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return image!;
    }
}

extension UIViewController{
    func logoInNavigation() {
        let logo = UIImageView(image: UIImage(named: "Logotipo"));
        logo.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 87, height: 30));
        
        let viewTitle = UIView(frame: CGRect(x: 0, y: 0, width: 87, height: 30));
        viewTitle.addSubview(logo);
        
        self.navigationItem.titleView = viewTitle;
    }
    
    func alert(title: String, message: String, view: UIViewController, callback: (() -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert);
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { (action) in
            if callback != nil{
                callback!();
            }
        });
        DispatchQueue.main.async {
            view.present(alert, animated: true, completion: nil);
        }
    }
}
