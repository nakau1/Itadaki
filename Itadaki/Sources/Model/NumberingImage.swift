// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class NumberingImage {
    
    func make(railway: Railway, number: String?) -> UIImage {
        return text(number ?? "")
        
        /*
        return UIImage.imageFromContext(size) { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
        */
    }
    
    
    
    
    
    
    
    
    private func text(_ text: String, color: UIColor = .black, font: UIFont = .systemFont(ofSize: 32)) -> UIImage {
        let ns = (text as NSString)
        let attributes: [NSAttributedStringKey : Any] = [
            .font: font,
            .foregroundColor: color,
            ]
        let size = ns.size(withAttributes: attributes)
        return imageFromContext(size) { _ in
            ns.draw(at: .zero, withAttributes: attributes)
        }
    }
    
    private func imageFromContext(_ size: CGSize, _ block: (CGContext) -> Void) -> UIImage {
        UIGraphicsBeginImageContext(size)
        block(UIGraphicsGetCurrentContext()!)
        let ret = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return ret!
    }
}
