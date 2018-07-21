// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

@objc protocol MessageViewDelegate: NSObjectProtocol {
    
    func messageViewDidShowText(_ messageView: MessageView)
    
    @objc optional func messageViewDidAnimaing(_ messageView: MessageView, index: Int)
}

class MessageView: UIView {
    
    weak var delegate: MessageViewDelegate?
    
    var font = UIFont(name: "HiraMaruProN-W4", size: 18)!
    
    var textColor = UIColor.white
    
    var lineBreakMode = NSLineBreakMode.byCharWrapping
    
    var duration: TimeInterval = 0.01
    
    var padding: CGFloat = 16
    
    var existsNext = true
    
    private var storedText = ""
    private var index = 0
    private var shown = false
    
    private var mainLabel: UILabel!
    private var mainTimer: Timer!
    
    private var nextLabel: UILabel!
    private var nextTimer: Timer!
    
    func setText(_ text: String, animate: Bool) {
        makeLabelIfNeeded()
        invalidateTimers()
        storedText = text
        
        if animate {
            showAllTextWithAnimating()
        } else {
            showAllText()
        }
    }
    
    private func showAllTextWithAnimating() {
        shown = false
        updateText("")
        index = 0
        mainTimer = makeMainTimer()
        hideNextLabel()
    }
    
    private func updateText(_ text: String) {
        mainLabel.frame = mainLabelFrame(of: text)
        mainLabel.text = text
    }
    
    private func showAllText() {
        shown = true
        updateText(storedText)
        
        if existsNext {
            showNextLabel()
        } else {
            hideNextLabel()
        }
    }
    
    @objc private func didFireTimer() {
        let text = storedText.substring(start: 0, end: index)
        updateText(text)
        delegate?.messageViewDidAnimaing?(self, index: index)
        
        index += 1
        if index < storedText.count {
            mainTimer = makeMainTimer()
        } else {
            mainTimer.invalidate()
            shown = true
            if existsNext {
                showNextLabel()
            }
        }
    }
    
    @objc private func didFireNextTimer() {
        nextLabel.isHidden = !nextLabel.isHidden
        nextTimer = makeNextTimer()
    }
    
    @objc private func didTapSelf() {
        invalidateMainTimer()
        
        if shown {
            delegate?.messageViewDidShowText(self)
        } else {
            showAllText()
        }
    }
    
    private func showNextLabel() {
        if !existsNext {
            nextLabel.isHidden = true
            return
        }
        nextTimer = makeNextTimer()
    }
    
    private func hideNextLabel() {
        nextLabel.isHidden = true
    }
    
    private func makeMainTimer() -> Timer {
        return Timer.scheduledTimer(
            timeInterval: duration,
            target: self,
            selector: #selector(didFireTimer),
            userInfo: nil,
            repeats: false
        )
    }
    
    private func makeNextTimer() -> Timer {
        return Timer.scheduledTimer(
            timeInterval: 0.5,
            target: self,
            selector: #selector(didFireNextTimer),
            userInfo: nil,
            repeats: false
        )
    }
    
    private func makeLabelIfNeeded() {
        if mainLabel == nil {
            makeMainLabel()
            makeNextLabel()
            makeTapGestureRecognizer()
        }
    }
    
    private func makeMainLabel() {
        mainLabel = UILabel(frame: .zero)
        mainLabel.font = font
        mainLabel.textColor = textColor
        mainLabel.numberOfLines = 0
        mainLabel.lineBreakMode = lineBreakMode
        addSubview(mainLabel)
    }
    
    private func makeNextLabel() {
        let frame = CGRect(
            (bounds.width - 20) / 2,
            bounds.height - 24,
            20,
            20
        )
        nextLabel = UILabel(frame: frame)
        nextLabel.font = UIFont.boldSystemFont(ofSize: 12)
        nextLabel.textColor = textColor
        nextLabel.text = "▼"
        addSubview(nextLabel)
    }
    
    private func makeTapGestureRecognizer() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapSelf))
        addGestureRecognizer(gesture)
    }
    
    private func mainLabelFrame(of text: String) -> CGRect {
        var frame = bounds.insetBy(dx: padding, dy: padding)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineBreakMode = lineBreakMode
        
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
    
    private func invalidateTimers() {
        invalidateMainTimer()
        invalidateNextTimer()
    }
    
    private func invalidateMainTimer() {
        if mainTimer != nil && mainTimer.isValid {
            mainTimer.invalidate()
        }
        mainTimer = nil
    }
    
    private func invalidateNextTimer() {
        if nextTimer != nil && nextTimer.isValid {
            nextTimer.invalidate()
        }
        nextTimer = nil
    }
    
    deinit {
        invalidateTimers()
    }
}
