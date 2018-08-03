// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

struct ImageText {
    
    struct Border {
        var color: UIColor = .black
        var width: CGFloat = 1
    }
    
    struct Shadow {
        var color: UIColor = .black
        var offsetX: CGFloat = 10
        var offsetY: CGFloat = 10
        var blur: CGFloat = 1.5
    }
    
    typealias Pointing = (CGRect, CGSize) -> CGPoint
    
    var text: String
    var pointing: Pointing
    var border: ImageText.Border?
    var shadow: ImageText.Shadow?
    
    fileprivate var attributes: [NSAttributedStringKey : Any]
    
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
        var textRect = CGRect.zero
        state(context) {
            let ns = imageText.text as NSString
            let size = ns.size(withAttributes: imageText.attributes)
            textRect = CGRect(imageText.pointing(rect, size), size)
            ns.draw(in: textRect, withAttributes: imageText.attributes)
        }
        addBorderdTextIfNeeded(to: context, rect: rect, text: imageText)
        return textRect
    }
    
    private func addBorderdTextIfNeeded(to context: CGContext, rect: CGRect, text imageText: ImageText) {
        guard let border = imageText.border else { return }
        
        state(context) {
            let ns = imageText.text as NSString
            var attributes = imageText.attributes
            attributes.removeValue(forKey: .foregroundColor)
            attributes[.strokeColor] = border.color
            attributes[.strokeWidth] = border.width
            let size = ns.size(withAttributes: attributes)
            let textRect = CGRect(imageText.pointing(rect, size), size)
            ns.draw(in: textRect, withAttributes: attributes)
        }
    }
}
