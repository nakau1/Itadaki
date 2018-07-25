// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

@objc protocol MessageViewDelegate: NSObjectProtocol {
    
    @objc optional func messageViewDidShowAllText(in messageView: MessageView)
    
    @objc optional func messageView(_ messageView: MessageView, didShowTextAt arrayIndex: Int)
    
    @objc optional func messageView(_ messageView: MessageView, didAnimating textIndex: Int, arrayIndex: Int)
}

class MessageView: UIView {
    
    @IBOutlet weak var delegate: MessageViewDelegate?
    
    var font = UIFont(name: "HiraMaruProN-W4", size: 18)!
    
    var textColor = UIColor.white
    
    var lineBreakMode = NSLineBreakMode.byCharWrapping
    
    var duration: TimeInterval = 0.01
    
    var padding: CGFloat = 16
    
    private var storedTexts = [String]()
    private var arrayIndex = 0
    
    private var storedText = ""
    private var textIndex = 0
    private var shown = false
    private var animating = true
    private var gesture: UITapGestureRecognizer!
    
    private var mainLabel: UILabel!
    private var mainTimer: Timer!
    
    private var nextLabel: UILabel!
    private var nextTimer: Timer!
    
    // MARK: - Show Text
    
    func setTexts(_ texts: [String], animate: Bool = true) {
        makeLabelIfNeeded()
        invalidateTimers()
        
        storedTexts = texts
        if storedTexts.isEmpty { return }
        
        arrayIndex = 0
        animating = animate
        gesture.isEnabled = true
        setText(storedTexts[arrayIndex])
    }
    
   private func setText(_ text: String) {
        storedText = text
        
        if animating {
            showStoredTextWithAnimating()
        } else {
            showStoredText()
        }
    }
    
    private func showStoredTextWithAnimating() {
        shown = false
        updateText("")
        textIndex = 0
        mainTimer = makeMainTimer()
        hideNextLabel()
    }
    
    private func showStoredText() {
        shown = true
        updateText(storedText)
        showNextLabelIfNeeded()
        delegate?.messageView?(self, didShowTextAt: arrayIndex)
        if !existsNext {
            delegate?.messageViewDidShowAllText?(in: self)
            gesture.isEnabled = false
        }
    }
    
    // MARK: - Main Timer
    
    private func makeMainTimer() -> Timer {
        return Timer.scheduledTimer(
            timeInterval: duration,
            target: self,
            selector: #selector(didFireTimer),
            userInfo: nil,
            repeats: false
        )
    }
    
    @objc private func didFireTimer() {
        let text = storedText.substring(start: 0, end: textIndex)
        updateText(text)
        delegate?.messageView?(self, didAnimating: textIndex, arrayIndex: arrayIndex)
        
        textIndex += 1
        if textIndex < storedText.count {
            mainTimer = makeMainTimer()
        } else {
            invalidateMainTimer()
            showStoredText()
        }
    }
    
    private func invalidateMainTimer() {
        if mainTimer != nil && mainTimer.isValid {
            mainTimer.invalidate()
        }
        mainTimer = nil
    }
    
    // MARK: - Next Label
    
    private func makeNextTimer() -> Timer {
        return Timer.scheduledTimer(
            timeInterval: 0.5,
            target: self,
            selector: #selector(didFireNextTimer),
            userInfo: nil,
            repeats: false
        )
    }
    
    @objc private func didFireNextTimer() {
        nextLabel.isHidden = !nextLabel.isHidden
        nextTimer = makeNextTimer()
    }
    
    private func invalidateNextTimer() {
        if nextTimer != nil && nextTimer.isValid {
            nextTimer.invalidate()
        }
        nextTimer = nil
    }
    
    private var existsNext: Bool {
        return arrayIndex < (storedTexts.count - 1)
    }
    
    private func showNextLabelIfNeeded() {
        if existsNext {
            showNextLabel()
        } else {
            hideNextLabel()
        }
    }
    
    private func showNextLabel() {
        invalidateNextTimer()
        nextLabel.isHidden = true // 点滅のために一旦hidden
        nextTimer = makeNextTimer()
    }
    
    private func hideNextLabel() {
        invalidateNextTimer()
        nextLabel.isHidden = true
    }
    
    // MARK: - Self Tap GestureRecognizer
    
    private func makeTapGestureRecognizer() {
        gesture = UITapGestureRecognizer(target: self, action: #selector(didTapSelf))
        addGestureRecognizer(gesture)
    }
    
    @objc private func didTapSelf() {
        invalidateMainTimer()
        
        if shown {
            showNextLabelIfNeeded()
            if existsNext {
                arrayIndex += 1
                setText(storedTexts[arrayIndex])
            } else {
                delegate?.messageViewDidShowAllText?(in: self)
                gesture.isEnabled = false
            }
        } else {
            showStoredText()
        }
    }
    
    // MARK: - Make UI Components
    
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
    
    // MARK: - Other
    
    private func updateText(_ text: String) {
        mainLabel.frame = mainLabelFrame(of: text)
        mainLabel.text = text
    }
    
    private func invalidateTimers() {
        invalidateMainTimer()
        invalidateNextTimer()
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
    
    // MARK: - Deinit
    
    deinit {
        invalidateTimers()
    }
}
