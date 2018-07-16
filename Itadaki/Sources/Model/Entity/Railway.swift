// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit
import RealmSwift

// specification
class Railway: RealmSwift.Object {
    
    @objc dynamic var code = ""
    @objc dynamic var name = ""
    @objc dynamic var ascendingFinalStop: String? = nil
    @objc dynamic var desscendingFinalStop: String? = nil
    @objc dynamic var companyCode = ""
    @objc dynamic var mainColorCode = ""
    @objc dynamic var subColorCode = ""
    @objc dynamic var textColorCode = ""
    
    var stations = RealmSwift.List<Station>()
    
    override static func primaryKey() -> String? { return "code" }
}

// implementation
extension Railway {
    
    class func create(from decodedRailway: DecodedRailway) -> Railway {
        let ret = Railway()
        ret.code = decodedRailway.code
        ret.name = decodedRailway.name
        ret.companyCode = decodedRailway.company
        ret.mainColorCode = decodedRailway.color.colorCode
        ret.subColorCode = "FFFFFF" // TODO:
        ret.textColorCode = "444444" // TODO:
        ret.ascendingFinalStop = decodedRailway.ascendingFinalStop
        ret.desscendingFinalStop = decodedRailway.desscendingFinalStop
        
        ret.stations.append(objectsIn: decodedRailway.stations.map { decodedStation -> Station in
            return Station.create(from: decodedStation)
        })
        return ret
    }
}

//
extension Railway {
    
    var company: Company {
        return Company(rawValue: companyCode) ?? .unknown
    }
    
    var color: UIColor {
        return UIColor(colorCode: mainColorCode)
    }
    
    var subColor: UIColor {
        return UIColor(colorCode: subColorCode)
    }
    
    var textColor: UIColor {
        return UIColor(colorCode: textColorCode)
    }
    
    var numberingImage: UIImage {
        return NumberingImage().make(railway: self, number: nil)
    }
}

//
extension Railway {
    
    func ascended(_ station: Station) -> Station? {
        if let nextNumber = station.nextStationNumber, let nextStation = StationRepository.numbered(nextNumber) {
            return nextStation
        } else if let pos = stations.index(of: station), pos < (stations.count - 1) {
            return stations[pos + 1]
        }
        return nil
    }
    
    func desscended(_ station: Station) -> Station? {
        if let prevNumber = station.prevStationNumber, let prevStation = StationRepository.numbered(prevNumber) {
            return prevStation
        } else if let pos = stations.index(of: station), pos > 0 {
            return stations[pos - 1]
        }
        return nil
    }
}
