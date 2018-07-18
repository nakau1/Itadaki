// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit
import RealmSwift

class Transferring: RealmSwift.Object {
    @objc dynamic var id = ""
    @objc dynamic var locationKey = ""
    @objc dynamic var railway: Railway?
    @objc dynamic var station: Station?
    @objc dynamic var directionValue = ""
    @objc dynamic var destination = ""
    
    override static func primaryKey() -> String? { return "id" }
}

extension Transferring {
    
    class func create(_ locationKey: String, station: DecodedStation, railway: DecodedRailway, direction: DestinationDirection) -> Transferring? {
        let ret = Transferring()
        ret.id = Transferring.generateIdentifier(station: station, direction: direction)
        ret.locationKey = locationKey
        ret.station = Station.create(from: station)
        ret.railway = Railway.create(from: railway)
        ret.directionValue = direction.rawValue
        
        guard let dest = Transferring.generateDestination(of: station, in: railway, direction: direction) else {
            return nil
        }
        ret.destination = dest
        
        return ret
    }
}

extension Transferring {
    
    var direction: DestinationDirection {
        return DestinationDirection(rawValue: directionValue) ?? .ascending
    }
}

extension Transferring {
    
    class func generateIdentifier(station: DecodedStation, direction: DestinationDirection) -> String {
        return "\(station.number.uppercased())_\(direction.rawValue.uppercased())"
    }
    
    class func generateDestination(of station: DecodedStation, in railway: DecodedRailway, direction: DestinationDirection) -> String? {
        var stops = [String]()
        var count = 3
        
        if station.isFinalStation(in: railway, direction: direction) {
            return nil
        }
        
        switch direction {
        case .ascending:
            if let final = railway.ascendingFinalStop {
                stops.append(final)
                count -= 1
            }
            var tempStation = railway.ascended(station)
            while (tempStation != nil) {
                if tempStation!.isTerminal || tempStation!.isFinalStation(in: railway, direction: direction) {
                    stops.append(tempStation!.name)
                    count -= 1
                }
                if count <= 0 { break }
                tempStation = railway.ascended(tempStation!)
            }
        case .descending:
            if let final = railway.desscendingFinalStop {
                stops.append(final)
                count -= 1
            }
            
            var tempStation = railway.desscended(station)
            while (tempStation != nil) {
                if tempStation!.isTerminal || tempStation!.isFinalStation(in: railway, direction: direction) {
                    stops.append(tempStation!.name)
                    count -= 1
                }
                if count <= 0 { break }
                tempStation = railway.desscended(tempStation!)
            }
        }
        return stops.joined(separator: "・")
    }
}
