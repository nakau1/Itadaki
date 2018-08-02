// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol ImageGenerator {
    
    func generate() -> UIImage
}

extension ImageGenerator {
    
    func imageFromContext(_ size: CGSize, _ block: (CGContext) -> Void) -> UIImage {
        UIGraphicsBeginImageContext(size)
        block(UIGraphicsGetCurrentContext()!)
        let ret = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return ret!
    }
}
