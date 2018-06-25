// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

extension Const {
    
    /// 路線
    struct Railway {
        
    }
}

extension Path {
    
    /// 路線
    struct Railway {
        
        static var railways: String {
            return documentDirectory.path("railways.json")
        }
        
        static var transfers: String {
            return documentDirectory.path("transfers.json")
        }
        
        static var resource: String {
            return Bundle.main.path(forResource: "railways", ofType: "json")!
        }
        
//        static var directory: String {
//            return documentDirectory.path("Portraits")
//        }
    }
}
