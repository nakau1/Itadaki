// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import Foundation

class RailwayRepository {
    
    class func code(_ code: String) -> Railway? {
        let predicate = NSPredicate("code", equal: code)
        return Realm.select(from: Railway.self, predicate: predicate).first
    }
}
