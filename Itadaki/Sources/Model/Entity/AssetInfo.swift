// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

/// 資産
struct AssetInfo: Codable {
    let name: String
    let price: Int
    let owner: Player?
    let locatedStationKey: String
    
    enum Keys: String, CodingKey {
        case name
        case price
        case owner
        case locatedStationKey = "station"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        name = container.string(.name)
        price = container.int(.price)
        owner = container.toOrNil(Player.self, .owner)
        locatedStationKey = container.string(.locatedStationKey)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
        try container.encode(owner, forKey: .owner)
        try container.encode(locatedStationKey, forKey: .locatedStationKey)
    }
}

extension AssetInfo {
    
}

extension AssetInfo: CustomStringConvertible {
    
    var description: String {
        return "\(name)"
    }
}

extension Array where Element == AssetInfo {
    
}
