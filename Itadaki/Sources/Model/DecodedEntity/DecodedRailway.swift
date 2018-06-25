// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

/// specification
struct DecodedRailway: Decodable {
    
    let code: String
    let name: String
    let company: String
    let color: UIColor
    let ascendingFinalStop: String?
    let desscendingFinalStop: String?
    let stations: [DecodedStation]
    
    enum Keys: String, CodingKey {
        case code
        case name
        case company
        case color
        case ascendingFinalStop = "asc_final"
        case desscendingFinalStop = "desc_final"
        case stations
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        
        code = container.string(.code)
        name = container.string(.name)
        company = container.string(.company)
        color = container.color(.color)
        ascendingFinalStop = container.stringOrNil(.ascendingFinalStop)
        desscendingFinalStop = container.stringOrNil(.desscendingFinalStop)
        stations = container.to([DecodedStation].self, .stations, [])
    }
}

extension DecodedRailway: Equatable {
    
    static func == (lhs: DecodedRailway, rhs: DecodedRailway) -> Bool {
        return lhs.code == rhs.code
    }
}

extension DecodedRailway {
    
    func ascended(_ station: DecodedStation) -> DecodedStation? {
        if let nextNumber = station.nextStationNumber, let nextStation = fetchStation(numbered: nextNumber) {
            return nextStation
        } else if let pos = stations.index(of: station), pos < (stations.count - 1) {
            return stations[pos + 1]
        }
        return nil
    }
    
    func desscended(_ station: DecodedStation) -> DecodedStation? {
        if let prevNumber = station.prevStationNumber, let prevStation = fetchStation(numbered: prevNumber) {
            return prevStation
        } else if let pos = stations.index(of: station), pos > 0 {
            return stations[pos - 1]
        }
        return nil
    }
    
    func fetchStation(numbered targetStationNumber: String) -> DecodedStation? {
        for station in stations {
            if station.number == targetStationNumber {
                return station
            }
        }
        return nil
    }
}
