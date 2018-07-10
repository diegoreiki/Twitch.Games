import UIKit
import ObjectMapper

class Game: Mappable {
    
    var id: Int?;
    var name: String?;
    var logo: Logo?;
    var image: Image?;
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        id    <- map["_id"];
        name  <- map["name"];
        logo  <- map["logo"];
        image <- map["box"];
    }
}

class Logo: Mappable{
    
    var large: String?;
    var medium: String?;
    var small: String?;
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        large  <- map["large"];
        medium <- map["medium"];
        small  <- map["small"];
    }
}

class Image: Mappable{
    
    var large: String?;
    var medium: String?;
    var small: String?;
    
    required init?(map: Map) {
        large  <- map["large"];
        medium <- map["medium"];
        small  <- map["small"];
    }
    
    func mapping(map: Map) {
        
    }
}
