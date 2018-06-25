// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol GameMainPresentable: class {
    
}

protocol GameMainViewable: class {
    
}

class GameMainPresenter: GameMainPresentable {
    
    weak var view: GameMainViewable!
    
    init(view: GameMainViewable) {
        self.view = view
    }
}
