// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

@objc protocol RouletteDelegate: NSObjectProtocol {
    
    @objc optional func messageViewDidShowAllText(in messageView: MessageView)
    
    @objc optional func messageView(_ messageView: MessageView, didShowTextAt arrayIndex: Int)
    
    @objc optional func messageView(_ messageView: MessageView, didAnimating textIndex: Int, arrayIndex: Int)
}

class Roulette {
    
    @IBOutlet weak var delegate: RouletteDelegate?
    
    
}
