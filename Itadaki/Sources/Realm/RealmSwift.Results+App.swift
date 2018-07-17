// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit
import RealmSwift

extension RealmSwift.Results {
    
    var one: Element? {
        return first
    }
    
    var array: [Element] {
        return map { $0 }
    }
}
