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
