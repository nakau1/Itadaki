// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import Foundation

class StationRepository {
    
    class func numbered(_ number: String) -> Station? {
        let predicate = NSPredicate("number", equal: number)
        return Realm.select(from: Station.self, predicate: predicate).first
    }
}
