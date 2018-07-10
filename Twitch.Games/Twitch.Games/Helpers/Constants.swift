import Foundation

struct Constants {
    
    static let api = "https://api.twitch.tv/kraken/";
    static let client_id = "3xkc7y0c38p5ileytdtqrfzwvwrrrb";
    
    enum url {
        static var last = "games/top";
    }
    
    enum message {
        static var warning = "Atenção";
        static var no_connection = "Desculpe, houve um problema de conexão, verifique sua internet e tente novamente.";
    }
}
