// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol GameTransferSelectPresentable: class {
    
}

protocol GameTransferSelectViewable: class {
    
}

class GameTransferSelectPresenter: GameTransferSelectPresentable {
    
    weak var view: GameTransferSelectViewable!
    
    init(view: GameTransferSelectViewable) {
        self.view = view
    }
}
