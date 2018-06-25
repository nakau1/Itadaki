// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

/// 行き先方向
enum DestinationDirection: String, Codable {
    
    case ascending = "asc"
    case descending = "desc"
}

extension DestinationDirection {
    
    var reversed: DestinationDirection {
        switch self { case .ascending: return .descending; default: return .ascending }
    }
}
