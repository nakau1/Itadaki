// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

/// プレイヤー
struct Player: Codable {
    
    let name: String
    let money: Int
    let currentStationNumber: String
    
    enum Keys: String, CodingKey {
        case name
        case money
        case currentStationNumber = "station"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        name = container.string(.name)
        money = container.int(.money)
        currentStationNumber = container.string(.currentStationNumber)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Keys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(money, forKey: .money)
        try container.encode(currentStationNumber, forKey: .currentStationNumber)
    }
}

extension Player {
    
}

extension Player: CustomStringConvertible {
    
    var description: String {
        return "\(name)"
    }
}

extension Array where Element == Player {
    
}
