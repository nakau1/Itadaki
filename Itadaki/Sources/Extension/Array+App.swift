// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

extension Array {
    
    var firstIndex: Int {
        return count > 0 ? 0 : -1
    }
    
    var lastIndex: Int {
        return count > 0 ? count - 1 : -1
    }
}
