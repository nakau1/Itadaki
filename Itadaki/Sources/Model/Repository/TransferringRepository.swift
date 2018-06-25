// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import Foundation

class TransferringRepository {
    
    class func transferrings(of station: Station) -> [Transferring] {
        let predicate = TransferringQuery.of(station)
        return Realm.select(from: Transferring.self, predicate: predicate).map { $0 }
    }
    
    class func destination(of station: Station, direction: DestinationDirection) -> Transferring? {
        let predicate = TransferringQuery.destination(of: station, direction: direction)
        return Realm.select(from: Transferring.self, predicate: predicate).first
    }
}
