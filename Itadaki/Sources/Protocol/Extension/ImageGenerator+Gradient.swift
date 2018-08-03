// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

struct Gradient {
    typealias Pointing = (CGRect) -> CGPoint
    
    let colors: [UIColor]
    let locations: [CGFloat]
    let start: Pointing
    let end: Pointing
}

extension Gradient {
    
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

extension ImageGenerator {
    
    func addGradient(to context: CGContext, rect: CGRect, gradient: Gradient) {
        state(context) {
            context.drawLinearGradient(
                generateGradient(gradient),
                start: gradient.start(rect),
                end: gradient.end(rect),
                options: []
            )
        }
    }
    
    func generateGradient(_ gradient: Gradient) -> CGGradient {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let cgColors = gradient.colors.map { $0.cgColor } as CFArray
        return CGGradient(colorsSpace: colorSpace, colors: cgColors, locations: gradient.locations)!
    }
}
