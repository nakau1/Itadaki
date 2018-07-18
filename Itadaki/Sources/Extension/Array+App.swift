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
    
    func isFirstIndex(_ index: Int) -> Bool {
        return firstIndex >= 0 && firstIndex == index
    }
    
    func isLastIndex(_ index: Int) -> Bool {
        return lastIndex >= 0 && lastIndex == index
    }
}
