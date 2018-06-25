// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit
import RealmSwift

class Station: RealmSwift.Object {
    
    @objc dynamic var number = ""
    @objc dynamic var locationKey = ""
    @objc dynamic var name = ""
    @objc dynamic var roman = ""
    @objc dynamic var isTerminal = false
    @objc dynamic var prevStationNumber: String? = nil
    @objc dynamic var nextStationNumber: String? = nil
    let linkingRailway = LinkingObjects(fromType: Railway.self, property: "stations")
    
    override static func primaryKey() -> String? { return "number" }
}

extension Station {
    
    class func create(from decodedStation: DecodedStation) -> Station {
        let ret = Station()
        ret.number = decodedStation.number
        ret.locationKey = decodedStation.alias ?? decodedStation.roman
        ret.name = decodedStation.name
        ret.roman = decodedStation.roman
        ret.isTerminal = decodedStation.isTerminal
        ret.prevStationNumber = decodedStation.prevStationNumber
        ret.nextStationNumber = decodedStation.nextStationNumber
        return ret
    }
}

extension Station {
    
    var railway: Railway {
        return linkingRailway.first!
    }
    
    var transferrings: [Transferring] {
        return TransferringRepository.transferrings(of: self)
    }
    
    var hasTransferrings: Bool {
        return !transferrings.isEmpty
    }
    
    func destination(direction: DestinationDirection) -> String {
        guard let destinationTransferring = TransferringRepository.destination(of: self, direction: direction) else {
            return ""
        }
        return destinationTransferring.destination
    }
}

extension Station {
    
    func isFirstStation(_ direction: DestinationDirection) -> Bool {
        return prevStation(direction) == nil
    }
    
    func isFinalStation(_ direction: DestinationDirection) -> Bool {
        return nextStation(direction) == nil
    }
    
    func nextStation(_ direction: DestinationDirection) -> Station? {
        switch direction {
        case .ascending:
            return ascendedStation
        case .descending:
            return desscendedStation
        }
    }
    
    func prevStation(_ direction: DestinationDirection) -> Station? {
        switch direction {
        case .ascending:
            return desscendedStation
        case .descending:
            return ascendedStation
        }
    }
    
    var ascendedStation: Station? {
        let currentRailway = self.railway
        guard let index = currentRailway.stations.index(of: self) else { return nil }
        
        if index == currentRailway.stations.lastIndex {
            guard
                let nextNumber = nextStationNumber,
                let nextStation = StationRepository.numbered(nextNumber)
                else {
                    return nil
            }
            return nextStation
        }
        return currentRailway.stations[index + 1]
    }
    
    var desscendedStation: Station? {
        let currentRailway = self.railway
        guard let index = currentRailway.stations.index(of: self) else { return nil }
        
        if index == currentRailway.stations.firstIndex {
            guard
                let prevNumber = prevStationNumber,
                let prevStation = StationRepository.numbered(prevNumber)
                else {
                    return nil
            }
            return prevStation
        }
        return currentRailway.stations[index - 1]
    }
}
