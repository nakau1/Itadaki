// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol GameRoulettePresentable: class {
    
}

protocol GameRouletteViewable: class {
    
}

class GameRoulettePresenter: GameRoulettePresentable {
    
    weak var view: GameRouletteViewable!
    
    init(view: GameRouletteViewable) {
        self.view = view
    }
}
