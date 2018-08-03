// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class RouletteImageGenerator: ImageGenerator {
    
    let imageSize: CGSize = CGSize(500, 500)
    
    func generate() -> UIImage {
        return imageFromContext(imageSize) { cxt in
            let rect = CGRect(imageSize)
            addGradient(to: cxt, rect: rect, gradient: .plus)
            
            
            addText(to: cxt, rect: rect, text: .stepCount(4))
        }
    }
}

private extension ImageText {
    
    static func stepCount(_ count: Int) -> ImageText {
        return ImageText("\(count)", color: .white, font: .default(250), pointing: { rect, size in
            return CGPoint(24, 24)
        })
    }
}
