// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class RouletteImageGenerator: ImageGenerator {
    
    let baseSize = CGSize(300, 300)
    
    func generate() -> UIImage {
        return imageFromContext(baseSize) { cxt in
            let rect = CGRect(baseSize)
            addGradient(to: cxt, rect: rect, gradient: .plus)
        }
    }
}
