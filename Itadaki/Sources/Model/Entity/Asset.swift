// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

/// 資産
struct Asset: Codable {
    let name: String
    let price: Int
    let owner: Player?
    let locatedStationKey: String
    let infoID: String
    
    enum Keys: String, CodingKey {
        case name
        case price
        case owner
        case locatedStationKey = "station"
        case infoID = "info"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        name = container.string(.name)
        price = container.int(.price)
        owner = container.toOrNil(Player.self, .owner)
        locatedStationKey = container.string(.locatedStationKey)
        infoID = container.string(.infoID)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
        try container.encode(owner, forKey: .owner)
        try container.encode(locatedStationKey, forKey: .locatedStationKey)
        try container.encode(infoID, forKey: .infoID)
    }
}

extension Asset {
    
}

extension Asset: CustomStringConvertible {
    
    var description: String {
        return "\(name)"
    }
}

extension Array where Element == Asset {
    
}
