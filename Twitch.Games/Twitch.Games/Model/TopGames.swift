import UIKit
import ObjectMapper

class TopGames: Mappable {
    
    var total: Int?
    var links: Links?;
    var games: [Games] = [];
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        total   <- map["_total"];
        links   <- map["_links"];
        games    <- map["top"];
    }
}

class Links: Mappable{
    
    var prev: String?;
    var next: String?;
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        prev <- map["self"];
        next <- map["next"];
    }
}

class Games: Mappable{
    
    var game: Game?;
    var viewers: Int?;
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        game    <- map["game"];
        viewers <- map["viewers"];
    }
}
