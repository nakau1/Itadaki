// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

/// 行き先方向
enum Company: String, Codable {
    
    case unknown
    case jr = "JR"
    case metro = "Metro"
    case toei = "Toei"
}

extension Company {
    
    var name: String {
        switch self {
        case .jr: return "JR"
        case .metro: return "東京メトロ"
        case .toei: return "都営"
        default: return "-"
        }
    }
}
