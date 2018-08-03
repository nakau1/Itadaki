// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class RouletteImageGenerator: ImageGenerator {
    
    let imageSize: CGSize = CGSize(300, 300)
    
    func generate() -> UIImage {
        return imageFromContext(imageSize) { cxt in
            let rect = CGRect(imageSize)
            addGradient(to: cxt, rect: rect, gradient: .plus)
            
            
            let opt = ImageText("1", color: .white, font: .default(100))
            addText(to: cxt, rect: rect, text: opt)
        }
    }
}
