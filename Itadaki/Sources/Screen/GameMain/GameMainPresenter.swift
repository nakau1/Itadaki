// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol GameMainPresentable: class {
    
    var direction: DestinationDirection { get set }
}

protocol GameMainViewable: class {
    
}

class GameMainPresenter: GameMainPresentable {
    
    weak var view: GameMainViewable!
    
    var direction = DestinationDirection.ascending
    
    init(view: GameMainViewable) {
        self.view = view
    }
}
