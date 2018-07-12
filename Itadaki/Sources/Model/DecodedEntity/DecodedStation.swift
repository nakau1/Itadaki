// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

/// specification
struct DecodedStation: Decodable {
    
    let number: String
    let name: String
    let roman: String
    let alias: String?
    let isTerminal: Bool
    let prevStationNumber: String?
    let nextStationNumber: String?
    
    enum Keys: String, CodingKey {
        case number = "no"
        case name
        case roman
        case alias
        case isTerminal = "terminal"
        case prevStationNumber = "prev"
        case nextStationNumber = "next"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        number = container.string(.number)
        name = container.string(.name)
        roman = container.string(.roman)
        alias = container.stringOrNil(.alias)
        isTerminal = container.bool(.isTerminal)
        prevStationNumber = container.stringOrNil(.prevStationNumber)
        nextStationNumber = container.stringOrNil(.nextStationNumber)
    }
}

extension DecodedStation: Equatable {
    
    static func == (lhs: DecodedStation, rhs: DecodedStation) -> Bool {
        return lhs.number == rhs.number
    }
}

extension DecodedStation {
    
    func isFinalStation(in railway: DecodedRailway, direction: DestinationDirection) -> Bool {
        switch direction {
        case .ascending:
            guard let pos = railway.stations.index(of: self), pos == railway.stations.lastIndex else {
                return false
            }
            return nextStationNumber == nil
        case .descending:
            guard let pos = railway.stations.index(of: self), pos == railway.stations.firstIndex else {
                return false
            }
            return prevStationNumber == nil
        }
    }
}
