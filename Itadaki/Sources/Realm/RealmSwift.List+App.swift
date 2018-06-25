// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit
import RealmSwift

extension RealmSwift.List {
    
    var firstIndex: Int {
        return count > 0 ? 0 : -1
    }
    
    var lastIndex: Int {
        return count > 0 ? count - 1 : -1
    }
}
