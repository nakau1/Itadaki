// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol GameMessagePresentable: class {
    
}

protocol GameMessageViewable: class {
    
}

class GameMessagePresenter: GameMessagePresentable {
    
    weak var view: GameMessageViewable!
    
    init(view: GameMessageViewable) {
        self.view = view
    }
}
