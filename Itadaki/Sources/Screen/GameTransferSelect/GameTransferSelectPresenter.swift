// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol GameTransferSelectPresentable: class {
    
    var transferrings: [Transferring] { get }
    
    func loadTransferrings(of station: Station)
}

protocol GameTransferSelectViewable: class {
    
    func showTransferrings()
}

class GameTransferSelectPresenter: GameTransferSelectPresentable {
    
    weak var view: GameTransferSelectViewable!
    
    private(set) var transferrings = [Transferring]()
    
    init(view: GameTransferSelectViewable) {
        self.view = view
    }
    
    func loadTransferrings(of station: Station) {
        transferrings = station.transferrings
        view.showTransferrings()
    }
}
