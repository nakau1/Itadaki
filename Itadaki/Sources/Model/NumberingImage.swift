// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class NumberingImage {
    
    private let baseSize = CGSize(64, 64)
    
    func make(railway: Railway, number: String?) -> UIImage {
        switch railway.company {
        case .jr:
            return numberingImage(forJR: railway, number: number)
        default:
            return UIImage()
        }
    }
    
    private func numberingImage(forJR railway: Railway, number: String?) -> UIImage {
        return imageFromContext(baseSize) { cxt in
            let border: CGFloat = 8
            let rect = rectBordered(border, of: baseSize)
            addFill(context: cxt, color: .white) {
                addCornerRadiusToPath(context: $0, size: baseSize, borderWidth: border)
            }
            addStroke(context: cxt, borderWidth: border, color: railway.color) {
                addCornerRadiusToPath(context: $0, size: baseSize, borderWidth: border)
            }
            
            let texts = dismantle(number ?? railway.code)
            addTexts(context: cxt, texts: texts, color: .black, in: rect)
        }
    }
    
    private func addTexts(context cxt: CGContext, texts: [String], color: UIColor, in originalRect: CGRect) {
        let rect = originalRect.insetBy(dx: 4, dy: 4)
        let fontHeight = rect.height / texts.count.f
        let font = UIFont(name: "Arial-BoldMT", size: fontHeight)!
        var offset = rect.minY
        
        for text in texts {
            let ns = (text as NSString)
            let attributes: [NSAttributedStringKey : Any] = [
                .font: font,
                .foregroundColor: color,
                ]
            let size = ns.size(withAttributes: attributes)
            let textRect = CGRect(
                ((rect.width - size.height) / 2) + rect.minY,
                offset,
                size.width,
                size.height
            )
            ns.draw(in: textRect, withAttributes: attributes)
            offset += fontHeight
        }
    }
    
    private func addFill(context cxt: CGContext, color: UIColor, pathing: (CGContext) -> Void) {
        cxt.saveGState()
        cxt.setFillColor(color.cgColor)
        pathing(cxt)
        cxt.fillPath()
        cxt.restoreGState()
    }
    
    private func addStroke(context cxt: CGContext, borderWidth: CGFloat, color: UIColor, pathing: (CGContext) -> Void) {
        cxt.saveGState()
        cxt.setStrokeColor(color.cgColor)
        cxt.setLineWidth(borderWidth)
        pathing(cxt)
        cxt.strokePath()
        cxt.restoreGState()
    }
    
    private func addCornerRadiusToPath(context cxt: CGContext, size: CGSize, borderWidth: CGFloat) {
        let rect = rectBordered(borderWidth, of: size)
        cxt.move(to: CGPoint(rect.minX, rect.midY))
        cxt.addArc(tangent1End: CGPoint(rect.minX, rect.minY), tangent2End: CGPoint(rect.midX, rect.minY), radius: borderWidth)
        cxt.addArc(tangent1End: CGPoint(rect.maxX, rect.minY), tangent2End: CGPoint(rect.maxX, rect.midY), radius: borderWidth)
        cxt.addArc(tangent1End: CGPoint(rect.maxX, rect.maxY), tangent2End: CGPoint(rect.midX, rect.maxY), radius: borderWidth)
        cxt.addArc(tangent1End: CGPoint(rect.minX, rect.maxY), tangent2End: CGPoint(rect.minX, rect.midY), radius: borderWidth)
        cxt.closePath()
    }
    
    private func rectBordered(_ borderWidth: CGFloat, of size: CGSize) -> CGRect {
        let borderHalfWidth = borderWidth / 2
        return CGRect(borderHalfWidth, borderHalfWidth, size.width - borderWidth, size.height - borderWidth)
    }
    
    private func dismantle(_ value: String) -> [String] {
        guard let rgx = try? NSRegularExpression(pattern: "[A-Z]+|[0-9]+", options: []) else {
            return []
        }
        return rgx.matches(in: value, options: [], range: NSMakeRange(0, value.count)).map {
            return (value as NSString).substring(with: $0.range(at: 0))
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
