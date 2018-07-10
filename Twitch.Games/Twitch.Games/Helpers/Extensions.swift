import Foundation
import UIKit

extension UIViewController{
    func logoInNavigation() {
        let logo = UIImageView(image: UIImage(named: "Logotipo"));
        logo.frame = CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 87, height: 30));
        
        let viewTitle = UIView(frame: CGRect(x: 0, y: 0, width: 87, height: 30));
        viewTitle.addSubview(logo);
        
        self.navigationItem.titleView = viewTitle;
    }
}
