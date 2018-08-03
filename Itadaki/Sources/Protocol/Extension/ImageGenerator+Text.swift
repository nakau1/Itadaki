// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

struct ImageText {
    typealias Pointing = (CGRect, CGSize) -> CGPoint
    
    var text: String
    var attributes: [NSAttributedStringKey : Any]
    var pointing: Pointing
    
    init(_ text: String, color: UIColor? = nil, font: UIFont? = nil, pointing: Pointing? = nil) {
        self.text = text
        self.attributes = [
            .font: font ?? UIFont.default(30),
            .foregroundColor: color ?? UIColor.black
        ]
        self.pointing = pointing ?? { rect, size in
            return CGPoint((rect.width - size.width) / 2, (rect.height - size.height) / 2)
        }
    }
}

extension ImageGenerator {
    
    func addText(to context: CGContext, rect: CGRect, text imageText: ImageText) {
        _ = addTextAndFetchRect(to: context, rect: rect, text: imageText)
    }
    
    func addTextAndFetchRect(to context: CGContext, rect: CGRect, text imageText: ImageText) -> CGRect {
        context.saveGState()
        
        let ns = imageText.text as NSString
        let size = ns.size(withAttributes: imageText.attributes)
        let textRect = CGRect(imageText.pointing(rect, size), size)
        ns.draw(in: textRect, withAttributes: imageText.attributes)
        context.restoreGState()
        
        return textRect
    }
}
