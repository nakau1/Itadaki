// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol MessageViewDelegate: class {
    
}

class MessageView: UIView {
    
    weak var delegate: MessageViewDelegate?
    
    var font = UIFont(name: "HiraMaruProN-W4", size: 18)! {
        didSet {
            if label != nil {
                label.font = font
            }
        }
    }
    
    var textColor = UIColor.white {
        didSet {
            if label != nil {
                label.textColor = textColor
            }
        }
    }
    
    var duration: TimeInterval = 0.01
    
    private var storedText = ""
    private var label: UILabel!
    private var index = 0
    private var maxIndex = 0
    private var timer: Timer!
    private var shown = false
    
    func setText(_ text: String, animate: Bool) {
        makeLabelIfNeeded()
        
        storedText = text
        index = 0
        maxIndex = storedText.count - 1
        
        if animate {
            shown = false
            label.frame = .zero
            label.text = ""
            timer = makeTimer()
        } else {
            shown = true
            label.frame = labelFrame(of: text)
            label.text = text
        }
    }
    
    @objc private func didFireTimer() {
        let text = substring(storedText, start: 0, end: index)
        let frame = labelFrame(of: text)
        
        label.frame = frame
        label.text = text
        
        index += 1
        if index < storedText.count {
            timer = makeTimer()
        } else {
            shown = true
            timer.invalidate()
        }
    }
    
    @objc private func didTapSelf() {
        if timer.isValid {
            timer.invalidate()
        }
        
        if shown {
            
        } else {
            shown = true
            label.frame = labelFrame(of: storedText)
            label.text = storedText
        }
    }
    
    private func makeLabelIfNeeded() {
        if label == nil {
            label = UILabel(frame: .zero)
            label.font = font
            label.textColor = textColor
            label.numberOfLines = 0
            label.lineBreakMode = .byCharWrapping
            addSubview(label)
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapSelf))
            addGestureRecognizer(gesture)
        }
    }
    
    private func makeTimer(_ selector: Selector = #selector(didFireTimer)) -> Timer {
        let timer = Timer(
            timeInterval: duration,
            target: self,
            selector: selector,
            userInfo: nil,
            repeats: false
        )
        RunLoop.main.add(timer, forMode: .defaultRunLoopMode)
        return timer
    }
    
    private func substring(_ string: String, start: Int, end: Int) -> String {
        let max = string.count - 1
        var s = start, e = end
        if max < 0 || e < s || max < s || e < 0 {
            return ""
        }
        s = s >= 0 ? s : 0
        e = max >= e ? e : max
        
        let substring = string[string.index(string.startIndex, offsetBy: s)...string.index(string.startIndex, offsetBy: e)]
        return String(substring)
    }
    
    private func labelFrame(of text: String) -> CGRect {
        var frame = bounds.insetBy(dx: 16, dy: 16)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = .byCharWrapping
        
        let attributes: [NSAttributedStringKey : Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle,
        ]
        
        frame.size = NSString(string: text).boundingRect(
            with: frame.size,
            options: .usesLineFragmentOrigin,
            attributes: attributes,
            context: nil
        ).size
        
        return frame
    }
}
