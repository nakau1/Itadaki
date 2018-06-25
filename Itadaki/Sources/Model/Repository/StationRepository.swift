// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import Foundation

class StationRepository {
    
    class func numbered(_ number: String) -> Station? {
        let predicate = StationQuery.numbered(number)
        return Realm.select(from: Station.self, predicate: predicate).first
    }
}
