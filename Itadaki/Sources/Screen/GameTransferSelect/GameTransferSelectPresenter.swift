// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol GameTransferSelectPresentable: class {
    
    func loadTransferrings(of station: Station)
}

protocol GameTransferSelectViewable: class {
    
    func showTransferrings(_ transferrings: [Transferring])
}

class GameTransferSelectPresenter: GameTransferSelectPresentable {
    
    weak var view: GameTransferSelectViewable!
    
    init(view: GameTransferSelectViewable) {
        self.view = view
    }
    
    func loadTransferrings(of station: Station) {
        view.showTransferrings(station.transferrings)
    }
}
