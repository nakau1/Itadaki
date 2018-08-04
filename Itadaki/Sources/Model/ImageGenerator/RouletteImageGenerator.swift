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
            addGradient(to: cxt, rect: rect, gradient: .forward)
            addText(to: cxt, rect: rect, text: .stepCount(4))
        }
    }
}

private extension ImageText {
    
    static func stepCount(_ count: Int) -> ImageText {
        var ret = ImageText("\(count)", color: .white, font: .default(250), pointing: { rect, size in
            return CGPoint(24, 24)
        })
        ret.shadow = ImageText.Shadow()
        ret.border = ImageText.Border()
        
        return ret
    }
}

private extension Gradient {
    
    static let forward: Gradient = Gradient(
        colors: [UIColor(rgb: 0x00B77E), UIColor(rgb: 0x93C862)],
        locations: [0, 1],
        start: { CGPoint($0.midX, $0.minY) },
        end: { CGPoint($0.midX, $0.maxY) }
    )
    
    static let minus: Gradient = Gradient(
        colors: [UIColor(rgb: 0xFE9A3D), UIColor(rgb: 0xEA3261)],
        locations: [0, 1],
        start: { CGPoint($0.minX, $0.minY) },
        end: { CGPoint($0.maxX, $0.maxY) }
    )
    
    static let plus: Gradient = Gradient(
        colors: [UIColor(rgb: 0x00CBF7), UIColor(rgb: 0x0057DE)],
        locations: [0, 1],
        start: { CGPoint($0.midX, $0.minY) },
        end: { CGPoint($0.midX, $0.maxY) }
    )
}


