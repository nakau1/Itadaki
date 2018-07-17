// =============================================================================
//  Itadaki
//  Copyright Yuichi Nakayasu. All rights reserved.
// =============================================================================
import UIKit

class GameTransferSelectViewController: MainContentsViewController {
    
    private var presenter: GameTransferSelectPresentable!
    private var station: Station!

    @IBOutlet private weak var adapter: GameTransferSelectAdapter!
    
    class func push(to main: MainViewController, station: Station) {
        main.push(contents: GameTransferSelectViewController.create(station: station))
        main.push(control: GameListSelectControlViewController.create())
    }
    
    class func create(station: Station) -> MainContentsViewController {
        let vc = instantiate(self)
        vc.presenter = GameTransferSelectPresenter(view: vc)
        vc.station = station
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adapter.delegate = self
        presenter.loadTransferrings(of: station)
    }
}

extension GameTransferSelectViewController: GameTransferSelectViewable {
    
    func showTransferrings() {
        adapter.reload()
    }
}

extension GameTransferSelectViewController: GameTransferSelectAdapterDelegate {
    
    func numberOfItems(transferSelectAdapter: GameTransferSelectAdapter) -> Int {
        return presenter.transferrings.count
    }
    
    func transferSelectAdapter(_ transferSelectAdapter: GameTransferSelectAdapter, transferringAt index: Int) -> Transferring! {
        return presenter.transferrings[index]
    }
}
