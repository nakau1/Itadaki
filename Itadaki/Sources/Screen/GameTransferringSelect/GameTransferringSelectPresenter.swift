// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

protocol GameTransferringSelectPresentable: class {
    
    var transferrings: [Transferring] { get }
    
    func loadTransferrings(of station: Station)
}

protocol GameTransferringSelectViewable: class {
    
    func showTransferrings()
}

class GameTransferringSelectPresenter: GameTransferringSelectPresentable {
    
    weak var view: GameTransferringSelectViewable!
    
    private(set) var transferrings = [Transferring]()
    
    init(view: GameTransferringSelectViewable) {
        self.view = view
    }
    
    func loadTransferrings(of station: Station) {
        transferrings = station.transferrings
        view.showTransferrings()
    }
}
