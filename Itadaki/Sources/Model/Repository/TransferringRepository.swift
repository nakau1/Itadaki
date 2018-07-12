// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import Foundation

class TransferringRepository {
    
    class func transferrings(of station: Station) -> [Transferring] {
        let predicate = NSPredicate.compounded(.and, [
            NSPredicate("locationKey", equal: station.locationKey),
            NSPredicate("station", notEqual: station)
            ])
        return Realm.select(from: Transferring.self, predicate: predicate).map { $0 }
    }
    
    class func destination(of station: Station, direction: DestinationDirection) -> Transferring? {
        let predicate = NSPredicate.compounded(.and, [
            NSPredicate("locationKey", equal: station.locationKey),
            NSPredicate("direction", equal: direction.rawValue),
            NSPredicate("station", equal: station),
            ])
        return Realm.select(from: Transferring.self, predicate: predicate).first
    }
}
