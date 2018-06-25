// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import Foundation

class StationQuery {
    
    class func numbered(_ number: String) -> NSPredicate {
        return NSPredicate("number", equal: number)
    }
}
