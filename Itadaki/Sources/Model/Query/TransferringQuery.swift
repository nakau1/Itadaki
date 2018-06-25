// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import Foundation

class TransferringQuery {
    
    class func of(_ station: Station) -> NSPredicate {
        return NSPredicate("locationKey", equal: station.locationKey)
            .and(NSPredicate("station", notEqual: station))
    }
    
    class func destination(of station: Station, direction: DestinationDirection) -> NSPredicate {
        return NSPredicate("locationKey", equal: station.locationKey)
            .and(NSPredicate("direction", notEqual: direction.rawValue))
            .and(NSPredicate("station", equal: station))
    }
}
